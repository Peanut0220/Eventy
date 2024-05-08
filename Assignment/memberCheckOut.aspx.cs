using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Net;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;
using System.Drawing.Printing;
using System.Runtime.Remoting.Messaging;
using System.Security.Policy;
using PayPal.Api;

namespace Assignment
{
    public partial class memberCheckOut : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["memberID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
            con.Open();
            string strSelect = "SELECT * FROM Cart where cartID=@cartID";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));

            SqlDataReader dtrCart = cmdSelect.ExecuteReader();

            while (dtrCart.Read())
            {
                if (Convert.ToInt32(dtrCart["cartTotal"]) == 0)
                {
                    Response.Write("<script>alert('Your cart is Empty! Please add some tickets to checkout!');window.location.replace(\"memberCart.aspx\");</script>");
                }
            }
            con.Close();
            Page.MaintainScrollPositionOnPostBack = true;
        }

      
        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            RepeaterItem rpItem = (RepeaterItem)Repeater3.Items[0];
            Label discountLabel = (Label)rpItem.FindControl("Label10");
            Label carttotalLabel = (Label)rpItem.FindControl("Label4");
            Label amountDiscountLabel = (Label)rpItem.FindControl("Label11");
            Label amounttaxLabel = (Label)rpItem.FindControl("Label3");
            Label afterDiscountLabel = (Label)rpItem.FindControl("Label14");
            Label finalLabel = (Label)rpItem.FindControl("Label5");
            string promoCode = "";
            promoCode = Label12.Text;



            Session["discountLabel"] = discountLabel.Text;
            Session["carttotalLabel"] = carttotalLabel.Text;
            Session["amountDiscountLabel"] = amountDiscountLabel.Text;
            Session["amounttaxLabel"] = amounttaxLabel.Text;
            Session["finalLabel"] = finalLabel.Text;
            Session["promoCode"] = promoCode;
         



            var config = ConfigManager.Instance.GetProperties();
            var accessToken = new OAuthTokenCredential(config).GetAccessToken();
            var apiContext = new APIContext(accessToken);
            Session["paymentOnGoing"] = accessToken;
            var eventItem = new Item();
            eventItem.name = "Event";
            eventItem.currency = "MYR";
            eventItem.price = finalLabel.Text;
            eventItem.sku = "sku";
            eventItem.quantity = "1";

            var transactionDetails = new Details();
            transactionDetails.tax = "0";
            transactionDetails.shipping = "0";
            transactionDetails.subtotal = Convert.ToDouble(finalLabel.Text).ToString("0.00");

            var transactionAmount = new Amount();
            transactionAmount.currency = "MYR";
            transactionAmount.total = Convert.ToDouble(finalLabel.Text).ToString("0.00");
            transactionAmount.details = transactionDetails;

            var transaction = new Transaction();
            transaction.description = "Your order of Events";
            transaction.invoice_number = Guid.NewGuid().ToString();

            transaction.amount = transactionAmount;
            transaction.item_list = new ItemList
            {
                items = new List<Item> { eventItem }
            };

            var payer = new Payer();
            payer.payment_method = "paypal";

            var redirectUrls = new RedirectUrls();
            redirectUrls.cancel_url = "https://localhost:44365/paymentCancel.aspx";
            redirectUrls.return_url = "https://localhost:44365/confirmPayment.aspx";

            var payment = Payment.Create(apiContext, new Payment
            {
                intent = "sale",
                payer = payer,
                transactions = new List<Transaction> { transaction },
                redirect_urls = redirectUrls
            });

            Session["paymentId"] = payment.id;

            foreach (var link in payment.links)
            {
                if (link.rel.ToLower().Trim().Equals("approval_url"))
                {
                    Response.Redirect(link.href);
                }
            }

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            promoCodeWrong1.Visible = false;
            promoCodeCorrect1.Visible = false;
            string promoCode = TextBox7.Text;
            string codeID = "";
            double discountRate = 0;
            int found = 0;
         
            con.Open();
            string strSelect = "Select * from PromoCode where codeName=@codeName and isArchive=0";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@codeName", promoCode);

            SqlDataReader dtrCart = cmdSelect.ExecuteReader();
        
                while (dtrCart.Read())
                {
                   codeID= dtrCart["codeID"].ToString();
                   discountRate = Convert.ToDouble(dtrCart["discountRate"]);
                  found = 1;
                }   
       
            con.Close();
            if (found == 1)
            {
                con.Open();
                strSelect = "Select * from PromoCodeUsage where codeID=@codeID and memberID = @memberID";
                cmdSelect = new SqlCommand(strSelect, con);
                cmdSelect.Parameters.AddWithValue("@codeID", codeID);
                cmdSelect.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));
                dtrCart = cmdSelect.ExecuteReader();
                if (dtrCart.HasRows)
                {
                    promoCodeWrong1.Visible = true;
                    promoCodeWrong.Text = "The Code (" + promoCode + ") has been used, Try Another One!";
                    Repeater3.DataSourceID = "SqlDataSource4";
                    Repeater3.DataBind();
                    RepeaterItem rpItem = (RepeaterItem)Repeater3.Items[0];
                    Label12.Text = "";
                }
                else
                {
                    Repeater3.DataSourceID = "SqlDataSource4";
                    Repeater3.DataBind();

                    RepeaterItem rpItem = (RepeaterItem)Repeater3.Items[0];
                    Label discountLabel = (Label)rpItem.FindControl("Label10");
                    Label carttotalLabel = (Label)rpItem.FindControl("Label4");
                    Label amountDiscountLabel = (Label)rpItem.FindControl("Label11");
                    Label amounttaxLabel = (Label)rpItem.FindControl("Label3");
                    Label afterDiscountLabel = (Label)rpItem.FindControl("Label14");
                    Label finalLabel = (Label)rpItem.FindControl("Label5");
                    
                    Label12.Text = codeID.ToString();

                    promoCodeCorrect1.Visible = true;
                    promoCodeCorrect.Text = "The Code (" + promoCode.ToUpper() + ") has applied!";
                    Label12.Text = codeID;
                 
                    amountDiscountLabel.Text = (Convert.ToDouble(carttotalLabel.Text) * discountRate).ToString("F");

                    discountRate = discountRate * 100;
                    discountLabel.Text = "Discount(" + discountRate + "%)";
                    afterDiscountLabel.Text = (Convert.ToDouble(carttotalLabel.Text) - Convert.ToDouble(amountDiscountLabel.Text)).ToString("F");

                    amounttaxLabel.Text = (Convert.ToDouble(afterDiscountLabel.Text) * 0.06).ToString("F");
                    finalLabel.Text = (Convert.ToDouble(afterDiscountLabel.Text) + Convert.ToDouble(amounttaxLabel.Text)).ToString("F");


                }

                con.Close();

            }
            else
            {
                promoCodeWrong1.Visible = true;
                Repeater3.DataSourceID = "SqlDataSource4";
                Repeater3.DataBind();
                Label12.Text = "";
            }

           

        }
    }
}