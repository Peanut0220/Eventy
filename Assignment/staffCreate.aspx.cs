using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class staffCreate : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
            if (Session["staffRole"].ToString() != "Manager")
            {
                Response.Redirect("~/staffRestricted.aspx");
            }

            txtDate.Text = DateTime.Now.ToShortDateString();

        }

        protected void btnEventAdd_Click(object sender, EventArgs e)
        {
            int found = 0;
            if (IsPostBack)
            {
                Page.Validate();/*Control validation group name optional*/
                if (Page.IsValid)

                {
                    con.Open();
                    string strCompare4 = "Select * From Member where email=@email ";
                    SqlCommand cmdCompare4 = new SqlCommand(strCompare4, con);
                    cmdCompare4.Parameters.AddWithValue("@email", txtStaffEmail.Text);
                    SqlDataReader dtrMmber4 = cmdCompare4.ExecuteReader();
                    if (dtrMmber4.HasRows)
                    {
                        found = 2;
                    }

                    con.Close();

                    con.Open();
                    string strCompare = "Select * From Staff where IC=@IC ";
                    SqlCommand cmdCompare = new SqlCommand(strCompare, con);
                    cmdCompare.Parameters.AddWithValue("@IC", txtStaffIC.Text);
                    SqlDataReader dtrMmber = cmdCompare.ExecuteReader();
                    if (dtrMmber.HasRows)
                    {
                        found = 1;
                    }

                    con.Close();

                    con.Open();
                    string strCompare2 = "Select * From Staff where email=@email";
                    SqlCommand cmdCompare2 = new SqlCommand(strCompare2, con);
                    cmdCompare2.Parameters.AddWithValue("@email", txtStaffEmail.Text);
                    SqlDataReader dtrMmber2 = cmdCompare2.ExecuteReader();
                    if (dtrMmber2.HasRows)
                    {
                        found = 2;
                    }

                    con.Close();

                    con.Open();
                    string strCompare3 = "Select * From Staff where phoneNo=@phoneNo ";
                    SqlCommand cmdCompare3 = new SqlCommand(strCompare3, con);
                    cmdCompare3.Parameters.AddWithValue("@phoneNo", txtStaffPhoneNo.Text);
                    SqlDataReader dtrMmber3 = cmdCompare3.ExecuteReader();
                    if (dtrMmber3.HasRows)
                    {
                        found = 3;
                    }

                    con.Close();

                    if (found == 0)
                    {
                        string hash = SecurePasswordHasher.Hash(txtStaffIC.Text);
                        string strAdd = "Insert Into Staff(name,phoneNo,password,IC,address,emergencyContact,joinedDate,email,role,isArchive) Values (@name,@phoneNo,@password,@IC,@address,@emergencyContact,@joinedDate,@email,@role,@isArchive)";
                        SqlCommand cmdAdd = new SqlCommand(strAdd, con);
                        cmdAdd.Parameters.AddWithValue("@name", txtStaffName.Text);
                        cmdAdd.Parameters.AddWithValue("@phoneNo", txtStaffPhoneNo.Text);
                        cmdAdd.Parameters.AddWithValue("@password", hash);
                        cmdAdd.Parameters.AddWithValue("@IC", txtStaffIC.Text);
                        cmdAdd.Parameters.AddWithValue("@address", txtStaffAddress.Text);
                        cmdAdd.Parameters.AddWithValue("@emergencyContact", txtStaffEmergencyContact.Text);
                        cmdAdd.Parameters.AddWithValue("@joinedDate", DateTime.Now);
                        cmdAdd.Parameters.AddWithValue("@email", txtStaffEmail.Text);
                        cmdAdd.Parameters.AddWithValue("@role", rblStaffRole.SelectedValue);
                        cmdAdd.Parameters.AddWithValue("@isArchive", 0);

                        con.Open();
                        int n = cmdAdd.ExecuteNonQuery();

                        con.Close();
                        if (n > 0)
                        {
                            Response.Write("<script> alert('Staff is added'); </script>");
                            Response.Write("<script>  window.location.replace(\'/staff.aspx\') </script>");
                        }

                        else
                            Response.Write("<script> alert('Staff unsuccessfully added'); </script>");

                    }
                    else if (found == 1)
                    {
                        Response.Write("<script> alert('An Account has already registered with this IC!'); </script>");
                    }

                    else if (found == 2)
                    {
                        Response.Write("<script> alert('An Account has already registered with this email!'); </script>");
                    }
                    else if (found == 3)
                    {
                        Response.Write("<script> alert('An Account has already registered with this phoneNo!'); </script>");
                    }
                }
            }
        }

        protected void btnEventReset_Click(object sender, EventArgs e)
        {
            txtStaffName.Text = "";
            txtStaffIC.Text = "";
            txtStaffPhoneNo.Text = "";
            txtStaffEmail.Text = "";
            txtStaffAddress.Text = "";
            txtStaffEmergencyContact.Text = "";
            rblStaffRole.ClearSelection();


        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {

        }
        public static class SecurePasswordHasher
        {
            /// <summary>
            /// Size of salt.
            /// </summary>
            private const int SaltSize = 16;

            /// <summary>
            /// Size of hash.
            /// </summary>
            private const int HashSize = 20;

            /// <summary>
            /// Creates a hash from a password.
            /// </summary>
            /// <param name="password">The password.</param>
            /// <param name="iterations">Number of iterations.</param>
            /// <returns>The hash.</returns>
            public static string Hash(string password, int iterations)
            {
                // Create salt
                byte[] salt;
                new RNGCryptoServiceProvider().GetBytes(salt = new byte[SaltSize]);

                // Create hash
                var pbkdf2 = new Rfc2898DeriveBytes(password, salt, iterations);
                var hash = pbkdf2.GetBytes(HashSize);

                // Combine salt and hash
                var hashBytes = new byte[SaltSize + HashSize];
                Array.Copy(salt, 0, hashBytes, 0, SaltSize);
                Array.Copy(hash, 0, hashBytes, SaltSize, HashSize);

                // Convert to base64
                var base64Hash = Convert.ToBase64String(hashBytes);

                // Format hash with extra information
                return string.Format("$MYHASH$V1${0}${1}", iterations, base64Hash);
            }

            /// <summary>
            /// Creates a hash from a password with 10000 iterations
            /// </summary>
            /// <param name="password">The password.</param>
            /// <returns>The hash.</returns>
            public static string Hash(string password)
            {
                return Hash(password, 10000);
            }

            /// <summary>
            /// Checks if hash is supported.
            /// </summary>
            /// <param name="hashString">The hash.</param>
            /// <returns>Is supported?</returns>
            public static bool IsHashSupported(string hashString)
            {
                return hashString.Contains("$MYHASH$V1$");
            }

            /// <summary>
            /// Verifies a password against a hash.
            /// </summary>
            /// <param name="password">The password.</param>
            /// <param name="hashedPassword">The hash.</param>
            /// <returns>Could be verified?</returns>
            public static bool Verify(string password, string hashedPassword)
            {
                // Check hash
                if (!IsHashSupported(hashedPassword))
                {
                    throw new NotSupportedException("The hashtype is not supported");
                }

                // Extract iteration and Base64 string
                var splittedHashString = hashedPassword.Replace("$MYHASH$V1$", "").Split('$');
                var iterations = int.Parse(splittedHashString[0]);
                var base64Hash = splittedHashString[1];

                // Get hash bytes
                var hashBytes = Convert.FromBase64String(base64Hash);

                // Get salt
                var salt = new byte[SaltSize];
                Array.Copy(hashBytes, 0, salt, 0, SaltSize);

                // Create hash with given salt
                var pbkdf2 = new Rfc2898DeriveBytes(password, salt, iterations);
                byte[] hash = pbkdf2.GetBytes(HashSize);

                // Get result
                for (var i = 0; i < HashSize; i++)
                {
                    if (hashBytes[i + SaltSize] != hash[i])
                    {
                        return false;
                    }
                }
                return true;
            }
        }
    }
}