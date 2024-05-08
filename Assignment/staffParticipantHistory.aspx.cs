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
    public partial class staffParticipantHistory : System.Web.UI.Page
    {
        static string DatabaseConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection conn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
            BindRepeater();

        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnSearchHistory_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/staffParticipantHistory.aspx?search=" + txtSearch.Text);

            
        }

        protected void btnViewHistory_Click(object sender, EventArgs e)
        {

        }

        protected void btnDeleteHistory_Click(object sender, EventArgs e)
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
            int val;
            int archive1 = 0;


            string search = Request.QueryString["search"];
            if (search != "" && search != null)
            {
                if (int.TryParse(search, out val))
                {


                    cmd.CommandText = "SELECT * FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID INNER JOIN Member ON Member.memberID = Participate_Record.memberID WHERE recordID = @SearchTerm1 OR Member.name LIKE '%' + @SearchTerm + '%' ORDER BY Participate_Record.recordID DESC";

                    cmd.Parameters.AddWithValue("@SearchTerm1", Convert.ToInt32(search));
                    cmd.Parameters.AddWithValue("@SearchTerm", search);


                }
                else
                {



                    cmd.CommandText = "SELECT * FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID INNER JOIN Member ON Member.memberID = Participate_Record.memberID WHERE Member.name LIKE '%' + @SearchTerm + '%' ORDER BY Participate_Record.recordID DESC";

                    cmd.Parameters.AddWithValue("@SearchTerm", search);



                }

            }
            else
            {


                cmd.CommandText = "SELECT * FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID INNER JOIN Member ON Member.memberID = Participate_Record.memberID ORDER BY Participate_Record.recordID DESC";






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
                Response.Write("<script> alert('No record found'); window.location.replace(\"staffParticipantHistory.aspx\");</script>");

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