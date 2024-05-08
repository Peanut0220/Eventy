using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class memberLogin : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["memberID"]!=null)
            {
                Response.Redirect("~/memberHome.aspx");
            }
            if (Session["staffID"] != null)
            {
                Response.Redirect("~/staffDashboard.aspx");
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;
            form1.DefaultButton = "LinkButton2";
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;
            form1.DefaultButton = "LinkButton1";
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string email = TextBox1.Text;
            string sessionEmail ="";
            string password = TextBox2.Text;
           
            int memberID = 0;
            int cartID = 0;
            var hash = "";
            con.Open();
            string strSelect = "SELECT Member.password, Member.memberID ,Cart.cartID, Member.email FROM Member INNER JOIN Cart ON Cart.memberID = Member.memberID where email=@email GROUP BY Member.password, Member.memberID ,Cart.cartID, Member.email";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@email", email);
            SqlDataReader dtrCart = cmdSelect.ExecuteReader();
            

            while (dtrCart.Read())
            {
                hash = dtrCart["password"].ToString();
                memberID = Convert.ToInt32(dtrCart["memberID"]);
                cartID = Convert.ToInt32(dtrCart["cartID"]);
                sessionEmail = dtrCart["email"].ToString();
            }
            con.Close();

            try
            {
                var result = SecurePasswordHasher.Verify(password, hash);

                if (result == true)
                {
                    Session["memberID"] = memberID;
                    Session["cartID"] = cartID;
                    Session["email"] = sessionEmail;
                    Response.Write("<script>alert('Login Successfully!');window.location.replace(\"memberHome.aspx\");</script>");
                }
                else
                {
                    Response.Write("<script>alert('Wrong Email or password');</script>");
                }


            
            }catch(Exception ex)
            {
                Response.Write("<script>alert('Wrong Email or password');</script>");
            }
               
            
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

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string email = TextBox3.Text;
            string sessionEmail = "";
            string password = TextBox4.Text;
            string role = "";
            int staffID = 0;
          
            var hash = "";
            con.Open();
            string strSelect = "SELECT Staff.password, Staff.staffID ,Staff.role, Staff.email FROM Staff where Staff.email=@email GROUP BY Staff.password, Staff.staffID ,Staff.role, Staff.email";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@email", email);
            SqlDataReader dtrCart = cmdSelect.ExecuteReader();


            while (dtrCart.Read())
            {
                hash = dtrCart["password"].ToString();
                staffID = Convert.ToInt32(dtrCart["staffID"]);
                role = dtrCart["role"].ToString();
                sessionEmail = dtrCart["email"].ToString();
            }
            con.Close();

            try
            {
                var result = SecurePasswordHasher.Verify(password, hash);

                if (result == true)
                {
                    Session["staffID"] = staffID;
                    Session["staffRole"] = role;
                    Session["staffEmail"] = sessionEmail;
                    Response.Write("<script>alert('Login Successfully!');window.location.replace(\"staffHome.aspx\");</script>");
                }
                else
                {
                    Response.Write("<script>alert('Wrong Email or password');</script>");
                }



            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Wrong Email or password');</script>");
            }


        }

       
        
    }
}