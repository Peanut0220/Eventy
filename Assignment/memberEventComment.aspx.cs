using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class memberEventComment : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["memberID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
            string ID = Request.QueryString["eventID"].ToString();

            int found = 0;
            con.Open();
            string strSelect = "SELECT * FROM Event_Pass INNER JOIN RecordEvent ON RecordEvent.recordEventID=Event_Pass.recordEventID where memberID=@memberID and RecordEvent.eventID =@eventID and Event_Pass.passStatus=@status";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));
            cmdSelect.Parameters.AddWithValue("@eventID", Convert.ToInt32(ID));
            cmdSelect.Parameters.AddWithValue("@status", "Used");
            SqlDataReader dtrCart = cmdSelect.ExecuteReader();
            if (dtrCart.HasRows)
            {
                found = 1;
            }
       
            con.Close();

            if (found ==0) {
                Response.Write("<script>alert('Event Pass has not been used yet! Please comment after joining the event!');window.location.replace(\"memberParticipateRecord.aspx\");</script>");
            }

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            string ID = Request.QueryString["eventID"].ToString();
            string commenttext = comment.Text;
            int rating = Convert.ToInt32(ratingTxt.Text);

            con.Open();
            string strInsert = "Insert Into Comment (content, eventID,memberID,rating,createdDate) Values (@content, @eventID,@memberID,@rating,@createdDate)";
            SqlCommand cmdInsert = new SqlCommand(strInsert, con);
            cmdInsert.Parameters.AddWithValue("@content", commenttext);
            cmdInsert.Parameters.AddWithValue("@eventID", Convert.ToInt32(ID));
            cmdInsert.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));
            cmdInsert.Parameters.AddWithValue("@rating", rating);
            cmdInsert.Parameters.AddWithValue("@createdDate", DateTime.Now);
            cmdInsert.ExecuteNonQuery();
            con.Close();
            Response.Write("<script>alert('Thanks For Commenting!');window.location.replace(\"memberParticipateRecord.aspx\");</script>");

        }
    }
} 