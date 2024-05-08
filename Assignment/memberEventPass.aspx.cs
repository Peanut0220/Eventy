using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.Expressions;
using static System.Net.Mime.MediaTypeNames;
using System.Xml;
using System.Reflection;

namespace Assignment
{
    public partial class memberEventPass : System.Web.UI.Page
    {
        int i = 0;
        int isSearch = 0;
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");
        static string DatabaseConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["memberID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
            i = 0;
            BindRepeater();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

         
            Response.Redirect("~/memberEventPass.aspx?search="+ TextBox1.Text);

        }
        public string status1()
        {
            RepeaterItem item = Repeater1.Items[i];
            Label ok = (Label)item.FindControl("Label1");
            string status = ok.Text;
            i++;
            return status;
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
            int val;
          
            string search = Request.QueryString["search"];
            if (search != ""&& search!=null)
            {
                if (int.TryParse(search, out val))
                {

                    cmd.CommandText= "SELECT * FROM Event_Pass INNER JOIN RecordEvent ON RecordEvent.recordEventID = Event_Pass.recordEventID INNER JOIN Event ON Event.eventID = RecordEvent.eventID where Event_Pass.memberID = @memberID and (Event_Pass.passID = @search1 OR Event_Pass.passStatus = @search2 OR Event.eventName LIKE '%' + @search2 + '%' OR Event.eventVenue LIKE '%' + @search2 + '%' OR RecordEvent.ticketCategory LIKE '%' + @search2 + '%' OR RecordEvent.totalQuantity =@search1) ORDER BY Event_Pass.passID DESC";
                    cmd.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));
                    cmd.Parameters.AddWithValue("@search1", Convert.ToInt32(search));
                    cmd.Parameters.AddWithValue("@search2", search);

                    SqlDataSource2.SelectCommand = "SELECT COUNT(Event_Pass.passID) AS count FROM Event_Pass INNER JOIN RecordEvent ON RecordEvent.recordEventID = Event_Pass.recordEventID INNER JOIN Event ON Event.eventID = RecordEvent.eventID where Event_Pass.memberID = @memberID and (Event_Pass.passID = @search1 OR Event_Pass.passStatus = @search2 OR Event.eventName LIKE '%' + @search2 + '%' OR Event.eventVenue LIKE '%' + @search2 + '%' OR RecordEvent.ticketCategory LIKE '%' + @search2 + '%' OR RecordEvent.totalQuantity =@search1)";
                    SqlDataSource2.SelectParameters.Clear();
                    SqlDataSource2.SelectParameters.Add("memberID", DbType.Int32, Session["memberID"].ToString());
                    SqlDataSource2.SelectParameters.Add("search1", DbType.Int32, search);
                    SqlDataSource2.SelectParameters.Add("search2", DbType.String, search);
                    Repeater2.DataBind();


                }
                else
                {

                    cmd.CommandText = "SELECT * FROM Event_Pass INNER JOIN RecordEvent ON RecordEvent.recordEventID = Event_Pass.recordEventID INNER JOIN Event ON Event.eventID = RecordEvent.eventID where Event_Pass.memberID = @memberID and (Event_Pass.passStatus = @search2 OR Event.eventName LIKE '%' + @search2 + '%' OR Event.eventVenue LIKE '%' + @search2 + '%' OR RecordEvent.ticketCategory LIKE '%' + @search2 + '%') ORDER BY Event_Pass.passID DESC";
                    cmd.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));
                    cmd.Parameters.AddWithValue("@search2", search);

                    SqlDataSource2.SelectCommand = "SELECT COUNT(Event_Pass.passID) AS count FROM Event_Pass INNER JOIN RecordEvent ON RecordEvent.recordEventID = Event_Pass.recordEventID INNER JOIN Event ON Event.eventID = RecordEvent.eventID where Event_Pass.memberID = @memberID and (Event_Pass.passStatus = @search2 OR Event.eventName LIKE '%' + @search2 + '%' OR Event.eventVenue LIKE '%' + @search2 + '%' OR RecordEvent.ticketCategory LIKE '%' + @search2 + '%')";
                    SqlDataSource2.SelectParameters.Clear();
                    SqlDataSource2.SelectParameters.Add("memberID", DbType.Int32, Session["memberID"].ToString());
                    SqlDataSource2.SelectParameters.Add("search2", DbType.String, search);
                    Repeater2.DataBind();

                }
            
            }
            else
            {
                cmd.CommandText = "SELECT * FROM Event_Pass INNER JOIN RecordEvent ON RecordEvent.recordEventID = Event_Pass.recordEventID INNER JOIN Event ON Event.eventID = RecordEvent.eventID where Event_Pass.memberID = @memberID ORDER BY Event_Pass.passID DESC";
                cmd.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));


                SqlDataSource2.SelectCommand = "SELECT COUNT(Event_Pass.passID) AS count FROM Event_Pass INNER JOIN RecordEvent ON RecordEvent.recordEventID = Event_Pass.recordEventID INNER JOIN Event ON Event.eventID = RecordEvent.eventID where Event_Pass.memberID = @memberID";
                SqlDataSource2.SelectParameters.Clear();
                SqlDataSource2.SelectParameters.Add("memberID", DbType.Int32, Session["memberID"].ToString());
                Repeater2.DataBind();
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


            Repeater1.DataSourceID = null;
            Repeater1.DataSource = pgitems;
            Repeater1.DataBind();

            if (Repeater1.Items.Count < 1 && search != "" && search != null)
            {
                Response.Write("<script> alert('No record found'); window.location.replace(\"memberEventPass.aspx\");</script>");

            }else if (Repeater1.Items.Count < 1)
            {
                Response.Write("<script> alert('No record found');</script>");

            }
            else
            {

            }
        }


        protected void rptPaging_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            PageNumber = Convert.ToInt32(e.CommandArgument) - 1;

            BindRepeater();
        }
    }
}