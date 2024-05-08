using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class staffUpdate : System.Web.UI.Page
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
            if (Request.QueryString["staffID"] == null)
            {
                Response.Redirect("~/staff.aspx");
            }
        }
        public string role1()
        {
            RepeaterItem item = Repeater1.Items[0];
            Label ok = (Label)item.FindControl("rblRole");
            string role = ok.Text;
            return role;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            RepeaterItem item = Repeater1.Items[0];
            TextBox name = (TextBox)item.FindControl("txtStaffNameUpdate");
            Label phone2 = (Label)item.FindControl("Label2");
            TextBox email = (TextBox)item.FindControl("txtStaffEmailUpdate");
            TextBox phone = (TextBox)item.FindControl("txtStaffPhoneNoUpdate");
            TextBox IC = (TextBox)item.FindControl("txtStaffIC");
            int found = 0;
            Page.Validate();/*Control validation group name optional*/
            if (Page.IsValid)

            {


                if (phone.Text != phone2.Text)
                {
                    con.Open();
                    string strCompare3 = "Select * From Staff where phoneNo=@phoneNo ";
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
                    string tempRole = "";


                    TextBox contact = (TextBox)item.FindControl("txtStaffEmergencyContactUpdate");
                    TextBox address = (TextBox)item.FindControl("txtStaffAddressUpdate");

                    Label id = (Label)item.FindControl("Label1");
                    RadioButtonList role = null;

                    con.Open();
                    string strSelect = "Select * From Staff where staffID=@staffID";

                    SqlCommand cmdSelect = new SqlCommand(strSelect, con);
                    cmdSelect.Parameters.AddWithValue("@staffID", id.Text);

                    SqlDataReader dtrStaff = cmdSelect.ExecuteReader();

                    while (dtrStaff.Read())
                    {
                        tempRole = dtrStaff["role"].ToString();

                    }
                    con.Close();
                    if (tempRole.Equals("Manager"))
                    {

                        role = (RadioButtonList)item.FindControl("rblStaffRoleUpdate1");
                    }
                    else
                    {

                        role = (RadioButtonList)item.FindControl("rblStaffRoleUpdate2");
                    }

                    string strEdit = "Update Staff Set name=@name,phoneNo=@phoneNo,address=@address,emergencyContact=@emergencyContact,role=@role Where staffID= @staffID";
                    SqlCommand cmdEdit = new SqlCommand(strEdit, con);
                    cmdEdit.Parameters.AddWithValue("@name", name.Text);
                    cmdEdit.Parameters.AddWithValue("@phoneNo", contact.Text);
                    cmdEdit.Parameters.AddWithValue("@address", address.Text);
                    cmdEdit.Parameters.AddWithValue("@emergencyContact", contact.Text);
                    cmdEdit.Parameters.AddWithValue("@staffID", id.Text);
                    cmdEdit.Parameters.AddWithValue("@role", role.SelectedValue);

                    con.Open();
                    int n = cmdEdit.ExecuteNonQuery();

                    con.Close();
                    if (id.Text == Session["staffID"].ToString())
                    {
                        if (role.SelectedValue != Session["staffRole"].ToString())
                        {
                            Response.Write("<script> alert('Staff is successfully edit'); </script>");
                            Session.Abandon();
                            Response.Write("<script>alert('You have been logout!');window.location.replace(\"memberLogin.aspx\");</script>");

                        }
                        else
                        {
                            if (n > 0)
                            {
                                Response.Write("<script> alert('Staff is successfully edit'); </script>");
                                Response.Write("<script>  window.location.replace(\'/staff.aspx\') </script>");
                            }


                            else
                                Response.Write("<script> alert('Staff unsuccessfully edit'); </script>");


                        }

                    }
                    else
                    {


                        if (n > 0)
                        {
                            Response.Write("<script> alert('Staff is successfully edit'); </script>");
                            Response.Write("<script>  window.location.replace(\'/staff.aspx\') </script>");
                        }


                        else
                            Response.Write("<script> alert('Staff unsuccessfully edit'); </script>");

                    }
                }


                else if (found == 3)
                {
                    Response.Write("<script> alert('An Account has already registered with this phoneNo!'); </script>");
                }

            }
        }
    }
}