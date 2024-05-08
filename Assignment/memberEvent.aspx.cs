using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Mvc;
using System.Net.NetworkInformation;

namespace Assignment
{
    public partial class memberEvent : System.Web.UI.Page
    {
        int i = 0;
        SqlConnection conn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        static string DatabaseConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["memberID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
            List<int> idArray = new List<int>();
            List<int> booleanArray = new List<int>();
            conn.Open();
            string strSelect = "SELECT DISTINCT(Event.eventID) FROM Event INNER JOIN TicketPrice ON TicketPrice.eventID = Event.eventID WHERE Event.isArchive=0";
            SqlCommand cmdSelect = new SqlCommand(strSelect, conn);

            SqlDataReader dtrCart = cmdSelect.ExecuteReader();

            while (dtrCart.Read())
            {
                idArray.Add(Convert.ToInt32(dtrCart["eventID"]));

            }
            conn.Close();

            for (int i = 0; i < idArray.Count; i++)
            {
                int found = 0;
                conn.Open();
                strSelect = "SELECT * FROM Event INNER JOIN TicketPrice ON TicketPrice.eventID = Event.eventID WHERE Event.eventID=@eventID";
                cmdSelect = new SqlCommand(strSelect, conn);
                cmdSelect.Parameters.AddWithValue("@eventID", idArray[i]);

                dtrCart = cmdSelect.ExecuteReader();

                while (dtrCart.Read())
                {

                    if (Convert.ToInt32(dtrCart["quantityLeft"]) > 0)
                    {
                        found = 1;
                    }

                }
                conn.Close();
                if (found == 1)
                {
                    booleanArray.Add(1);
                }
                else
                {
                    booleanArray.Add(0);
                }

            }

            for (int i = 0; i < booleanArray.Count; i++)
            {
                if (booleanArray[i] == 0)
                {
                    conn.Open();
                    strSelect = "UPDATE Event Set eventStatus= @status WHERE eventID=@eventID";
                    cmdSelect = new SqlCommand(strSelect, conn);
                    cmdSelect.Parameters.AddWithValue("@status", "Sold Out");
                    cmdSelect.Parameters.AddWithValue("@eventID", idArray[i]);
                    cmdSelect.ExecuteNonQuery();
                    conn.Close();
                }
            }
            i = 0;
            BindRepeater();

        }

        public string status1()
        {
            RepeaterItem item = eventRpt.Items[i];
            Label ok = (Label)item.FindControl("Label1");
            string status = ok.Text;
            i++;
            return status;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }

