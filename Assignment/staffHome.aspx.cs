using PayPal.Api;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class staffHome : System.Web.UI.Page
    {
        static string DatabaseConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
            con.Open();
            string strSelect = "Select * FROM Staff where staffID=@staffID";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
            cmdSelect.Parameters.AddWithValue("@staffID", Convert.ToInt32(Session["staffID"]));


            SqlDataReader dtrCart = cmdSelect.ExecuteReader();

            while (dtrCart.Read())
            {
                Label1.Text = " " + dtrCart["name"].ToString();
            }
            con.Close();

            if (Convert.ToInt32(Request.QueryString["archive"]) == 1 || Convert.ToInt32(Request.QueryString["archive"]) == 2)
            {
                BindRepeater();
            }
        

        }

        protected void btnEvent_Click(object sender, EventArgs e)
        {

            MultiView1.ActiveViewIndex = 1;
            Response.Redirect("~/staffHome.aspx?archive=1");

        }

        protected void btnNotification_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 2;
            Response.Redirect("~/staffHome.aspx?archive=2");

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
            int archive1 = 0;
            archive1 = Convert.ToInt32(Request.QueryString["archive"]);
            if (archive1 == 1)
            {
                MultiView1.ActiveViewIndex = 1;
            }
            else if (archive1 == 2)
            {
                MultiView1.ActiveViewIndex = 2;

            }
            else
            {

            }

            if (MultiView1.ActiveViewIndex == 1)
            {
                cmd.CommandText = "SELECT * FROM [Event] WHERE ([staffID] = @staffID) ORDER BY [isArchive], [eventID] DESC";
                cmd.Parameters.AddWithValue("@staffID", Convert.ToInt32(Session["staffID"]));
            }else if (MultiView1.ActiveViewIndex == 2)
            {
                cmd.CommandText = "SELECT * FROM [Notification] WHERE ([staffID] = @staffID) ORDER BY [isArchive], [notifyID] DESC";
                cmd.Parameters.AddWithValue("@staffID", Convert.ToInt32(Session["staffID"]));
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

            if (MultiView1.ActiveViewIndex == 1)
            {
                Repeater1.DataSourceID = null;
                Repeater1.DataSource = pgitems;
                Repeater1.DataBind();
                if (Repeater1.Items.Count < 1)
                {
                    Response.Write("<script> alert('No record found');window.location.replace(\"staffHome.aspx\"); </script>");

                }
            }
            else if (MultiView1.ActiveViewIndex == 2)
            {
                Repeater2.DataSourceID = null;
                Repeater2.DataSource = pgitems;
                Repeater2.DataBind();
                if (Repeater2.Items.Count < 1)
                {
                    Response.Write("<script> alert('No record found');window.location.replace(\"staffHome.aspx\"); </script>");

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