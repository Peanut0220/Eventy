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
    public partial class staffNotificationUpdate : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }

            if (Request.QueryString["notifyID"] == null)
            {
                Response.Redirect("~/staffNotification.aspx");
            }
        }

        protected void btnEventUpdate_Click(object sender, EventArgs e)
        {

            RepeaterItem item = Repeater1.Items[0];
            TextBox title = (TextBox)item.FindControl("txtTitle");
            Label title2 = (Label)item.FindControl("Label2");
            int found = 0;
            Page.Validate();/*Control validation group name optional*/
            if (Page.IsValid)

            {
                if (title.Text != title2.Text)
                {
                    con.Open();

                    string strCompare = "Select * FROM Notification Where title=@title AND isArchive=0";
                    SqlCommand cmdCompare = new SqlCommand(strCompare, con);
                    cmdCompare.Parameters.AddWithValue("@title", title.Text);
                    SqlDataReader dtrCode = cmdCompare.ExecuteReader();
                    if (dtrCode.HasRows)
                    {
                        found = 1;



                    }
                    con.Close();
                }
                if (found == 0)
                {
                    TextBox desc = (TextBox)item.FindControl("txtDesc");
                    Label id = (Label)item.FindControl("Label1");



                    string strEdit = "Update Notification Set title=@title,description=@description Where notifyID=@notifyID ";
                    SqlCommand cmdEdit = new SqlCommand(strEdit, con);
                    cmdEdit.Parameters.AddWithValue("@title", title.Text);
                    cmdEdit.Parameters.AddWithValue("@description", desc.Text);
                    cmdEdit.Parameters.AddWithValue("@notifyID", id.Text);

                    con.Open();
                    int n = cmdEdit.ExecuteNonQuery();

                    con.Close();
                    if (n > 0)
                    {

                        Response.Write("<script> alert('Notification is successfully edit'); </script>");
                        Response.Write("<script>  window.location.replace(\'/staffNotification.aspx\') </script>");

                    }

                    else
                        Response.Write("<script> alert('Notification unsuccessfully edit'); </script>");
                }
                else
                {
                    Response.Write("<script> alert('This Notification already registered in system!'); </script>");
                }




            }
        }
    }
}