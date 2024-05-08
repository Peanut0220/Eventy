using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Assignment
{
    public partial class staffNotificationCreate : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }

            txtDate.Text = DateTime.Now.ToShortDateString();








        }
        protected void btnEventAdd_Click(object sender, EventArgs e)
        {
            Page.Validate();/*Control validation group name optional*/
            if (Page.IsValid)

            {
                con.Open();
                int found = 0;
                string strCompare = "Select * FROM Notification Where title=@title AND isArchive=0";
                SqlCommand cmdCompare = new SqlCommand(strCompare, con);
                cmdCompare.Parameters.AddWithValue("@title", txtTitle.Text);
                SqlDataReader dtrCode = cmdCompare.ExecuteReader();
                var date = DateTime.Parse(txtDate.Text);
                if (dtrCode.HasRows)
                {
                    found = 1;

                }
                con.Close();
                if (found == 0)
                {
                    string strAdd = "Insert Into Notification(title,description,createdDate,isArchive,staffID) Values (@title,@description,@createdDate,@isArchive,@staffID)";
                    SqlCommand cmdAdd = new SqlCommand(strAdd, con);
                    cmdAdd.Parameters.AddWithValue("@title", txtTitle.Text);
                    cmdAdd.Parameters.AddWithValue("@description", txtDesc.Text);
                    cmdAdd.Parameters.AddWithValue("@createdDate", DateTime.Now);
                    cmdAdd.Parameters.AddWithValue("@isArchive", 0);
                    cmdAdd.Parameters.AddWithValue("@staffID", Convert.ToInt32(Session["staffID"].ToString()));

                    con.Open();
                    int n = cmdAdd.ExecuteNonQuery();

                    con.Close();


                    if (n > 0)
                    {
                        Response.Write("<script> alert('Notification is added'); </script>");
                        Response.Write("<script>  window.location.replace(\'/staffNotification.aspx\') </script>");
                    }

                    else
                        Response.Write("<script> alert('Notification unsuccessfully added'); </script>");
                }
                else
                {
                    Response.Write("<script> alert('This Notification already registered in system!'); </script>");
                }
            }
        }

        protected void btnEventReset_Click(object sender, EventArgs e)
        {
            txtTitle.Text = "";
            txtDesc.Text = "";
        }

        protected void ddlPromotion_SelectedIndexChanged(object sender, EventArgs e)
        {

            string strCompare = "SELECT PromoCode.discountRate FROM PromoCode WHERE codeName=@codeName";
            SqlCommand cmdCompare = new SqlCommand(strCompare, con);
            cmdCompare.Parameters.AddWithValue("@codeName", ddlPromotion.SelectedValue);



            con.Open();
            object discountRateObject = cmdCompare.ExecuteScalar();
            con.Close();


            if (discountRateObject != null && discountRateObject != DBNull.Value)
            {
                decimal discountRate = Convert.ToDecimal(discountRateObject) * 100;
                int discount = Convert.ToInt32(discountRate);
                txtTitle.Enabled = false;
                txtTitle.Text = "Grab Your PromoCode To Enjoy " + discount + "% Discount ";
                txtDesc.Enabled = false;
                txtDesc.Text = "Promo Code is '" + ddlPromotion.SelectedValue + "'";


            }
            else
            {

                lblPromotion.Visible = false;
                ddlPromotion.Visible = false;
                rblNotification.SelectedIndex = 0;
                txtTitle.Enabled = true;
                txtDesc.Enabled = true;
                txtDesc.Text = "";
                txtTitle.Text = "";
            }




        }

        protected void rblNotification_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (rblNotification.SelectedIndex == 0)
            {
                lblPromotion.Visible = false;
                ddlPromotion.Visible = false;
                txtTitle.Enabled = true;
                txtDesc.Enabled = true;
                txtDesc.Text = string.Empty;
                txtTitle.Text = string.Empty;

            }

            if (rblNotification.SelectedIndex == 1)
            {
                lblPromotion.Visible = true;
                ddlPromotion.Visible = true;

            }



        }

        protected void DropDownList1_PreRender(object sender, EventArgs e)
        {
            if (rblNotification.SelectedIndex == 1)
            {



                string strCompare = "SELECT PromoCode.discountRate FROM PromoCode WHERE codeName=@codeName";
                SqlCommand cmdCompare = new SqlCommand(strCompare, con);
                cmdCompare.Parameters.AddWithValue("@codeName", ddlPromotion.SelectedValue);



                con.Open();
                object discountRateObject = cmdCompare.ExecuteScalar();
                con.Close();
                if (discountRateObject != null && discountRateObject != DBNull.Value)
                {
                    decimal discountRate = Convert.ToDecimal(discountRateObject) * 100;
                    int discount = Convert.ToInt32(discountRate);
                    txtTitle.Text = "Grab Your PromoCode To Enjoy " + discount + "% Discount ";
                    txtTitle.Enabled = false;
                    txtDesc.Text = "Promo Code is '" + ddlPromotion.SelectedValue + "'";
                    txtDesc.Enabled = false;
                }
                else
                {
                    lblPromotion.Visible = false;
                    ddlPromotion.Visible = false;
                    rblNotification.SelectedIndex = 0;
                    txtTitle.Enabled = true;
                    txtDesc.Enabled = true;
                    txtDesc.Text = string.Empty;
                    txtTitle.Text = string.Empty;

                }
            }
            else
            {
                lblPromotion.Visible = false;
                ddlPromotion.Visible = false;
                rblNotification.SelectedIndex = 0;
                txtTitle.Enabled = true;
                txtDesc.Enabled = true;
                txtDesc.Text = string.Empty;
                txtTitle.Text = string.Empty;
            }
        }






        protected void ddlPromotion_PreRender(object sender, EventArgs e)
        {
            string strCompare = "SELECT PromoCode.discountRate FROM PromoCode WHERE codeName=@codeName";
            SqlCommand cmdCompare = new SqlCommand(strCompare, con);
            cmdCompare.Parameters.AddWithValue("@codeName", ddlPromotion.SelectedValue);



            con.Open();
            object discountRateObject = cmdCompare.ExecuteScalar();
            con.Close();
            if (discountRateObject != null && discountRateObject != DBNull.Value)
            {
                decimal discountRate = Convert.ToDecimal(discountRateObject) * 100;
                int discount = Convert.ToInt32(discountRate);
                txtTitle.Text = " More than " + discount + "% Discount ";
                txtTitle.Enabled = false;
                txtDesc.Text = "Promo Code is '" + ddlPromotion.SelectedValue + "'";
                txtDesc.Enabled = false;



            }
            else
            {
                lblPromotion.Visible = false;
                ddlPromotion.Visible = false;
                rblNotification.SelectedIndex = 0;
                txtTitle.Enabled = true;
                txtDesc.Enabled = true;
                txtDesc.Text = string.Empty;
                txtTitle.Text = string.Empty;
                Response.Write("<script> alert('No Any Promotion Available'); </script>");

            }


        }
    }

}