using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Drawing;

namespace Assignment
{
    public partial class staffEvent : System.Web.UI.Page
    {
        int i = 0;
        SqlConnection conn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");
        static string DatabaseConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staffID"] == null)
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

            for(int i = 0; i < idArray.Count; i++)
            {
                int found = 0;
                conn.Open();
                strSelect = "SELECT * FROM Event INNER JOIN TicketPrice ON TicketPrice.eventID = Event.eventID WHERE Event.eventID=@eventID";
                cmdSelect = new SqlCommand(strSelect, conn);
                cmdSelect.Parameters.AddWithValue("@eventID", idArray[i]);

                dtrCart = cmdSelect.ExecuteReader();

                while (dtrCart.Read())
                {

                    if (Convert.ToInt32(dtrCart["quantityLeft"]) >0)
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


                BindRepeater();


            i = 0;
        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {

        }
        public string status1()
        {
            RepeaterItem item = Repeater1.Items[i];
            Label ok = (Label)item.FindControl("Label1");
            string status = ok.Text;
            i++;
            return status;
        }

        public string status2()
        {
            RepeaterItem item = Repeater3.Items[i];
            Label ok = (Label)item.FindControl("Label1");
            string status = ok.Text;
            i++;
            return status;
        }

        protected void btnSearchEvent_Click(object sender, EventArgs e)
        {

            if (MultiView1.ActiveViewIndex == 0)
            { 

                Response.Redirect("~/staffEvent.aspx?archive=2&search=" + txtSearch.Text);
            }
            else if (MultiView1.ActiveViewIndex == 1)
            {

                Response.Redirect("~/staffEvent.aspx?archive=1&search=" + txtSearch.Text);
            }





        }


        protected void btnAddEvent_Click(object sender, EventArgs e)
        {

        }

        protected void btnEditEvent_Click(object sender, EventArgs e)
        {

        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void btnDeleteEvent_Click1(object sender, EventArgs e)
        {
            LinkButton btnDelete = (LinkButton)sender;
            string delete = btnDelete.CommandArgument;
            RepeaterItem item = (RepeaterItem)btnDelete.NamingContainer;
            Label ok = (Label)item.FindControl("Label5");
            string strDelete = "Update Event Set isArchive=@isArchive where eventID=@eventID";
            SqlCommand cmdDelete = new SqlCommand(strDelete, conn);
            cmdDelete.Parameters.AddWithValue("@isArchive", 1);
            cmdDelete.Parameters.AddWithValue("@eventID", ok.Text);

            conn.Open();
            int n = cmdDelete.ExecuteNonQuery();

            conn.Close();
            if (n > 0)
            {
                Response.Write("<script> alert('Record is successfully delete'); window.location.replace(\"staffEvent.aspx\");</script>");
            }


        }

        protected void btnUnarchive_Click(object sender, EventArgs e)
        {
            i = 0;
            LinkButton btnUnarchive = (LinkButton)sender;
            string unarchive = btnUnarchive.CommandArgument;
            RepeaterItem item = (RepeaterItem)btnUnarchive.NamingContainer;
            Label ok = (Label)item.FindControl("Label6");
            string strUnarchive = "Update Event Set isArchive=@isArchive where eventID=@eventID";
            SqlCommand cmdUnarchive = new SqlCommand(strUnarchive, conn);
            cmdUnarchive.Parameters.AddWithValue("@isArchive", 0);
            cmdUnarchive.Parameters.AddWithValue("@eventID", ok.Text);

            conn.Open();
            int n = cmdUnarchive.ExecuteNonQuery();

            conn.Close();
            if (n > 0)
            {
                Response.Write("<script> alert('Record is successfully recovered'); window.location.replace(\"staffEvent.aspx\");</script>");
            }
        }

        protected void archive_Click(object sender, EventArgs e)
        {
            i = 0;
            if (MultiView1.ActiveViewIndex == 0)
            {
                MultiView1.ActiveViewIndex = 1;
                archive.Text = "Back";
                title.Text = "Archived Event";
                Response.Redirect("~/staffEvent.aspx?archive=1");
            }
            else if (MultiView1.ActiveViewIndex == 1)
            {
                MultiView1.ActiveViewIndex = 0;
                archive.Text = "Show Archived";
                title.Text = "Event";
                Response.Redirect("~/staffEvent.aspx?archive=2");
            }
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
            int archive1 = 0;
            archive1 = Convert.ToInt32(Request.QueryString["archive"]);
            if (archive1 == 1)
            {
                MultiView1.ActiveViewIndex = 1;
                archive.Text = "Back";
                title.Text = "Archived Event";


            }
            else if (archive1 == 2)
            {
                MultiView1.ActiveViewIndex = 0;
                archive.Text = "Show Archived";
                title.Text = "Event";

            }
            else
            {
            }

            string search = Request.QueryString["search"];
            if (search != "" && search != null)
            {

                    if (MultiView1.ActiveViewIndex == 0)
                    {
                        cmd.CommandText = "SELECT * FROM Event WHERE (eventName LIKE '%' + @SearchTerm + '%' OR eventStatus LIKE '%' + @SearchTerm + '%' ) AND isArchive=0 ORDER BY eventID DESC";

                  
                        cmd.Parameters.AddWithValue("@SearchTerm", search);
                    }
                    else
                    {
                        cmd.CommandText = "SELECT * FROM Event WHERE (eventName LIKE '%' + @SearchTerm + '%' OR eventStatus LIKE '%' + @SearchTerm + '%' )AND isArchive=1 ORDER BY eventID DESC";
                      
                        cmd.Parameters.AddWithValue("@SearchTerm", search);
                    }


            }
            else
            {
                if (MultiView1.ActiveViewIndex == 0)
                {
                    cmd.CommandText = "SELECT * FROM Event WHERE isArchive=0 ORDER BY eventID DESC";



                }
                else
                {
                    cmd.CommandText = "SELECT * FROM Event WHERE isArchive=1 ORDER BY eventID DESC";


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
            if (MultiView1.ActiveViewIndex == 0)
            {
                Repeater1.DataSourceID = null;
                Repeater1.DataSource = pgitems;
                Repeater1.DataBind();
                if (Repeater1.Items.Count < 1 && search != "" && search != null)
                {
                    Response.Write("<script> alert('No record found'); window.location.replace(\"staffEvent.aspx?archive=2\");</script>");

                }
                else if (Repeater1.Items.Count < 1)
                {
                    Response.Write("<script> alert('No record found');</script>");
                }
                else
                {

                }


            }
            else
            {
                Repeater3.DataSourceID = null;
                Repeater3.DataSource = pgitems;
                Repeater3.DataBind();
                if (Repeater3.Items.Count < 1 && search != "" && search != null)
                {
                    Response.Write("<script> alert('No record found'); window.location.replace(\"staffEvent.aspx?archive=1\");</script>");

                }
                else if (Repeater3.Items.Count < 1)
                {
                    Response.Write("<script> alert('No record found');</script>");
                }
                else
                {

                }

            }


        }



        protected void rptPaging_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            PageNumber = Convert.ToInt32(e.CommandArgument) - 1;

            BindRepeater();
        }
    }
}