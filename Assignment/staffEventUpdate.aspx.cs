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
    public partial class staffEventUpdate : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }

            if (Request.QueryString["eventID"] == null)
            {
                Response.Redirect("~/staffEvent.aspx");
            }

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
            RepeaterItem item = Repeater1.Items[0];
            FileUpload fuImage = (FileUpload)item.FindControl("fuImage");
            fuImage.SaveAs(folderPath + Path.GetFileName(fuImage.FileName));

            //Display the Picture in Image control.
            Image imgEvent = (Image)item.FindControl("imgEvent");
            imgEvent.ImageUrl = "~/upload/" + Path.GetFileName(fuImage.FileName);
        }

        protected void btnEventUpdate_Click(object sender, EventArgs e)
        {
            Boolean isValid = true;
            String tempStatus = "";

            RepeaterItem item = Repeater1.Items[0];
            TextBox name = (TextBox)item.FindControl("txtEventNameUpdate");
            TextBox eventDescription = (TextBox)item.FindControl("txtEventDescriptionUpdate");
            TextBox eventStartDate = (TextBox)item.FindControl("txtEventStartDateUpdate");
            TextBox eventEndDate = (TextBox)item.FindControl("txtEventEndDateUpdate");
            TextBox eventStartTime = (TextBox)item.FindControl("txtEventStartTimeUpdate");
            TextBox eventEndTime = (TextBox)item.FindControl("txtEventEndTimeUpdate");
            Image imgEvent = (Image)item.FindControl("imgEvent");
            TextBox eventVenue = (TextBox)item.FindControl("txtEventAddressUpdate");
            TextBox eventOrganizer = (TextBox)item.FindControl("txtEventOrganizerUpdate");
            Label id = (Label)item.FindControl("Label1");
            Label startDate2 = (Label)item.FindControl("LabelStartDate");
            CompareValidator compare = (CompareValidator)item.FindControl("CompareValidator2");
            DropDownList status = null;
            DropDownList cate = null;
            int valueCategory = 0;

            var startDate = DateTime.Parse(eventStartDate.Text);
            var startTime = DateTime.Parse(eventStartTime.Text);
            var endDate = DateTime.Parse(eventEndDate.Text);
            var endTime = DateTime.Parse(eventEndTime.Text);
            var startDate3 = DateTime.Parse(startDate2.Text);

            var today = DateTime.Now;
            if(startDate != startDate3) { 
            if (startDate > today)
            {
                if (endDate == startDate)
            {
                if (endTime <= startTime)
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
            }




            con.Open();
            string strSelect = "Select * From Event where eventID=@eventID";

            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@eventID", id.Text);

            SqlDataReader dtrEvent = cmdSelect.ExecuteReader();

            while (dtrEvent.Read())
            {
                tempStatus = dtrEvent["eventStatus"].ToString();

            }

            if (tempStatus.Equals("Upcoming"))
            {

                status = (DropDownList)item.FindControl("ddlEventStatusUpdate");
            }
            else if (tempStatus.Equals("Open for Registration"))
            {

                status = (DropDownList)item.FindControl("DropDownList1");
            }
            else if (tempStatus.Equals("Sold Out"))
            {

                status = (DropDownList)item.FindControl("DropDownList2");
            }
            else
            {
                status = (DropDownList)item.FindControl("DropDownList3");
            }
            con.Close();

            con.Open();
            String tempCategory = "";
            string strSelect2 = "Select *  From Event Where eventID=@eventID";

            SqlCommand cmdSelect2 = new SqlCommand(strSelect2, con);
            cmdSelect2.Parameters.AddWithValue("@eventID", id.Text);

            SqlDataReader dtrEvent2 = cmdSelect2.ExecuteReader();

            while (dtrEvent2.Read())
            {
                tempCategory = dtrEvent2["categoryID"].ToString();

            }

            if (tempCategory.Equals("700001"))
            {

                cate = (DropDownList)item.FindControl("ddlEventCategoryUpdate");
            }
            else if (tempCategory.Equals("700002"))
            {

                cate = (DropDownList)item.FindControl("ddl2");
            }
            else if (tempCategory.Equals("700003"))
            {

                cate = (DropDownList)item.FindControl("ddl3");
            }
            else if (tempCategory.Equals("700004"))
            {

                cate = (DropDownList)item.FindControl("ddl4");
            }
            else if (tempCategory.Equals("700005"))
            {

                cate = (DropDownList)item.FindControl("ddl5");
            }
            else if (tempCategory.Equals("700006"))
            {

                cate = (DropDownList)item.FindControl("ddl6");
            }
            else if(tempCategory.Equals("700007"))
            {
                cate = (DropDownList)item.FindControl("ddl7");
            }
            else if (tempCategory.Equals("700008"))
            {
                cate = (DropDownList)item.FindControl("ddl8");
            }
            else 
            {
                cate = (DropDownList)item.FindControl("ddl9");
            }


            con.Close();

            if (cate.SelectedValue == "Social")
            {
                valueCategory = 700001;
            }
            else if (cate.SelectedValue == "Cultural")
            {
                valueCategory = 700002;
            }
            else if (cate.SelectedValue == "Sports")
            {
                valueCategory = 700003;
            }
            else if (cate.SelectedValue == "Educational")
            {
                valueCategory = 700004;
            }
            else if (cate.SelectedValue == "Entertainment")
            {
                valueCategory = 700005;
            }
            else if (cate.SelectedValue == "Technology")
            {
                valueCategory = 700006;
            }
            else if(cate.SelectedValue == "Health and Welness")
            {
                valueCategory = 700007;
            }
            else if (cate.SelectedValue == "Food")
            {
                valueCategory = 700008;
            }
            else 
            {
                valueCategory = 700009;
            }

            if (isValid == true)
            {
                string strEdit = "Update Event Set eventName=@name,eventStatus=@eventStatus,eventDescription=@eventDescription,eventStartDate=@eventStartDate,eventEndDate=@eventEndDate,eventStartTime=@eventStartTime,eventEndTime=@eventEndTime,eventImage=@imgEvent,eventVenue=@eventVenue,eventOrganizer=@eventOrganizer Where eventID= @eventID";

                SqlCommand cmdEdit = new SqlCommand(strEdit, con);
                cmdEdit.Parameters.AddWithValue("@name", name.Text);
                cmdEdit.Parameters.AddWithValue("@eventDescription", eventDescription.Text);
                cmdEdit.Parameters.AddWithValue("@eventStatus", status.SelectedValue);
                cmdEdit.Parameters.AddWithValue("@eventStartDate", startDate.Date);
                cmdEdit.Parameters.AddWithValue("@eventEndDate", endDate.Date);
                cmdEdit.Parameters.AddWithValue("@eventStartTime", startTime.TimeOfDay);
                cmdEdit.Parameters.AddWithValue("@eventEndTime", endTime.TimeOfDay);
                cmdEdit.Parameters.AddWithValue("@imgEvent", imgEvent.ImageUrl);
                cmdEdit.Parameters.AddWithValue("@eventVenue", eventVenue.Text);
                cmdEdit.Parameters.AddWithValue("@eventOrganizer", eventOrganizer.Text);
                cmdEdit.Parameters.AddWithValue("@eventID", id.Text);

                con.Open();
                int n = cmdEdit.ExecuteNonQuery();

                con.Close();

                string strEdit2 = "Update Event Set categoryID=@categoryID From Event Where eventID= @eventID";
                SqlCommand cmdEdit2 = new SqlCommand(strEdit2, con);
                cmdEdit2.Parameters.AddWithValue("@categoryID", valueCategory);
                cmdEdit2.Parameters.AddWithValue("@eventID", id.Text);
                con.Open();
                int n2 = cmdEdit2.ExecuteNonQuery();

                con.Close();
                for (int i = 0; i < Repeater2.Items.Count; i++)
                {
                    RepeaterItem item2 = Repeater2.Items[i];
                    TextBox qty = (TextBox)item2.FindControl("seniorQty");
                    TextBox price = (TextBox)item2.FindControl("SeniorPrice");
                    Label catID = (Label)item2.FindControl("Label5");


                    int quantity = Convert.ToInt32(qty.Text);
                    string strEdit3 = "Update TicketPrice Set price=@price,quantityLeft=@quantityLeft Where eventID= @eventID and ticketCategoryID=@ticketCategoryID";

                    SqlCommand cmdEdit3 = new SqlCommand(strEdit3, con);
                    cmdEdit3.Parameters.AddWithValue("@quantityLeft", quantity);
                    cmdEdit3.Parameters.AddWithValue("@price", Convert.ToDouble(price.Text));
                    cmdEdit3.Parameters.AddWithValue("@eventID", id.Text);
                    cmdEdit3.Parameters.AddWithValue("@ticketCategoryID", Convert.ToInt32(catID.Text));
                    con.Open();
                    int n3 = cmdEdit3.ExecuteNonQuery();

                    con.Close();


                }


                if (n > 0)
                {
                    Response.Write("<script> alert('Event is successfully edit'); </script>");
                    Response.Write("<script>  window.location.replace(\'/staffEvent.aspx\') </script>");

                }

                else
                {
                    Response.Write("<script> alert('Event unsuccessfully added'); </script>");
                }

            }

        }
        public string status1()
        {
            RepeaterItem item = Repeater1.Items[0];
            Label ok = (Label)item.FindControl("Label3");
            string status = ok.Text;
            return status;
        }

        public string category1()
        {
            RepeaterItem item = Repeater1.Items[0];
            Label ok = (Label)item.FindControl("lblCategory");
            string category = ok.Text;
            return category;
        }
    }
}