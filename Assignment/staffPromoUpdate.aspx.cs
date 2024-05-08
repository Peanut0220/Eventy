using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class staffPromoUpdate : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }

            if (Request.QueryString["codeID"] == null)
            {
                Response.Redirect("~/staffPromoCode.aspx");
            }
        }
        protected void btnEventUpdate_Click(object sender, EventArgs e)
        {

            RepeaterItem item = Repeater1.Items[0];
            TextBox name = (TextBox)item.FindControl("txtName");
            Label name2 = (Label)item.FindControl("Label2");
            int found = 0;
            Page.Validate();/*Control validation group name optional*/
            if (Page.IsValid)

            {
                if (name.Text != name2.Text)
                {
                    con.Open();

                    string strCompare = "Select * FROM PromoCode Where codeName=@codeName AND isArchive=0";
                    SqlCommand cmdCompare = new SqlCommand(strCompare, con);
                    cmdCompare.Parameters.AddWithValue("@codeName", name.Text);
                    SqlDataReader dtrCode = cmdCompare.ExecuteReader();
                    if (dtrCode.HasRows)
                    {
                        found = 1;



                    }
                    con.Close();
                }
                if (found == 0)
                {
                    TextBox rate = (TextBox)item.FindControl("txtDiscount");
                    Label id = (Label)item.FindControl("Label1");



                    string strEdit = "Update PromoCode Set codeName=@codeName,discountRate=@discountRate Where codeID=@codeID ";
                    SqlCommand cmdEdit = new SqlCommand(strEdit, con);
                    cmdEdit.Parameters.AddWithValue("@codeName", name.Text);
                    cmdEdit.Parameters.AddWithValue("@discountRate", Convert.ToDouble(rate.Text) / 100);
                    cmdEdit.Parameters.AddWithValue("@codeID", id.Text);

                    con.Open();
                    int n = cmdEdit.ExecuteNonQuery();

                    con.Close();
                    if (n > 0)
                    {

                        Response.Write("<script> alert('Promo Code is successfully edit'); </script>");
                        Response.Write("<script>  window.location.replace(\'/staffPromoCode.aspx\') </script>");

                    }

                    else
                        Response.Write("<script> alert('Promo Code unsuccessfully edit'); </script>");
                }
                else
                {
                    Response.Write("<script> alert('This Promo Code already registered in system!'); </script>");
                }




            }
        }
    }
}