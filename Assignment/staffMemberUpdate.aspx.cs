using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class staffMemberUpdate : System.Web.UI.Page
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
            if (Request.QueryString["memberID"] == null)
            {
                Response.Redirect("~/staffMember.aspx");
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int found = 0;
            RepeaterItem item = Repeater1.Items[0];
            TextBox name = (TextBox)item.FindControl("txtMemberNameUpdate");
            TextBox IC = (TextBox)item.FindControl("txtIC");
            TextBox contact = (TextBox)item.FindControl("txtEmergencyContact");
            TextBox address = (TextBox)item.FindControl("txtAddress");
            TextBox email = (TextBox)item.FindControl("txtMemberEmailUpdate");
            TextBox phone = (TextBox)item.FindControl("txtMemberPhoneNoUpdate");
            Label id = (Label)item.FindControl("Label1");
            Label phoneNo2 = (Label)item.FindControl("Label2");
            Label email2 = (Label)item.FindControl("Label3");
            Label IC2 = (Label)item.FindControl("Label4");
            Page.Validate();/*Control validation group name optional*/
            if (Page.IsValid)

            {
                if (IC.Text != IC2.Text)
                {
                    con.Open();
                    string strCompare = "Select * From Member where IC=@IC ";
                    SqlCommand cmdCompare = new SqlCommand(strCompare, con);
                    cmdCompare.Parameters.AddWithValue("@IC", IC.Text);
                    SqlDataReader dtrMmber = cmdCompare.ExecuteReader();
                    if (dtrMmber.HasRows)
                    {
                        found = 1;
                    }

                    con.Close();
                }
                if (email.Text != email2.Text)
                {
                    con.Open();
                    string strCompare2 = "Select * From Member where email=@email";
                    SqlCommand cmdCompare2 = new SqlCommand(strCompare2, con);
                    cmdCompare2.Parameters.AddWithValue("@email", email.Text);
                    SqlDataReader dtrMmber2 = cmdCompare2.ExecuteReader();
                    if (dtrMmber2.HasRows)
                    {
                        found = 2;
                    }

                    con.Close();
                }
                if (phone.Text != phoneNo2.Text)
                {
                    con.Open();
                    string strCompare3 = "Select * From Member where phoneNo=@phoneNo ";
                    SqlCommand cmdCompare3 = new SqlCommand(strCompare3, con);
                    cmdCompare3.Parameters.AddWithValue("@phoneNo", phone.Text);
                    SqlDataReader dtrMmber3 = cmdCompare3.ExecuteReader();
                    if (dtrMmber3.HasRows)
                    {
                        found = 3;
                    }

                    con.Close();


                }
                if (found == 0)
                {


                    string strEdit = "Update Member Set name=@name,phoneNo=@phoneNo,IC=@IC,address=@address,emergencyContact=@emergencyContact,email=@email Where memberID= @memberID";
                    SqlCommand cmdEdit = new SqlCommand(strEdit, con);
                    cmdEdit.Parameters.AddWithValue("@name", name.Text);
                    cmdEdit.Parameters.AddWithValue("@phoneNo", contact.Text);
                    cmdEdit.Parameters.AddWithValue("@IC", IC.Text);
                    cmdEdit.Parameters.AddWithValue("@address", address.Text);
                    cmdEdit.Parameters.AddWithValue("@emergencyContact", contact.Text);
                    cmdEdit.Parameters.AddWithValue("@email", email.Text);
                    cmdEdit.Parameters.AddWithValue("@memberID", id.Text);

                    con.Open();
                    int n = cmdEdit.ExecuteNonQuery();

                    con.Close();
                    if (n > 0)
                    {
                        Response.Write("<script> alert('Member is successfully edit'); </script>");
                        Response.Write("<script>  window.location.replace(\'/staffMember.aspx\') </script>");

                    }

                    else
                        Response.Write("<script> alert('Member unsuccessfully added'); </script>");



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
}