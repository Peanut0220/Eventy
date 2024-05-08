using PayPal.Api;
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
    public partial class staffProfile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }





        }

        protected void btnEdit(object sender, EventArgs e)
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


        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            RepeaterItem item = Repeater2.Items[0];
            TextBox name = (TextBox)item.FindControl("txtStaffProfileName2");
            TextBox phone = (TextBox)item.FindControl("txtStaffProfilePhoneNo");
            Label phone2 = (Label)item.FindControl("Label4");
            TextBox contact = (TextBox)item.FindControl("txtStaffEmergencyContact");
            TextBox address = (TextBox)item.FindControl("txtStaffAddress");
            Label id = (Label)item.FindControl("Label1");
            int found = 0;
            
                Page.Validate();/*Control validation group name optional*/
                if (Page.IsValid)
                {
               
                if (phone.Text != phone2.Text)
                    {
                        con.Open();
                        string strCompare = "Select * From Staff where phoneNo=@phoneNo ";
                        SqlCommand cmdCompare = new SqlCommand(strCompare, con);
                        cmdCompare.Parameters.AddWithValue("@phoneNo", phone.Text);
                        SqlDataReader dtrMmber = cmdCompare.ExecuteReader();
                        if (dtrMmber.HasRows)
                        {
                            found = 1;
                        }

                        con.Close();
                    }

                    if (found == 0)
                    {
                        

                        string strEdit = "Update Staff Set name=@name,phoneNo=@phoneNo,address=@address,emergencyContact=@emergencyContact Where staffID=@staffID";
                        SqlCommand cmdEdit = new SqlCommand(strEdit, con);
                        cmdEdit.Parameters.AddWithValue("@name", name.Text);
                        cmdEdit.Parameters.AddWithValue("@phoneNo", phone.Text);
                        cmdEdit.Parameters.AddWithValue("@address", address.Text);
                        cmdEdit.Parameters.AddWithValue("@emergencyContact", contact.Text);
                        cmdEdit.Parameters.AddWithValue("@staffID", Convert.ToInt32(Session["staffID"].ToString()));

                        con.Open();
                        int n = cmdEdit.ExecuteNonQuery();

                        con.Close();
                        if (n > 0)
                            Response.Write("<script> alert('Profile is successfully edit');window.location.replace('/staffProfile.aspx') </script>");

                        else
                            Response.Write("<script> alert('Profile unsuccessfully added'); </script>");

                    }
                    else if (found == 1)
                    {
                        Response.Write("<script> alert('An Account has already registered with this phoneNo!'); </script>");
                    }

                
            }
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            Response.Write("<script> window.location.replace('/resetPass.aspx') </script>");
        }

        protected void ImageBack1_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;

        }
        protected void txtStaffProfileName2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownList1_PreRender(object sender, EventArgs e)
        {
            string ic = "";

            int staffID = 0;

            var hash = "";
            con.Open();
            string strSelect = "SELECT Staff.password, Staff.staffID,Staff.IC FROM Staff where Staff.staffID=@staffID GROUP BY Staff.password, Staff.staffID, Staff.IC";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@staffID", Convert.ToInt32(Session["staffID"].ToString()));
            SqlDataReader dtrCart = cmdSelect.ExecuteReader();


            while (dtrCart.Read())
            {
                hash = dtrCart["password"].ToString();
                staffID = Convert.ToInt32(dtrCart["staffID"]);
                ic = dtrCart["IC"].ToString();


            }
            con.Close();

            try
            {
                var result = SecurePasswordHasher.Verify(ic, hash);

                if (result == true)
                {
                    Session["staffID"] = staffID;
                    Response.Write("<script>var result = confirm('Your password is default!Do you want to change password?'); if (result) { window.location.replace('/resetPass.aspx'); } else {  }</script>");

                }
                else
                {

                }



            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Wrong Email or password');</script>");
            }


        }
    }
}