using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class memberProfile : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["memberID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
        }

        protected void btnEdit(object sender, EventArgs e)
        {

        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            RepeaterItem item = Repeater2.Items[0];
            TextBox name = (TextBox)item.FindControl("txtMemberProfileName2");
            TextBox phone = (TextBox)item.FindControl("txtMemberProfilePhoneNo");
            TextBox contact = (TextBox)item.FindControl("txtMemberEmergencyContact");
            TextBox address = (TextBox)item.FindControl("txtMemberAddress");
            Label phone2 = (Label)item.FindControl("Label4");
            Label id = (Label)item.FindControl("Label1");
            int found = 0;
            if (IsPostBack)
            {
                Page.Validate();/*Control validation group name optional*/
                if (Page.IsValid)

                {
                    if (phone.Text != phone2.Text)
                    {
                        con.Open();
                        string strCompare = "Select * From Member where phoneNo=@phoneNo ";
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
                        con.Open();
                        string strSelect = "Select * From Member where memberID=@memberID";

                        SqlCommand cmdSelect = new SqlCommand(strSelect, con);
                        cmdSelect.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"].ToString()));

                        SqlDataReader dtrStaff = cmdSelect.ExecuteReader();


                        con.Close();

                        string strEdit = "Update Member Set name=@name,phoneNo=@phoneNo,address=@address,emergencyContact=@emergencyContact Where memberID=@memberID";
                        SqlCommand cmdEdit = new SqlCommand(strEdit, con);
                        cmdEdit.Parameters.AddWithValue("@name", name.Text);
                        cmdEdit.Parameters.AddWithValue("@phoneNo", phone.Text);
                        cmdEdit.Parameters.AddWithValue("@address", address.Text);
                        cmdEdit.Parameters.AddWithValue("@emergencyContact", contact.Text);
                        cmdEdit.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"].ToString()));

                        con.Open();
                        int n = cmdEdit.ExecuteNonQuery();

                        con.Close();
                        if (n > 0)
                            Response.Write("<script> alert('Profile is successfully edit');window.location.replace('/memberProfile.aspx') </script>");

                        else
                            Response.Write("<script> alert('Profile unsuccessfully edit'); </script>");


                    }
                    else if (found == 1)
                    {
                        Response.Write("<script> alert('An Account has already registered with this phoneNo!'); </script>");
                    }
                }
            }
        }

        protected void ImageBack1_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 0;

        }
        protected void txtMemberProfileName2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            Response.Write("<script> window.location.replace('/resetPass.aspx') </script>");
        }
    }
}