        public int PageNumber
        {
            get
            {
                if (ViewState["PageNumber"] != null)
                {
                    return Convert.ToInt32(ViewState["PageNumber"]);
                }
                else
                {
                    return 0;
                }
            }

            set { ViewState["PageNumber"] = value; }
        }
        private void BindRepeater()
        {

            SqlConnection cn = new SqlConnection(DatabaseConnectionString);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = cn;
            SqlDataAdapter ad = new SqlDataAdapter(cmd);

            string categoryFilter = "";
            string startFilter = "";
            string endFilter = "";
            string search = "";
            search = Request.QueryString["search"];
            categoryFilter = Request.QueryString["filter1"];
            startFilter = Request.QueryString["filter2"];
            endFilter = Request.QueryString["filter3"];


            if (search != "" && search != null)
            {
            
                cmd.CommandText = "SELECT * FROM Event WHERE ( eventStatus = @status1 OR eventStatus = @status2 ) AND eventName LIKE '%' + @search + '%' and isArchive=0";
                cmd.Parameters.AddWithValue("@search", search);
                cmd.Parameters.AddWithValue("@status1", "Open for Registration");
                cmd.Parameters.AddWithValue("@status2", "Upcoming");

                SqlDataSource3.SelectCommand = "SELECT COUNT(eventID) as count FROM Event WHERE ( eventStatus = @status1 OR eventStatus = @status2 ) AND eventName LIKE '%' + @search + '%' and isArchive=0";
                SqlDataSource3.SelectParameters.Clear();
                SqlDataSource3.SelectParameters.Add("status1", DbType.String, "Open for Registration");
                SqlDataSource3.SelectParameters.Add("status2", DbType.String, "Upcoming");
                SqlDataSource3.SelectParameters.Add("search", DbType.String, search);

                Repeater2.DataBind();
           
            }
            else
            {

                //category, start, end
                if (categoryFilter != "-- Select One --" && categoryFilter != null && startFilter != "" && startFilter != null && endFilter != "" && endFilter != null)
                {
                    cmd.CommandText = "SELECT * FROM Event WHERE (eventStatus = @status1 OR eventStatus = @status2) AND categoryID=@categoryID AND eventStartDate>=@startDate AND eventEndDate<=@endDate AND isArchive=0";
                    cmd.Parameters.AddWithValue("@status1", "Open for Registration");
                    cmd.Parameters.AddWithValue("@status2", "Upcoming");
                    cmd.Parameters.AddWithValue("@categoryID", Convert.ToInt32(categoryFilter));
                    cmd.Parameters.AddWithValue("@startDate", Convert.ToDateTime(startFilter));
                    cmd.Parameters.AddWithValue("@endDate", Convert.ToDateTime(endFilter));

                    SqlDataSource3.SelectCommand = "SELECT COUNT(eventID) as count FROM Event WHERE ( eventStatus = @status1 OR eventStatus = @status2) and isArchive=0 and categoryID=@categoryID AND eventStartDate>=@startDate AND eventEndDate<=@endDate";
                    SqlDataSource3.SelectParameters.Clear();
                    SqlDataSource3.SelectParameters.Add("status1", DbType.String, "Open for Registration");
                    SqlDataSource3.SelectParameters.Add("status2", DbType.String, "Upcoming");
                    SqlDataSource3.SelectParameters.Add("categoryID", DbType.Int32, categoryFilter);
                    SqlDataSource3.SelectParameters.Add("startDate", DbType.DateTime, startFilter);
                    SqlDataSource3.SelectParameters.Add("endDate", DbType.DateTime, endFilter);

                    Repeater2.DataBind();


                }
                else if ((categoryFilter != "-- Select One --" && categoryFilter != null) && (startFilter != "" && startFilter != null) && (endFilter == "" || endFilter == null))
                {   //category, start,
                    cmd.CommandText = "SELECT * FROM Event WHERE (eventStatus = @status1 OR eventStatus = @status2) AND categoryID=@categoryID AND eventStartDate>=@startDate AND isArchive=0";
                    cmd.Parameters.AddWithValue("@status1", "Open for Registration");
                    cmd.Parameters.AddWithValue("@status2", "Upcoming");
                    cmd.Parameters.AddWithValue("@categoryID", Convert.ToInt32(categoryFilter));
                    cmd.Parameters.AddWithValue("@startDate", Convert.ToDateTime(startFilter));


                    SqlDataSource3.SelectCommand = "SELECT COUNT(eventID) as count FROM Event WHERE ( eventStatus = @status1 OR eventStatus = @status2) and isArchive=0 and categoryID=@categoryID AND eventStartDate>=@startDate";
                    SqlDataSource3.SelectParameters.Clear();
                    SqlDataSource3.SelectParameters.Add("status1", DbType.String, "Open for Registration");
                    SqlDataSource3.SelectParameters.Add("status2", DbType.String, "Upcoming");
                    SqlDataSource3.SelectParameters.Add("categoryID", DbType.Int32, categoryFilter);
                    SqlDataSource3.SelectParameters.Add("startDate", DbType.DateTime, startFilter);


                    Repeater2.DataBind();



                }
                else if ((categoryFilter != "-- Select One --" && categoryFilter != null) && (startFilter == "" || startFilter == null) && (endFilter == "" || endFilter == null))
                {
                    //category, ,
                    cmd.CommandText = "SELECT * FROM Event WHERE (eventStatus = @status1 OR eventStatus = @status2) AND categoryID=@categoryID AND isArchive=0";
                    cmd.Parameters.AddWithValue("@status1", "Open for Registration");
                    cmd.Parameters.AddWithValue("@status2", "Upcoming");
                    cmd.Parameters.AddWithValue("@categoryID", Convert.ToInt32(categoryFilter));



                    SqlDataSource3.SelectCommand = "SELECT COUNT(eventID) as count FROM Event WHERE ( eventStatus = @status1 OR eventStatus = @status2) and isArchive=0 and categoryID=@categoryID ";
                    SqlDataSource3.SelectParameters.Clear();
                    SqlDataSource3.SelectParameters.Add("status1", DbType.String, "Open for Registration");
                    SqlDataSource3.SelectParameters.Add("status2", DbType.String, "Upcoming");
                    SqlDataSource3.SelectParameters.Add("categoryID", DbType.Int32, categoryFilter);

                    Repeater2.DataBind();



                }
                else if ((categoryFilter != "-- Select One --" && categoryFilter != null) && (startFilter == "" || startFilter == null) && (endFilter != "" && endFilter != null))
                {
                    //category, ,end
                    cmd.CommandText = "SELECT * FROM Event WHERE (eventStatus = @status1 OR eventStatus = @status2) AND categoryID=@categoryID AND eventEndDate<=@endDate AND isArchive=0";
                    cmd.Parameters.AddWithValue("@status1", "Open for Registration");
                    cmd.Parameters.AddWithValue("@status2", "Upcoming");
                    cmd.Parameters.AddWithValue("@categoryID", Convert.ToInt32(categoryFilter));

                    cmd.Parameters.AddWithValue("@endDate", Convert.ToDateTime(endFilter));

                    SqlDataSource3.SelectCommand = "SELECT COUNT(eventID) as count FROM Event WHERE ( eventStatus = @status1 OR eventStatus = @status2) and isArchive=0 and categoryID=@categoryID AND eventEndDate<=@endDate";
                    SqlDataSource3.SelectParameters.Clear();
                    SqlDataSource3.SelectParameters.Add("status1", DbType.String, "Open for Registration");
                    SqlDataSource3.SelectParameters.Add("status2", DbType.String, "Upcoming");
                    SqlDataSource3.SelectParameters.Add("categoryID", DbType.Int32, categoryFilter);

                    SqlDataSource3.SelectParameters.Add("endDate", DbType.DateTime, endFilter);


                    Repeater2.DataBind();



                }
                else if ((categoryFilter == "-- Select One --" || categoryFilter == null) && (startFilter != "" && startFilter != null) && (endFilter != "" && endFilter != null))
                {
                    //    ,start ,end
                    cmd.CommandText = "SELECT * FROM Event WHERE (eventStatus = @status1 OR eventStatus = @status2) AND eventStartDate>=@startDate AND eventEndDate<=@endDate AND isArchive=0";
                    cmd.Parameters.AddWithValue("@status1", "Open for Registration");
                    cmd.Parameters.AddWithValue("@status2", "Upcoming");

                    cmd.Parameters.AddWithValue("@startDate", Convert.ToDateTime(startFilter));
                    cmd.Parameters.AddWithValue("@endDate", Convert.ToDateTime(endFilter));

                    SqlDataSource3.SelectCommand = "SELECT COUNT(eventID) as count FROM Event WHERE ( eventStatus = @status1 OR eventStatus = @status2) and isArchive=0 AND eventStartDate>=@startDate AND eventEndDate<=@endDate";
                    SqlDataSource3.SelectParameters.Clear();
                    SqlDataSource3.SelectParameters.Add("status1", DbType.String, "Open for Registration");
                    SqlDataSource3.SelectParameters.Add("status2", DbType.String, "Upcoming");

                    SqlDataSource3.SelectParameters.Add("startDate", DbType.DateTime, startFilter);
                    SqlDataSource3.SelectParameters.Add("endDate", DbType.DateTime, endFilter);

                    Repeater2.DataBind();



                }
                else if ((categoryFilter == "-- Select One --" || categoryFilter == null) && (startFilter != "" && startFilter != null) && (endFilter == "" || endFilter == null))
                {
                    //    ,start ,
                    cmd.CommandText = "SELECT * FROM Event WHERE (eventStatus = @status1 OR eventStatus = @status2) AND eventStartDate>=@startDate AND isArchive=0";
                    cmd.Parameters.AddWithValue("@status1", "Open for Registration");
                    cmd.Parameters.AddWithValue("@status2", "Upcoming");

                    cmd.Parameters.AddWithValue("@startDate", Convert.ToDateTime(startFilter));

                    SqlDataSource3.SelectCommand = "SELECT COUNT(eventID) as count FROM Event WHERE ( eventStatus = @status1 OR eventStatus = @status2) and isArchive=0 AND eventStartDate>=@startDate";
                    SqlDataSource3.SelectParameters.Clear();
                    SqlDataSource3.SelectParameters.Add("status1", DbType.String, "Open for Registration");
                    SqlDataSource3.SelectParameters.Add("status2", DbType.String, "Upcoming");

                    SqlDataSource3.SelectParameters.Add("startDate", DbType.DateTime, startFilter);


                    Repeater2.DataBind();



                }
                else if ((categoryFilter == "-- Select One --" || categoryFilter == null) && (startFilter == "" || startFilter == null) && (endFilter != "" && endFilter != null))
                {
                    //    , , end
                    cmd.CommandText = "SELECT * FROM Event WHERE (eventStatus = @status1 OR eventStatus = @status2) AND eventEndDate<=@endDate AND isArchive=0";
                    cmd.Parameters.AddWithValue("@status1", "Open for Registration");
                    cmd.Parameters.AddWithValue("@status2", "Upcoming");


                    cmd.Parameters.AddWithValue("@endDate", Convert.ToDateTime(endFilter));

                    SqlDataSource3.SelectCommand = "SELECT COUNT(eventID) as count FROM Event WHERE ( eventStatus = @status1 OR eventStatus = @status2) and isArchive=0 AND eventEndDate<=@endDate";
                    SqlDataSource3.SelectParameters.Clear();
                    SqlDataSource3.SelectParameters.Add("status1", DbType.String, "Open for Registration");
                    SqlDataSource3.SelectParameters.Add("status2", DbType.String, "Upcoming");


                    SqlDataSource3.SelectParameters.Add("endDate", DbType.DateTime, endFilter);

                    Repeater2.DataBind();

                }
                else
                {
                    cmd.CommandText = "SELECT * FROM[Event] WHERE(eventStatus = @status1 OR eventStatus = @status2) and isArchive = 0";
                    cmd.Parameters.AddWithValue("@status1", "Open for Registration");
                    cmd.Parameters.AddWithValue("@status2", "Upcoming");

                    SqlDataSource3.SelectCommand = "SELECT COUNT(eventID) as count FROM Event WHERE ( eventStatus = @status1 OR eventStatus = @status2) and isArchive=0 ";
                    SqlDataSource3.SelectParameters.Clear();
                    SqlDataSource3.SelectParameters.Add("status1", DbType.String, "Open for Registration");
                    SqlDataSource3.SelectParameters.Add("status2", DbType.String, "Upcoming");
                    Repeater2.DataBind();
                }
            }








            //save the result in data table
            DataTable dt = new DataTable();
            ad.SelectCommand = cmd;
            ad.Fill(dt);


            PagedDataSource pgitems = new PagedDataSource();
            pgitems.DataSource = dt.DefaultView;
            pgitems.AllowPaging = true;


            pgitems.PageSize = 10;
            pgitems.CurrentPageIndex = PageNumber;
            int page = pgitems.CurrentPageIndex + 1;
            Label5.Text = page.ToString();
            if (pgitems.PageCount > 1)
            {
                rptPaging.Visible = true;
                ArrayList pages = new ArrayList();
                for (int i = 0; i <= pgitems.PageCount - 1; i++)
                {
                    pages.Add((i + 1).ToString());
                }
                rptPaging.DataSource = pages;
                rptPaging.DataBind();
            }
            else
            {
                rptPaging.Visible = false;
            }


            eventRpt.DataSourceID = null;
            eventRpt.DataSource = pgitems;
            eventRpt.DataBind();

            if (eventRpt.Items.Count < 1 )
            {
                Response.Write("<script> alert('No record found'); window.location.replace(\"memberEvent.aspx\");</script>");

            }
        }


        protected void rptPaging_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            PageNumber = Convert.ToInt32(e.CommandArgument) - 1;

            BindRepeater();
        }

        protected void linkBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/memberEvent.aspx?search=" + TextBox1.Text);
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/memberEvent.aspx?filter1=" + DropDownList1.SelectedValue + "&filter2=" + TextBox3.Text + "&filter3=" + TextBox2.Text);
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/memberEvent.aspx");
        }
    }
}