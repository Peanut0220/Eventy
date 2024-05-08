using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Security.Cryptography;

namespace Assignment
{
    public partial class activateAccount : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["email"] == null)
            {
                Response.Redirect("~/memberRegister.aspx");
            }
            
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string otpCode = "";
            int memberID = 0;
            string input = TextBox3.Text;
            DateTime createDate = new DateTime(2000, 01, 01);
            con.Open();
            string strSelect = "SELECT TOP 1 * FROM RegisterOTP where email=@email ORDER BY Id DESC";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@email", Session["email"].ToString());
            SqlDataReader dtrCart = cmdSelect.ExecuteReader();

            while (dtrCart.Read())
            {
                otpCode = dtrCart["otpCode"].ToString();
                createDate = Convert.ToDateTime(dtrCart["createdDate"]);
            }
            con.Close();


            if (otpCode ==input)
            {
                if (createDate != new DateTime(2000, 01, 01))
                {
                    TimeSpan ts = DateTime.Now - createDate;
                    if (ts.TotalMinutes > 5)
                    {
                        Response.Write("<script>alert('This OTP Code Has Expired, Please proceed to request the OTP Code again!');</script>");
                    }
                    else
                    {
                        string hash = SecurePasswordHasher.Hash(Session["password"].ToString());
                        con.Open();
                        string strInsert = "Insert Into Member (name, email,phoneNo,password,joinedDate,emergencyContact,address,IC) Values (@name, @email,@phoneNo,@password,@joinedDate,@emergencyContact,@address,@IC)";
                        SqlCommand cmdInsert = new SqlCommand(strInsert, con);
                        cmdInsert.Parameters.AddWithValue("@name", Session["name"].ToString());
                        cmdInsert.Parameters.AddWithValue("@email", Session["email"].ToString());
                        cmdInsert.Parameters.AddWithValue("@phoneNo", Session["phone"].ToString());
                        cmdInsert.Parameters.AddWithValue("@password", hash);
                        cmdInsert.Parameters.AddWithValue("@joinedDate", DateTime.Now);
                        cmdInsert.Parameters.AddWithValue("@emergencyContact", Session["emergency"].ToString());
                        cmdInsert.Parameters.AddWithValue("@address", Session["address"].ToString());
                        cmdInsert.Parameters.AddWithValue("@IC", Session["IC"].ToString());
                        cmdInsert.ExecuteNonQuery();
                        con.Close();

                        con.Open();
                        strSelect = "SELECT * FROM Member where email=@email";
                        cmdSelect = new SqlCommand(strSelect, con);
                        cmdSelect.Parameters.AddWithValue("@email", Session["email"].ToString());
                        dtrCart = cmdSelect.ExecuteReader();

                        while (dtrCart.Read())
                        {
                            memberID = Convert.ToInt32(dtrCart["memberID"]);
                        }
                        con.Close();

                        con.Open();
                        strInsert = "Insert Into Cart (cartTotal,memberID) Values (@cartTotal,@memberID)";
                        cmdInsert = new SqlCommand(strInsert, con);
                        cmdInsert.Parameters.AddWithValue("@cartTotal", 0);
                        cmdInsert.Parameters.AddWithValue("@memberID", memberID);
                        cmdInsert.ExecuteNonQuery();
                        con.Close();

                        Session.Clear();
                        Response.Write("<script>alert('Activated Successfully!');window.location.replace(\"memberLogin.aspx\");</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('Wrong OTP Code! Please Try Again!');</script>");
                }
               
            }
            else
            {
                Response.Write("<script>alert('Wrong OTP Code! Please Try Again!');</script>");
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Random generator = new Random();
            string code = generator.Next(0, 1000000).ToString("D6");

            con.Open();
            string strUpdate = "Insert Into RegisterOTP (otpCode,email,createdDate) Values (@otpCode,@email,@createdDate)";
            SqlCommand cmdUpdate = new SqlCommand(strUpdate, con);
            cmdUpdate.Parameters.AddWithValue("@otpCode", code);
            cmdUpdate.Parameters.AddWithValue("@email", Session["email"].ToString());
            cmdUpdate.Parameters.AddWithValue("@createdDate", DateTime.Now);
            cmdUpdate.ExecuteNonQuery();
            con.Close();

            string to = Session["email"].ToString(); //To address    
            string from = "eventy366@gmail.com"; //From address    
            MailMessage message = new MailMessage(from, to);

            string mailbody = "<html><body><div><p>Your OTP code is </p><h1>" + code + "</h1><h3>Code will be expired in 5 minutes</h3><p>DO NOT SHARE TO OTHERS</p></div></body></html>";


            message.Subject = "Eventy OTP Code For Member Registration";
            message.Body = mailbody;
            message.BodyEncoding = Encoding.UTF8;
            message.IsBodyHtml = true;
            SmtpClient client = new SmtpClient("smtp.gmail.com", 587); //Gmail smtp    
            client.UseDefaultCredentials = false;
            client.Credentials = new NetworkCredential("eventy366@gmail.com", "srbd qtvb pubt zqfs");
            client.EnableSsl = true;
            client.Send(message);
            Response.Write("<script>alert('OTP Code has been sent to your email!');</script>");


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