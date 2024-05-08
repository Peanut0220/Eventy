using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class resetPassLink : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");
        protected void Page_Load(object sender, EventArgs e)
        {
            string email = "";
            email = Request.QueryString["email"];
            string token = "";
            token = Request.QueryString["token"];
            string type = "";
            type = Request.QueryString["type"];
            Session["type"] = type;
            DateTime createDate = new DateTime(2000, 01, 01);
            if (email != "" && token != "" && type != "" && email != null && token != null && type != null)
            {
                con.Open();
                string strSelect = "SELECT * FROM ResetPassOTP where email=@email and token=@token";
                SqlCommand cmdSelect = new SqlCommand(strSelect, con);
                cmdSelect.Parameters.AddWithValue("@email", email);
                cmdSelect.Parameters.AddWithValue("@token", token);
                SqlDataReader dtrCart = cmdSelect.ExecuteReader();


                while (dtrCart.Read())
                {
                    createDate = Convert.ToDateTime(dtrCart["createdDate"]);
                }

                if (createDate != new DateTime(2000, 01, 01))
                {
                    TimeSpan ts = DateTime.Now - createDate;
                    if (ts.TotalMinutes > 5)
                    {
                        Response.Write("<script>alert('This Link Has Expired, Please proceed to request the link again!');window.location.replace(\"resetPass.aspx\");</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('Invalid Reset Link Page!');window.location.replace(\"resetPass.aspx\");</script>");
                }


                con.Close();
            }
            else
            {
                Response.Write("<script>alert('Invalid Reset Link Page!');window.location.replace(\"resetPass.aspx\");</script>");
            }

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["type"] == "member")
            {
                string pass = password.Text;

                string hash = SecurePasswordHasher.Hash(pass);
                con.Open();
                string strUpdate = "Update Member Set password=@password where email=@email";
                SqlCommand cmdUpdate = new SqlCommand(strUpdate, con);
                cmdUpdate.Parameters.AddWithValue("@password", hash);
                cmdUpdate.Parameters.AddWithValue("@email", Request.QueryString["email"].ToString());
                cmdUpdate.ExecuteNonQuery();
                con.Close();
                Response.Write("<script>alert('Password Changed Successfully!');window.location.replace(\"memberLogin.aspx\");</script>");
            }
            else
            {
                string pass = password.Text;

                string hash = SecurePasswordHasher.Hash(pass);
                con.Open();
                string strUpdate = "Update Staff Set password=@password where email=@email";
                SqlCommand cmdUpdate = new SqlCommand(strUpdate, con);
                cmdUpdate.Parameters.AddWithValue("@password", hash);
                cmdUpdate.Parameters.AddWithValue("@email", Request.QueryString["email"].ToString());
                cmdUpdate.ExecuteNonQuery();
                con.Close();
                Response.Write("<script>alert('Password Changed Successfully!');window.location.replace(\"memberLogin.aspx\");</script>");
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
    }
}