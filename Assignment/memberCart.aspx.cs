using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class memberCart : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["memberID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }

            double subtotal = 0;
            double total = 0;
            string strEdit = "";
            con.Open();
            string strSelect = "Select * From CartEvent INNER JOIN Event ON Event.eventID= CartEvent.eventID INNER JOIN TicketPrice ON TicketPrice.eventID=Event.eventID INNER JOIN Cart ON Cart.cartID = CartEvent.cartID INNER JOIN TicketCategory ON TicketCategory.ticketCategoryID = TicketPrice.ticketCategoryID where Cart.cartID = @cartID and CartEvent.ticketCategory = TicketCategory.ticketCategoryName and Event.isArchive =0 ";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));

            SqlDataReader dtrCart = cmdSelect.ExecuteReader();
            while (dtrCart.Read())
            {

                subtotal += Convert.ToDouble(dtrCart["subtotal"]);


            }
            con.Close();

            con.Open();
            strEdit = "Update Cart Set cartTotal=@subtotal where cartID=@cartID";
            SqlCommand cmdDelete1 = new SqlCommand(strEdit, con);
            cmdDelete1.Parameters.AddWithValue("@subtotal", subtotal);
            cmdDelete1.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));

            cmdDelete1.ExecuteNonQuery();

            con.Close();

            Page.MaintainScrollPositionOnPostBack = true;



           

        }

        private void BindRepeater()
        {

            Repeater4.DataSourceID = "SqlDataSource4";
            Repeater4.DataBind();

            if (Repeater4.Items.Count >0)
            {
                RepeaterItem items = Repeater4.Items[0];
                Repeater rep1 = (Repeater)items.FindControl("Repeater1");
                rep1.DataSourceID = "SqlDataSource2";
                rep1.DataBind();

            }


            this.BindRepeater1();


        }
        private void BindRepeater1()
        {
            Repeater4.DataSourceID = "SqlDataSource4";
            Repeater4.DataBind();
           
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int cartEventID = Convert.ToInt32(btn.CommandArgument);

            int quantity = 0;
            int tempQuantity = 0;
            double subtotal = 0;
            double tempSubtotal = 0;
            double cartTotal = 0;
            double tempCartTotal = 0;
            double itemPrice = 0;
            con.Open();
            string strEdit = "";
            string strSelect = "Select * From CartEvent INNER JOIN Event ON Event.eventID= CartEvent.eventID INNER JOIN TicketPrice ON TicketPrice.eventID=Event.eventID INNER JOIN Cart ON Cart.cartID = CartEvent.cartID INNER JOIN TicketCategory ON TicketCategory.ticketCategoryID = TicketPrice.ticketCategoryID where cartEventID=@cartEventID and CartEvent.ticketCategory = TicketCategory.ticketCategoryName";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@cartEventID", cartEventID);

            SqlDataReader dtrCart = cmdSelect.ExecuteReader();
            while (dtrCart.Read())
            {
                subtotal = Convert.ToDouble(dtrCart["subtotal"]);
                quantity = Convert.ToInt32(dtrCart["totalQuantity"]);
                cartTotal = Convert.ToDouble(dtrCart["cartTotal"]);
                itemPrice = Convert.ToDouble(dtrCart["price"]);


            }
            con.Close();

            tempQuantity = quantity - 1;
            tempSubtotal = subtotal - itemPrice;
            tempCartTotal = cartTotal - itemPrice;
            if (tempQuantity == 0)
            {
                con.Open();
                strEdit = "Delete FROM CartEvent where cartEventID =@cartEventID";
                SqlCommand cmdEdit = new SqlCommand(strEdit, con);
                cmdEdit.Parameters.AddWithValue("@cartEventID", cartEventID);
                cmdEdit.ExecuteNonQuery();

                con.Close();

                con.Open();
                strEdit = "Update Cart Set cartTotal=@total where cartID=@cartID";
                SqlCommand cmdEdit1 = new SqlCommand(strEdit, con);
                cmdEdit1.Parameters.AddWithValue("@total", tempCartTotal);
                cmdEdit1.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));

                cmdEdit1.ExecuteNonQuery();

                con.Close();
            }
            else
            {
                con.Open();
                strEdit = "Update CartEvent Set totalQuantity=@quantity ,subtotal = @subtotal where cartEventID=@cartEventID";
                SqlCommand cmdEdit = new SqlCommand(strEdit, con);
                cmdEdit.Parameters.AddWithValue("@quantity", tempQuantity);
                cmdEdit.Parameters.AddWithValue("@subtotal", tempSubtotal);
                cmdEdit.Parameters.AddWithValue("@cartEventID", cartEventID);

                cmdEdit.ExecuteNonQuery();

                con.Close();

                con.Open();
                strEdit = "Update Cart Set cartTotal=@total where cartID=@cartID";
                SqlCommand cmdEdit1 = new SqlCommand(strEdit, con);
                cmdEdit1.Parameters.AddWithValue("@total", tempCartTotal);
                cmdEdit1.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));

                cmdEdit1.ExecuteNonQuery();

                con.Close();


            }




            this.BindRepeater();

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int cartEventID = Convert.ToInt32(btn.CommandArgument);

            int quantity = 0;
            int tempQuantity = 0;
            double subtotal = 0;
            double tempSubtotal = 0;
            double cartTotal = 0;
            double tempCartTotal = 0;
            double itemPrice = 0;
            con.Open();
            string strEdit = "";
            string strSelect = "Select * From CartEvent INNER JOIN Event ON Event.eventID= CartEvent.eventID INNER JOIN TicketPrice ON TicketPrice.eventID=Event.eventID INNER JOIN Cart ON Cart.cartID = CartEvent.cartID INNER JOIN TicketCategory ON TicketCategory.ticketCategoryID = TicketPrice.ticketCategoryID where cartEventID=@cartEventID and CartEvent.ticketCategory = TicketCategory.ticketCategoryName";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@cartEventID", cartEventID);

            SqlDataReader dtrCart = cmdSelect.ExecuteReader();
            while (dtrCart.Read())
            {
                subtotal = Convert.ToDouble(dtrCart["subtotal"]);
                quantity = Convert.ToInt32(dtrCart["totalQuantity"]);
                cartTotal = Convert.ToDouble(dtrCart["cartTotal"]);
                itemPrice = Convert.ToDouble(dtrCart["price"]);


            }
            con.Close();

            tempQuantity = quantity + 1;
            tempSubtotal = subtotal + itemPrice;
            tempCartTotal = cartTotal + itemPrice;

            con.Open();
            strEdit = "Update CartEvent Set totalQuantity=@quantity ,subtotal = @subtotal where cartEventID=@cartEventID";
            SqlCommand cmdEdit = new SqlCommand(strEdit, con);
            cmdEdit.Parameters.AddWithValue("@quantity", tempQuantity);
            cmdEdit.Parameters.AddWithValue("@subtotal", tempSubtotal);
            cmdEdit.Parameters.AddWithValue("@cartEventID", cartEventID);

            cmdEdit.ExecuteNonQuery();

            con.Close();

            con.Open();
            strEdit = "Update Cart Set cartTotal=@total where cartID=@cartID";
            SqlCommand cmdEdit1 = new SqlCommand(strEdit, con);
            cmdEdit1.Parameters.AddWithValue("@total", tempCartTotal);
            cmdEdit1.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));

            cmdEdit1.ExecuteNonQuery();

            con.Close();

            this.BindRepeater();
        }

        protected void LinkButton4_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int cartEventID = Convert.ToInt32(btn.CommandArgument);
            double cartTotal = 0;
            double tempCartTotal = 0;
            double itemPrice = 0;
            string strEdit = "";

            con.Open();
            string strSelect = "Select * From CartEvent INNER JOIN Event ON Event.eventID= CartEvent.eventID INNER JOIN TicketPrice ON TicketPrice.eventID=Event.eventID INNER JOIN Cart ON Cart.cartID = CartEvent.cartID INNER JOIN TicketCategory ON TicketCategory.ticketCategoryID = TicketPrice.ticketCategoryID where cartEventID=@cartEventID and CartEvent.ticketCategory = TicketCategory.ticketCategoryName";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@cartEventID", cartEventID);

            SqlDataReader dtrCart = cmdSelect.ExecuteReader();
            while (dtrCart.Read())
            {
                cartTotal = Convert.ToDouble(dtrCart["cartTotal"]);
                itemPrice = Convert.ToDouble(dtrCart["subtotal"]);


            }
            con.Close();
            tempCartTotal = cartTotal - itemPrice;
            con.Open();
            strEdit = "Delete from CartEvent where cartEventID=@cartEventID";
            SqlCommand cmdDelete = new SqlCommand(strEdit, con);
            cmdDelete.Parameters.AddWithValue("@cartEventID", cartEventID);
            cmdDelete.ExecuteNonQuery();

            con.Close();

            con.Open();
            strEdit = "Update Cart Set cartTotal=@total where cartID =@cartID";
            SqlCommand cmdEdit = new SqlCommand(strEdit, con);
            cmdEdit.Parameters.AddWithValue("@total", tempCartTotal);
            cmdEdit.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
            cmdEdit.ExecuteNonQuery();

            con.Close();


            this.BindRepeater();
        }

        protected void LinkButton3_Click1(object sender, EventArgs e)
        {
            string strEdit = "";

            con.Open();
            strEdit = "Delete from CartEvent where cartID=@cartID";
            SqlCommand cmdDelete = new SqlCommand(strEdit, con);
            cmdDelete.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
            cmdDelete.ExecuteNonQuery();

            con.Close();

            con.Open();
            strEdit = "Update Cart Set cartTotal=0 where cartID=@cartID";
            SqlCommand cmdDelete1 = new SqlCommand(strEdit, con);
            cmdDelete1.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
            cmdDelete1.ExecuteNonQuery();

            con.Close();
            Response.Write("<script>alert('Cleared Successfully!');window.location.replace(\"memberCart.aspx\");</script>");
        }

        protected void Repeater4_PreRender(object sender, EventArgs e)
        {
            con.Open();
            string strSelect = "SELECT COUNT(DISTINCT(CartEvent.eventID)) AS count, cartTotal FROM CartEvent INNER JOIN Cart ON Cart.cartID = CartEvent.cartID INNER JOIN Event ON Event.eventID = CartEvent.eventID where Cart.cartID = @cartID and Event.isArchive=0 GROUP BY cartTotal";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));

            SqlDataReader dtrCart = cmdSelect.ExecuteReader();
            if (dtrCart.HasRows)
            {
                nothing.Visible = false;
                Repeater4.Visible = true;
            }
            else
            {
                nothing.Visible = true;
                Repeater4.Visible = false;
            }
            con.Close();
           
        }

        protected void Repeater1_PreRender(object sender, EventArgs e)
        {

           

        }

       
        

  
            
        

     
        

  
     
    }
}