using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class staffPromoCreate : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }

        }

        protected void btnEventAdd_Click(object sender, EventArgs e)
        {
            Page.Validate();/*Control validation group name optional*/
            if (Page.IsValid)

            {
                con.Open();
                int found = 0;
                string strCompare = "Select * FROM PromoCode Where codeName=@codeName AND isArchive=0";
                SqlCommand cmdCompare = new SqlCommand(strCompare, con);
                cmdCompare.Parameters.AddWithValue("@codeName", txtName.Text);
                SqlDataReader dtrCode = cmdCompare.ExecuteReader();
                if (dtrCode.HasRows)
                {
                    found = 1;

                }
                con.Close();
                if (found == 0)
                {
                    string strAdd = "Insert Into PromoCode(codeName,discountRate,isArchive) Values (@codeName,@discountRate,@isArchive)";
                    SqlCommand cmdAdd = new SqlCommand(strAdd, con);
                    cmdAdd.Parameters.AddWithValue("@codeName", txtName.Text);
                    cmdAdd.Parameters.AddWithValue("@discountRate", Convert.ToDouble(txtDiscount.Text) / 100);
                    cmdAdd.Parameters.AddWithValue("@isArchive", 0);

                    con.Open();
                    int n = cmdAdd.ExecuteNonQuery();

                    con.Close();


                    if (n > 0)
                    {
                        Response.Write("<script> alert('PromoCode is added'); </script>");
                        Response.Write("<script>  window.location.replace(\'/staffPromoCode.aspx\') </script>");
                    }

                    else
                        Response.Write("<script> alert('PromoCode unsuccessfully added'); </script>");
                }
                else
                {
                    Response.Write("<script> alert('This Promo Code already registered in system!'); </script>");
                }
            }
        }

        protected void btnEventReset_Click(object sender, EventArgs e)
        {
            txtName.Text = "";
            txtDiscount.Text = "";
        }
    }
}