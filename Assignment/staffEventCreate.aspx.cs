using PayPal.Api;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class staffEventCreate : System.Web.UI.Page
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
            if (IsPostBack)
            {
                Page.Validate();/*Control validation group name optional*/
                if (Page.IsValid)
                {

                    Boolean isValid = true;
                    string strAdd = "Insert Into Event(eventName,eventDescription,eventStatus,eventStartTime,eventEndTime,eventStartDate,eventEndDate,eventVenue,eventOrganizer,eventImage,categoryID,isArchive,staffID) Values (@name,@eventDescription,@eventStatus,@eventStartTime,@eventEndTime,@eventStartDate,@eventEndDate,@eventVenue,@eventOrganizer,@eventImage,@categoryID,@isArchive,@staffID)";
                    SqlCommand cmdAdd = new SqlCommand(strAdd, con);
                    var dateStart = DateTime.Parse(txtEventStartDate.Text);
                    var dateEnd = DateTime.Parse(txtEventEndDate.Text);
                    var timeStart = DateTime.Parse(txtEventStartTime.Text);
                    var timeEnd = DateTime.Parse(txtEventEndTime.Text);
                    var today = DateTime.Now;
                    if (dateStart > today)
                    {

                   
                    if (dateEnd == dateStart)
                    {
                        if (timeEnd <= timeStart)
                        {
                            isValid = false;
                            Response.Write("<script> alert('End Time must greater than Start Time'); </script>");
                        }
                        else
                        {

                        }
                    }
                    }
                    else
                    {
                        isValid = false;
                        Response.Write("<script> alert('Start Date must greater than Today'); </script>");

                    }

                    if (isValid == true)
                    {
                        cmdAdd.Parameters.AddWithValue("@name", txtEventName.Text);
                        cmdAdd.Parameters.AddWithValue("@eventDescription", txtEventDescription.Text);
                        cmdAdd.Parameters.AddWithValue("@eventStatus", ddlEventStatus.SelectedValue);
                        cmdAdd.Parameters.AddWithValue("@eventStartTime", timeStart);
                        cmdAdd.Parameters.AddWithValue("@eventEndTime", timeEnd);
                        cmdAdd.Parameters.AddWithValue("@eventStartDate", dateStart);
                        cmdAdd.Parameters.AddWithValue("@eventEndDate", dateEnd);
                        cmdAdd.Parameters.AddWithValue("@eventVenue", txtEventAddress.Text);
                        cmdAdd.Parameters.AddWithValue("@eventOrganizer", txtEventOrganizer.Text);
                        cmdAdd.Parameters.AddWithValue("@categoryID", ddlEventCategory.SelectedValue);
                        cmdAdd.Parameters.AddWithValue("@eventImage", imgEvent.ImageUrl);
                        cmdAdd.Parameters.AddWithValue("@isArchive", "0");
                        cmdAdd.Parameters.AddWithValue("@staffID", Convert.ToInt32(Session["staffID"].ToString()));
                        con.Open();
                        int n = cmdAdd.ExecuteNonQuery();
                        con.Close();

                        int eventID = 0;
                        con.Open();
                        string strSelect = "Select eventID From Event order by eventID DESC";

                        SqlCommand cmdSelect = new SqlCommand(strSelect, con);



                        SqlDataReader dtrStaff = cmdSelect.ExecuteReader();
                        int i = 0;
                        while (dtrStaff.Read() && i == 0)
                        {

                            eventID = Convert.ToInt32(dtrStaff["eventID"]);
                            i++;
                        }
                        con.Close();

                        string strAdd2 = "Insert Into TicketPrice(price,totalQuantity,quantityLeft,ticketCategoryID,eventID) Values (@price,@totalQuantity,@quantityLeft,@ticketCategoryID,@eventID)";
                        SqlCommand cmdAdd2 = new SqlCommand(strAdd2, con);
                        cmdAdd2.Parameters.AddWithValue("@price", SeniorPrice.Text);
                        cmdAdd2.Parameters.AddWithValue("@totalQuantity", seniorQty.Text);
                        cmdAdd2.Parameters.AddWithValue("@quantityLeft", seniorQty.Text);
                        cmdAdd2.Parameters.AddWithValue("@ticketCategoryID", 800001);
                        cmdAdd2.Parameters.AddWithValue("@eventID", eventID);

                        SqlCommand cmdAdd3 = new SqlCommand(strAdd2, con);
                        cmdAdd3.Parameters.AddWithValue("@price", kidPrice.Text);
                        cmdAdd3.Parameters.AddWithValue("@totalQuantity", kidQty.Text);
                        cmdAdd3.Parameters.AddWithValue("@quantityLeft", kidQty.Text);
                        cmdAdd3.Parameters.AddWithValue("@ticketCategoryID", 800002);
                        cmdAdd3.Parameters.AddWithValue("@eventID", eventID);

                        SqlCommand cmdAdd4 = new SqlCommand(strAdd2, con);
                        cmdAdd4.Parameters.AddWithValue("@price", studentPrice.Text);
                        cmdAdd4.Parameters.AddWithValue("@totalQuantity", studentQty.Text);
                        cmdAdd4.Parameters.AddWithValue("@quantityLeft", studentQty.Text);
                        cmdAdd4.Parameters.AddWithValue("@ticketCategoryID", 800003);
                        cmdAdd4.Parameters.AddWithValue("@eventID", eventID);

                        SqlCommand cmdAdd5 = new SqlCommand(strAdd2, con);
                        cmdAdd5.Parameters.AddWithValue("@price", adultPrice.Text);
                        cmdAdd5.Parameters.AddWithValue("@totalQuantity", adultQty.Text);
                        cmdAdd5.Parameters.AddWithValue("@quantityLeft", adultQty.Text);
                        cmdAdd5.Parameters.AddWithValue("@ticketCategoryID", 800004);
                        cmdAdd5.Parameters.AddWithValue("@eventID", eventID);

                        SqlCommand cmdAdd6 = new SqlCommand(strAdd2, con);
                        cmdAdd6.Parameters.AddWithValue("@price", okuPrice.Text);
                        cmdAdd6.Parameters.AddWithValue("@totalQuantity", okuQty.Text);
                        cmdAdd6.Parameters.AddWithValue("@quantityLeft", okuQty.Text);
                        cmdAdd6.Parameters.AddWithValue("@ticketCategoryID", 800005);
                        cmdAdd6.Parameters.AddWithValue("@eventID", eventID);

                        con.Open();

                        int n2 = cmdAdd2.ExecuteNonQuery();
                        int n3 = cmdAdd3.ExecuteNonQuery();
                        int n4 = cmdAdd4.ExecuteNonQuery();
                        int n5 = cmdAdd5.ExecuteNonQuery();
                        int n6 = cmdAdd6.ExecuteNonQuery();

                        con.Close();
                        if (n > 0)
                        {
                            Response.Write("<script> alert('Record is added'); </script>");
                            Response.Write("<script>  window.location.replace(\'/staffEvent.aspx\') </script>");
                        }

                        else
                            Response.Write("<script> alert('Record unsuccessfully added'); </script>");


                    }
                }
            }
        }

        protected void btnEventReset_Click(object sender, EventArgs e)
        {
            txtEventName.Text = "";
            txtEventDescription.Text = "";

            ddlEventStatus.ClearSelection();
            ddlEventCategory.ClearSelection();
            txtEventStartDate.Text = DateTime.Now.ToShortDateString();
            txtEventEndDate.Text = "";
            txtEventStartTime.Text = "";
            txtEventEndTime.Text = "";
            txtEventOrganizer.Text = "";
            txtEventAddress.Text = "";
            SeniorPrice.Text = "";
            seniorQty.Text = "";
            adultQty.Text = "";
            adultPrice.Text = "";
            okuQty.Text = "";
            okuPrice.Text = "";
            kidQty.Text = "";
            kidPrice.Text = "";
            studentQty.Text = "";
            studentPrice.Text = "";

        }


        protected void btnImageUpload_Click(object sender, EventArgs e)
        {
            string folderPath = Server.MapPath("~/upload/");

            //Check whether Directory (Folder) exists.
            if (!Directory.Exists(folderPath))
            {
                //If Directory (Folder) does not exists Create it.
                Directory.CreateDirectory(folderPath);
            }

            //Save the File to the Directory (Folder).
            fuImage.SaveAs(folderPath + Path.GetFileName(fuImage.FileName));

            //Display the Picture in Image control.

            imgEvent.ImageUrl = "~/upload/" + Path.GetFileName(fuImage.FileName);






        }
    }
}