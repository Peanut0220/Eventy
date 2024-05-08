using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class resetPass : System.Web.UI.Page
    {
        Random rand = new Random();
        public const string Alphabet =
"abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
           
            string input = TextBox3.Text;
            string email = "";
            int found = 0;
            string type = "";

            con.Open();
            string strSelect = "SELECT * FROM Member where email=@email";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@email", input);
            SqlDataReader dtrCart = cmdSelect.ExecuteReader();

            if (dtrCart.HasRows)
            {
                while (dtrCart.Read())
                {
                    email = dtrCart["email"].ToString();
                    found = 1;
                    type = "member";
                }

            }
            con.Close();
            if (found != 1)
            {
                con.Open();
                strSelect = "SELECT * FROM Staff where email=@email";
                cmdSelect = new SqlCommand(strSelect, con);
                cmdSelect.Parameters.AddWithValue("@email", input);
                dtrCart = cmdSelect.ExecuteReader();

                if (dtrCart.HasRows)
                {
                    while (dtrCart.Read())
                    {
                        email = dtrCart["email"].ToString();
                        type = "staff";
                    }

                }
                con.Close();
            }

            if (email != "")
            {
                Session.Abandon();
                string token = GenerateString(20);
                con.Open();
                string strInsert = "Insert Into ResetPassOTP (email,createdDate,token) Values (@email,@createdDate,@token)";
                SqlCommand cmdInsert = new SqlCommand(strInsert, con);
                cmdInsert.Parameters.AddWithValue("@email", email);
                cmdInsert.Parameters.AddWithValue("@createdDate", DateTime.Now);
                cmdInsert.Parameters.AddWithValue("@token", token);
                cmdInsert.ExecuteNonQuery();
                con.Close();

                string to = email; //To address    
                string from = "eventy366@gmail.com"; //From address    
                MailMessage message = new MailMessage(from, to);

                string mailbody = "<html><body><div><p>Click On The Link below to reset your password</p><h3>https://localhost:44365/resetPassLink.aspx?email="+ email +"&token="+ token + "&type="+type+"</h3><h3>Link will be expired in 5 minutes</h3><p>DO NOT SHARE TO OTHERS</p></div></body></html>";


                message.Subject = "Eventy Reset Password Link";
                message.Body = mailbody;
                message.BodyEncoding = Encoding.UTF8;
                message.IsBodyHtml = true;
                SmtpClient client = new SmtpClient("smtp.gmail.com", 587); //Gmail smtp    
                client.UseDefaultCredentials = false;
                client.Credentials = new NetworkCredential("eventy366@gmail.com", "srbd qtvb pubt zqfs");
                client.EnableSsl = true;
                client.Send(message);
  


                Response.Write("<script>alert('An Link Has Been Sent to Your Email, Please Check It Out.');</script>");

            }
            else
            {
                Response.Write("<script>alert('This email has not been registered yet!');</script>");
            }
        }

        public string GenerateString(int size)
        {
            char[] chars = new char[size];
            for (int i = 0; i < size; i++)
            {
                chars[i] = Alphabet[rand.Next(Alphabet.Length)];
            }
            return new string(chars);
        }
    }
}