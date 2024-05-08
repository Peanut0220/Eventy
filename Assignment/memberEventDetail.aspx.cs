using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Assignment
{
    public partial class memberEventDetail : System.Web.UI.Page
    {
        int i = 0;
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["memberID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
        }

        public int rating1()
        {
            RepeaterItem item = Repeater2.Items[i];
            Label lblname = (Label)item.FindControl("Label5");
            string name = lblname.Text;
            int rating = int.Parse(name);
            i++;
            return rating;

        }

        protected void Button2_Click(object sender, EventArgs e)
        {

        }


        protected void UploadButton_Click(object sender, EventArgs e)
        {
           
          
            double total = 0;

            string strAdd = "";
            string strEdit = "";

            con.Open();
            string strSelect = "Select * From Cart where cartID=@cartID";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));

            SqlDataReader dtrCart = cmdSelect.ExecuteReader();
            while (dtrCart.Read())
            {
                total = Convert.ToDouble(dtrCart["cartTotal"]);
            }
            con.Close();




            for (int i = 0; i < Repeater3.Items.Count; i++)
            {
                RepeaterItem item = Repeater3.Items[i];
                TextBox quantityTxt = (TextBox)item.FindControl("ticketNum");

               
                int quantity = Convert.ToInt32(quantityTxt.Text);
                Label ticketCategory = (Label)item.FindControl("Label7");
                RepeaterItem item1 = Repeater1.Items[0];
                Label eventIDText = (Label)item1.FindControl("Label9");
                int eventID = Convert.ToInt32(eventIDText.Text);
                Label price = (Label)item.FindControl("Label3");
                double subtotal = Convert.ToDouble(price.Text) * quantity;

                //if quantity not null
                if (quantity > 0)
                {
                    
                    int tempQuantity = 0;
                    double tempSubtotal = 0;
                    
                    con.Open();
                    strSelect = "Select * From CartEvent where cartID=@cartID and ticketCategory=@category and eventID =@eventID";
                    cmdSelect = new SqlCommand(strSelect, con);
                    cmdSelect.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
                    cmdSelect.Parameters.AddWithValue("@category", ticketCategory.Text);
                    cmdSelect.Parameters.AddWithValue("@eventID", eventID);
                    dtrCart = cmdSelect.ExecuteReader();

                    //check if already exist in cart
                    if (dtrCart.HasRows)
                    {
                        //exist in cart
                        while (dtrCart.Read())
                        {

                            tempQuantity += Convert.ToInt32(dtrCart["totalQuantity"]);
                            tempSubtotal += Convert.ToDouble(dtrCart["subtotal"]);
                        }
                        con.Close();
                        tempSubtotal += subtotal;
                        tempQuantity += quantity;
                        con.Open();
                        strEdit = "Update CartEvent Set totalQuantity=@tempQuantity,subtotal=@subtotal where cartID=@cartID and ticketCategory=@category and eventID =@eventID";
                        SqlCommand cmdEdit1 = new SqlCommand(strEdit, con);

                        cmdEdit1.Parameters.AddWithValue("@tempQuantity", tempQuantity);
                        cmdEdit1.Parameters.AddWithValue("@subtotal", tempSubtotal);
                        cmdEdit1.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
                        cmdEdit1.Parameters.AddWithValue("@category", ticketCategory.Text);
                        cmdEdit1.Parameters.AddWithValue("@eventID", eventID);
                        cmdEdit1.ExecuteNonQuery();
                        total += subtotal;
                        con.Close();
                    }
                    else
                    {
                        con.Close();
                        //not exist in cart
                        con.Open();
                        strAdd = "Insert into CartEvent (totalQuantity, subtotal, ticketCategory, cartID, eventID) Values (@totalQuantity, @subtotal,@ticketCategory, @cartID,@eventID)";
                        SqlCommand cmd = new SqlCommand(strAdd, con);
                        cmd.Parameters.AddWithValue("@totalQuantity", quantity);
                        cmd.Parameters.AddWithValue("@subtotal", subtotal);
                        cmd.Parameters.AddWithValue("@ticketCategory", ticketCategory.Text);
                        cmd.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
                        cmd.Parameters.AddWithValue("@eventID", eventID);
                        int n = cmd.ExecuteNonQuery();
                        con.Close();
                        total += subtotal;
                    }
                 
                }

               

            }
            con.Open();
            strEdit = "Update Cart Set cartTotal=@total where cartID=@cartID";
            SqlCommand cmdEdit = new SqlCommand(strEdit, con);
            cmdEdit.Parameters.AddWithValue("@total", total);
            cmdEdit.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
            cmdEdit.ExecuteNonQuery();
            con.Close();
            Response.Write("<script>alert('Added Successfully!');window.location.replace(\"memberCart.aspx\");</script>");
            
        }

        protected void Repeater3_PreRender(object sender, EventArgs e)
        {
            for (int i = 0; i < Repeater3.Items.Count; i++)
            {
                RepeaterItem item = Repeater3.Items[i];
                TextBox txt = (TextBox)item.FindControl("ticketNum");
                txt.Attributes.Add("readonly", "readonly");

            }
        }
    }


}