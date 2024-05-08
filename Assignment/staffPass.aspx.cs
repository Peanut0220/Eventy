using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace Assignment
{
    public partial class staffPass : System.Web.UI.Page
    {
        static string DatabaseConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection conn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
            if (!IsPostBack)
            {
                BindRepeater();
            }
            
        }

        protected void btnSearchEvent_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/staffPass.aspx?search=" + txtSearch.Text);
            string searchTerm = txtSearch.Text.Trim();

           
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnDeactivate_Click(object sender, EventArgs e)
        {
            Button btnDeactivate = (Button)sender;
            string deactivate = btnDeactivate.CommandArgument;
            RepeaterItem item = (RepeaterItem)btnDeactivate.NamingContainer;
            Label ok = (Label)item.FindControl("Label");
            string strDeactivate = "Update Event_Pass Set passStatus=@passStatus where passID=@passID";
            SqlCommand cmdDeactivate = new SqlCommand(strDeactivate, conn);
            cmdDeactivate.Parameters.AddWithValue("@passStatus", "Unused");
            cmdDeactivate.Parameters.AddWithValue("@passID", ok.Text);

            conn.Open();
            int n = cmdDeactivate.ExecuteNonQuery();

            conn.Close();
            if (n > 0)
            {
                Response.Write("<script> alert('Record is successfully updated'); window.location.replace(\"staffPass.aspx\");</script>");
            }
        }

        protected void btnActivate_Click(object sender, EventArgs e)
        {
            Button btnActivate = (Button)sender;
            string activate = btnActivate.CommandArgument;
            RepeaterItem item = (RepeaterItem)btnActivate.NamingContainer;
            Label ok = (Label)item.FindControl("Label");
            string strActivate = "Update Event_Pass Set passStatus=@passStatus where passID=@passID";
            SqlCommand cmdActivate = new SqlCommand(strActivate, conn);
            cmdActivate.Parameters.AddWithValue("@passStatus", "Used");
            cmdActivate.Parameters.AddWithValue("@passID", ok.Text);

            conn.Open();
            int n = cmdActivate.ExecuteNonQuery();

            conn.Close();
            if (n > 0)
            {
                Response.Write("<script> alert('Record is successfully updated'); window.location.replace(\"staffPass.aspx\");</script>");
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


            string search = Request.QueryString["search"];
            if (search != "" && search != null)
            {
                if (int.TryParse(search, out val))
                {


                    cmd.CommandText = "SELECT * FROM [Event_Pass] AS EP INNER JOIN Member AS M ON EP.memberID=M.memberID INNER JOIN RecordEvent AS RE ON RE.recordEventID = EP.recordEventID INNER JOIN Event AS E ON E.eventID = RE.eventID WHERE EP.passID =@SearchTerm1 OR EP.passStatus LIKE '%' + @SearchTerm + '%' OR M.name LIKE '%' + @SearchTerm + '%' OR M.memberID =@SearchTerm1 OR E.eventID =@SearchTerm1 OR E.eventName LIKE '%' + @SearchTerm + '%' OR RE.ticketCategory LIKE '%' + @SearchTerm + '%' ORDER BY EP.passID DESC";

                    cmd.Parameters.AddWithValue("@SearchTerm1", Convert.ToInt32(search));
                    cmd.Parameters.AddWithValue("@SearchTerm", search);


                }
                else
                {


                    cmd.CommandText = "SELECT * FROM [Event_Pass] AS EP INNER JOIN Member AS M ON EP.memberID=M.memberID INNER JOIN RecordEvent AS RE ON RE.recordEventID = EP.recordEventID INNER JOIN Event AS E ON E.eventID = RE.eventID WHERE EP.passStatus LIKE '%' + @SearchTerm + '%' OR M.name LIKE '%' + @SearchTerm + '%' OR E.eventName LIKE '%' + @SearchTerm + '%' OR RE.ticketCategory LIKE '%' + @SearchTerm + '%' ORDER BY EP.passID DESC";

                  
                    cmd.Parameters.AddWithValue("@SearchTerm", search);



                }

            }
            else
            {


                cmd.CommandText = "SELECT * FROM Event_Pass INNER JOIN Member ON Member.memberID = Event_Pass.memberID INNER JOIN RecordEvent ON RecordEvent.recordEventID = Event_Pass.recordEventID INNER JOIN Event On Event.eventID = RecordEvent.eventID ORDER BY Event_Pass.passID DESC";







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
                Response.Write("<script> alert('No record found');window.location.replace(\"staffPass.aspx\"); </script>");

            }else if(Repeater1.Items.Count < 1)
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