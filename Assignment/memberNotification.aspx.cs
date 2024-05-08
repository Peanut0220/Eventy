using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class memberNotification : System.Web.UI.Page
    {
        static string DatabaseConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["memberID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
            BindRepeater();
        }




        protected void Repeater2_PreRender(object sender, EventArgs e)
        {
            for (int i = 0; i < Repeater1.Items.Count; i++)
            {



                RepeaterItem item = Repeater1.Items[i];
                Label label = (Label)item.FindControl("time");

                DateTime dateTime = Convert.ToDateTime(label.Text);


                TimeSpan ts = DateTime.Now - dateTime;

                if (ts.TotalSeconds < 60)
                {
                    label.Text = ts.Seconds.ToString() + " Seconds ago";
                }
                else if (ts.TotalMinutes < 60)
                {
                    label.Text = ts.Minutes.ToString() + " Minutes ago";
                }
                else if (ts.TotalHours < 24)
                {
                    label.Text = ts.Hours.ToString() + " Hours ago";
                }
                else if (ts.TotalDays < 7)
                {
                    label.Text = ts.Days.ToString() + " Days ago";
                }
                else
                {
                    int week = ts.Days / 7;
                    label.Text = week.ToString() + " Weeks ago";
                }
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
            cmd.CommandText = "SELECT * FROM [Notification] where isArchive=0 ORDER BY notifyID DESC";
            cmd.Connection = cn;
            SqlDataAdapter ad = new SqlDataAdapter(cmd);


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


        }


        protected void rptPaging_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            PageNumber = Convert.ToInt32(e.CommandArgument) - 1;

            BindRepeater();
        }
    }
}