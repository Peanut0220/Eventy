using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class memberRegister : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Page.Validate();/*Control validation group name optional*/
                if (Page.IsValid)
                {
                    string input = TextBox2.Text;
                    string inputIC = TextBox3.Text;
                    string email = "";
                    string IC = "";


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
                        }

                    }
                    con.Close();

                    con.Open();
                    string strSelect2 = "SELECT * FROM Staff where email=@email";
                    SqlCommand cmdSelect2 = new SqlCommand(strSelect2, con);
                    cmdSelect2.Parameters.AddWithValue("@email", input);
                    SqlDataReader dtrCart2 = cmdSelect2.ExecuteReader();

                    if (dtrCart2.HasRows)
                    {
                        while (dtrCart2.Read())
                        {
                            email = dtrCart2["email"].ToString();
                        }

                    }
                    con.Close();

                    if (email == "")
                    {
                        con.Open();
                        strSelect = "SELECT * FROM Member where IC=@IC";
                        cmdSelect = new SqlCommand(strSelect, con);
                        cmdSelect.Parameters.AddWithValue("@IC", inputIC);
                        dtrCart = cmdSelect.ExecuteReader();

                        if (dtrCart.HasRows)
                        {
                            while (dtrCart.Read())
                            {
                                IC = dtrCart["IC"].ToString();
                            }
                        }
                        con.Close();

                        if (IC == "")
                        {
                            Session["name"] = TextBox1.Text;
                            Session["email"] = TextBox2.Text;
                            Session["IC"] = TextBox3.Text;
                            Session["phone"] = TextBox5.Text;
                            Session["emergency"] = TextBox6.Text;
                            Session["address"] = TextBox7.Text;
                            Session["password"] = password.Text;
                            Session["confirmPassword"] = confirmPassword.Text;
                            Response.Write("<script>alert('Continue to validate your email!');window.location.replace(\"activateAccount.aspx\");</script>");

                        }
                        else
                        {
                            Response.Write("<script>alert('An Account has already registered with this IC!');</script>");
                        }


                    }
                    else
                    {
                        Response.Write("<script>alert('This email has already been registered!');</script>");
                    }



                }
            }
        }
    }
}