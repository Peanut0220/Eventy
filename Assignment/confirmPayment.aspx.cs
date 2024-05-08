using PayPal.Api;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Reflection.Emit;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{

    public partial class confirmPayment : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["paymentId"] == null)
            {
                Response.Redirect("~/memberHome.aspx");
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            var config = ConfigManager.Instance.GetProperties();
            var accessToken = new OAuthTokenCredential(config).GetAccessToken();
            var apiContext = new APIContext(accessToken);

            var paymentId = Session["paymentId"].ToString();

            if (!String.IsNullOrEmpty(paymentId))
            {
                var payment = new Payment() { id = paymentId };
                var payerId = Request.QueryString["PayerID"].ToString();
                var paymentExecution = new PaymentExecution()
                {
                    payer_id = payerId
                };

                var executedPayment = payment.Execute(apiContext, paymentExecution);


                //store into database;
                string discountLabel = Session["discountLabel"].ToString();
                string carttotalLabel = Session["carttotalLabel"].ToString();
                string amountDiscountLabel = Session["amountDiscountLabel"].ToString();
                string amounttaxLabel = Session["amounttaxLabel"].ToString();
                string finalLabel = Session["finalLabel"].ToString();
                string promoCode = Session["promoCode"].ToString();



                string paymentMethod = "Paypal";
                string paymentID = "";
                string recordID = "";
                int totalQuantity = 0;
                List<int> totalQuantityArray = new List<int>();
                List<double> subtotalArray = new List<double>();
                List<string> ticketCategoryArray = new List<string>();
                List<int> ticketCategoryIDArray = new List<int>();
                List<int> eventIDArray = new List<int>();
                List<int> quantityLeftArray = new List<int>();
                List<string> eventNameArray = new List<string>();
                List<int> eventCategoryCountArray = new List<int>();
                List<int> eventIDCountArray = new List<int>();
                List<int> recordEventArray = new List<int>();
                int eventCount = 0;
                int i = 0;





                //create payment
                con.Open();
                string strInsert = "Insert Into Payment (discount, totalPaid,tax,paymentMethod,paymentCreatedDate) Values (@discount, @totalPaid,@tax,@paymentMethod,@paymentCreatedDate)";
                SqlCommand cmdInsert = new SqlCommand(strInsert, con);
                cmdInsert.Parameters.AddWithValue("@discount", Convert.ToDouble(amountDiscountLabel));
                cmdInsert.Parameters.AddWithValue("@totalPaid", Convert.ToDouble(finalLabel));
                cmdInsert.Parameters.AddWithValue("@tax", Convert.ToDouble(amounttaxLabel));
                cmdInsert.Parameters.AddWithValue("@paymentMethod", paymentMethod);
                cmdInsert.Parameters.AddWithValue("@paymentCreatedDate", DateTime.Now);
                cmdInsert.ExecuteNonQuery();
                con.Close();

                //get lastest payment
                con.Open();
                string strSelect = "SELECT TOP 1 * FROM Payment ORDER BY paymentID DESC";
                SqlCommand cmdSelect = new SqlCommand(strSelect, con);
                string paymentDate = "";
                SqlDataReader dtrCart = cmdSelect.ExecuteReader();

                while (dtrCart.Read())
                {
                    paymentDate = dtrCart["paymentCreatedDate"].ToString();
                    paymentID = dtrCart["paymentID"].ToString();
                }
                con.Close();

                //if thr's discount create new code usage
                if (amountDiscountLabel != "0")
                {

                    con.Open();
                    strInsert = "Insert Into PromoCodeUsage (codeID,paymentID,memberID) Values (@codeID, @paymentID,@memberID)";
                    cmdInsert = new SqlCommand(strInsert, con);
                    cmdInsert.Parameters.AddWithValue("@codeID", Convert.ToInt32(promoCode));
                    cmdInsert.Parameters.AddWithValue("@paymentID", Convert.ToInt32(paymentID));
                    cmdInsert.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));
                    cmdInsert.ExecuteNonQuery();
                    con.Close();
                }

                //get all cart event
                con.Open();
                strSelect = "SELECT CartEvent.eventID, CartEvent.ticketCategory, CartEvent.subtotal, CartEvent.totalQuantity FROM CartEvent INNER JOIN Event ON Event.eventID = CartEvent.eventID where cartID=@cartID and Event.isArchive=0 GROUP BY CartEvent.eventID,CartEvent.ticketCategory, CartEvent.subtotal, CartEvent.totalQuantity";
                cmdSelect = new SqlCommand(strSelect, con);
                cmdSelect.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
                dtrCart = cmdSelect.ExecuteReader();

                while (dtrCart.Read())
                {
                    totalQuantity += Convert.ToInt32(dtrCart["totalQuantity"]);
                    totalQuantityArray.Add(Convert.ToInt32(dtrCart["totalQuantity"]));
                    subtotalArray.Add(Convert.ToDouble(dtrCart["subtotal"]));

                    ticketCategoryArray.Add(dtrCart["ticketCategory"].ToString());

                    eventIDArray.Add(Convert.ToInt32(dtrCart["eventID"]));

                }
                con.Close();

                //get all unique event in cart
                con.Open();
                strSelect = "SELECT DISTINCT(Event.eventName) , Event.eventID FROM CartEvent INNER JOIN Event ON Event.eventID = CartEvent.eventID where cartID=@cartID and Event.isArchive=0 GROUP BY Event.eventID,Event.eventName";
                cmdSelect = new SqlCommand(strSelect, con);
                cmdSelect.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
                dtrCart = cmdSelect.ExecuteReader();

                while (dtrCart.Read())
                {
                    eventNameArray.Add(dtrCart["eventName"].ToString());

                }
                con.Close();

                //get all unique cart event
                con.Open();
                strSelect = "SELECT DISTINCT(CartEvent.eventID) FROM CartEvent INNER JOIN Event ON Event.eventID = CartEvent.eventID where cartID=@cartID and Event.isArchive=0";
                cmdSelect = new SqlCommand(strSelect, con);
                cmdSelect.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
                dtrCart = cmdSelect.ExecuteReader();

                while (dtrCart.Read())
                {

                    eventIDCountArray.Add(Convert.ToInt32(dtrCart["eventID"]));

                }
                con.Close();


                for (int p = 0; p < eventIDCountArray.Count; p++)
                {
                    con.Open();
                    strSelect = "SELECT DISTINCT(CartEvent.ticketCategory) FROM CartEvent INNER JOIN Event ON Event.eventID = CartEvent.eventID where cartID=@cartID and Event.isArchive=0 and CartEvent.eventID =@eventID";
                    cmdSelect = new SqlCommand(strSelect, con);
                    cmdSelect.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
                    cmdSelect.Parameters.AddWithValue("@eventID", eventIDCountArray[p]);
                    dtrCart = cmdSelect.ExecuteReader();
                    eventCategoryCountArray.Add(0);
                    while (dtrCart.Read())
                    {
                        eventCategoryCountArray[p] = eventCategoryCountArray[p] + 1;

                    }
                    con.Close();
                }


                con.Open();
                strInsert = "Insert Into Participate_Record (recordCreatedDate, recordTotalPrice,recordTotalQuantity,memberID,paymentID) Values (@recordCreatedDate, @recordTotalPrice,@recordTotalQuantity,@memberID,@paymentID)";
                cmdInsert = new SqlCommand(strInsert, con);
                cmdInsert.Parameters.AddWithValue("@recordCreatedDate", DateTime.Now);
                cmdInsert.Parameters.AddWithValue("@recordTotalPrice", Convert.ToDouble(carttotalLabel));
                cmdInsert.Parameters.AddWithValue("@recordTotalQuantity", totalQuantity);
                cmdInsert.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));
                cmdInsert.Parameters.AddWithValue("@paymentID", Convert.ToInt32(paymentID));
                cmdInsert.ExecuteNonQuery();
                con.Close();

                con.Open();
                strSelect = "SELECT TOP 1 * FROM Participate_Record ORDER BY recordID DESC";
                cmdSelect = new SqlCommand(strSelect, con);

                dtrCart = cmdSelect.ExecuteReader();

                while (dtrCart.Read())
                {
                    recordID = dtrCart["recordID"].ToString();
                }
                con.Close();




                for (int j = 0; j < totalQuantityArray.Count; j++)
                {
                    con.Open();
                    strInsert = "Insert Into RecordEvent (totalQuantity, subtotal,ticketCategory,recordID,eventID) Values (@totalQuantity, @subtotal,@ticketCategory,@recordID,@eventID)";
                    cmdInsert = new SqlCommand(strInsert, con);
                    cmdInsert.Parameters.AddWithValue("@totalQuantity", totalQuantityArray[j]);
                    cmdInsert.Parameters.AddWithValue("@subtotal", subtotalArray[j]);
                    cmdInsert.Parameters.AddWithValue("@ticketCategory", ticketCategoryArray[j]);
                    cmdInsert.Parameters.AddWithValue("@recordID", Convert.ToInt32(recordID));
                    cmdInsert.Parameters.AddWithValue("@eventID", eventIDArray[j]);
                    cmdInsert.ExecuteNonQuery();
                    con.Close();
                }

                for (int j = 0; j < totalQuantityArray.Count; j++)
                {
                    con.Open();
                    strSelect = "Select * FROM TicketPrice INNER JOIN TicketCategory ON TicketCategory.ticketCategoryID = TicketPrice.ticketCategoryID where TicketPrice.eventID =@eventID and TicketCategoryName =@name";
                    cmdSelect = new SqlCommand(strSelect, con);
                    cmdSelect.Parameters.AddWithValue("@eventID", eventIDArray[j]);
                    cmdSelect.Parameters.AddWithValue("@name", ticketCategoryArray[j]);
                    cmdSelect.ExecuteNonQuery();
                    dtrCart = cmdSelect.ExecuteReader();

                    while (dtrCart.Read())
                    {
                        quantityLeftArray.Add(Convert.ToInt32(dtrCart["quantityLeft"]));
                        ticketCategoryIDArray.Add(Convert.ToInt32(dtrCart["ticketCategoryID"]));

                    }
                    con.Close();
                }

                con.Open();
                strSelect = "SELECT * FROM RecordEvent where recordID = @recordID";
                cmdSelect = new SqlCommand(strSelect, con);
                cmdSelect.Parameters.AddWithValue("@recordID", recordID);
                dtrCart = cmdSelect.ExecuteReader();

                while (dtrCart.Read())
                {
                    recordEventArray.Add(Convert.ToInt32(dtrCart["recordEventID"]));
                }
                con.Close();




                for (int j = 0; j < totalQuantityArray.Count; j++)
                {
                    con.Open();
                    string strUpdate = "Insert Into Event_Pass (passStatus, memberID,recordEventID) Values (@passStatus, @memberID,@recordEventID)";
                    SqlCommand cmdUpdate = new SqlCommand(strUpdate, con);
                    cmdUpdate.Parameters.AddWithValue("@passStatus", "Unused");
                    cmdUpdate.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));
                    cmdUpdate.Parameters.AddWithValue("@recordEventID", recordEventArray[j]);
                    cmdUpdate.ExecuteNonQuery();
                    con.Close();
                }

                for (int j = 0; j < totalQuantityArray.Count; j++)
                {
                    con.Open();
                    string strUpdate = "Update TicketPrice Set quantityLeft=@left where ticketCategoryID=@category and eventID=@eventID";
                    SqlCommand cmdUpdate = new SqlCommand(strUpdate, con);
                    cmdUpdate.Parameters.AddWithValue("@left", quantityLeftArray[j] - totalQuantityArray[j]);
                    cmdUpdate.Parameters.AddWithValue("@category", ticketCategoryIDArray[j]);
                    cmdUpdate.Parameters.AddWithValue("@eventID", eventIDArray[j]);
                    cmdUpdate.ExecuteNonQuery();
                    con.Close();
                }

                con.Open();
                string strDelete = "Delete w from CartEvent w INNER JOIN Event e ON e.eventID = w.eventID where w.cartID=@cartID and e.isArchive=0";
                SqlCommand cmdDelete = new SqlCommand(strDelete, con);
                cmdDelete.Parameters.AddWithValue("@cartID", Convert.ToInt32(Session["cartID"]));
                cmdDelete.ExecuteNonQuery();

                con.Close();

                string to = Session["email"].ToString(); //To address    
                string from = "eventy366@gmail.com"; //From address    
                MailMessage message = new MailMessage(from, to);

                string memberName = "";
                string memberPhone = "";
                string memberAddress = "";
                con.Open();
                strSelect = "SELECT * FROM Member where memberID = @memberID";
                cmdSelect = new SqlCommand(strSelect, con);
                cmdSelect.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));
                dtrCart = cmdSelect.ExecuteReader();

                while (dtrCart.Read())
                {
                    memberName = dtrCart["name"].ToString();
                    memberPhone = dtrCart["phoneNo"].ToString();
                    memberAddress = dtrCart["address"].ToString();
                }
                con.Close();


                string mailbody = "<html><head><style>body{font-family:Arial;}" +
                    ".bottom{float:right;margin-right:4 %;}" +
                    "</style></head><body><div class=\"container\"><div style=\"background-color:#0b2c97;color: white;font-size:50px;text-align:center;padding: 20px;font-weight:lighter;\"><p>Payment Receipt For #" + paymentID + "</p></div><div class=\"main\"><div style=\"margin-left:4%;\">" +
                    "<p>Customer Name: "+ memberName + "</p><p>Address: "+ memberAddress + "</p><p>Phone Number : "+ memberPhone + "</p><p>Payment Date: " + paymentDate + "</p><p>Payment Method: " + paymentMethod + "</p></div><div class=\"main-bottom\">" +
                    "<table style=\"width:90%;margin:4% 4% 1% 4%;border-collapse:collapse;\">" +
                    "<tr style = \"font-size: 25px; color: white; background-color: #0b2c97; \" >" +
                    "<td> Event </td><td> Ticket </td>" +
                    "<td style=\"width:30%;\">Quantity</td>" +
                    "<td style = \"width:10%;\" > Price </td></tr>";

                int conNew = 0;
                int conNew2 = 0;

                for (int j = 0; j < eventIDCountArray.Count; j++)
                {
                    int q = 0;

                    for (int z = conNew; z < eventCategoryCountArray[j] + conNew2; z++)
                    {
                        if (q == 0)
                        {
                            mailbody += "<tr><td>" + eventNameArray[j] + " </td>" + "<td>" + ticketCategoryArray[z] + "</td><td>" + totalQuantityArray[z] + " </td><td>RM " + subtotalArray[z] + "</td></tr>";
                        }
                        else
                        {
                            mailbody += "<tr><td>" + " </td>" + "<td>" + ticketCategoryArray[z] + "</td><td>" + totalQuantityArray[z] + " </td><td>RM " + subtotalArray[z] + "</td></tr>";
                        }
                        q++;
                        conNew = z;
                    }
                    conNew++;
                    conNew2 = conNew;


                }
                mailbody += "</table><hr style = \"width:91%;\"><table style=\"width: 30%; float: right;\"><tr><td>Subtotal</td><td>: RM " + carttotalLabel+ "</td></tr><tr><td>Discount</td><td>: RM " + amountDiscountLabel+ "</td></tr><tr><td>Tax</td><td>: RM " + amounttaxLabel+ "</td>" +
                "</tr><tr><td>Total Paid</td><td>: RM " + finalLabel + "</td></tr></table></div></div></div></body></html>";







                message.Subject = "Eventy Payment Receipt for Payment #" + paymentID;
                message.Body = mailbody;
                message.BodyEncoding = Encoding.UTF8;
                message.IsBodyHtml = true;
                SmtpClient client = new SmtpClient("smtp.gmail.com", 587); //Gmail smtp    
                client.UseDefaultCredentials = false;
                client.Credentials = new NetworkCredential("eventy366@gmail.com", "srbd qtvb pubt zqfs");
                client.EnableSsl = true;
                client.Send(message);


                Session["discountLabel"] = "";
                Session["carttotalLabel"] = "";
                Session["amountDiscountLabel"] = "";
                Session["amounttaxLabel"] = "";
                Session["finalLabel"] = "";
                Session["promoCode"] = "";


                Response.Write("<script>window.location.replace(\"memberPaymentMessage.aspx?paymentID=" + paymentID + "\");</script>");


            }
        }
    }
}