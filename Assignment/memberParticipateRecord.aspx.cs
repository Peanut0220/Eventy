using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PayPal.Api;

namespace Assignment
{
    public partial class memberParticipateRecord : System.Web.UI.Page
    {
        static string DatabaseConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["memberID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
            BindRepeater();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {


            Response.Redirect("~/memberParticipateRecord.aspx?search=" + TextBox1.Text);

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
            if (search != "" && search != null)
            {
                if (int.TryParse(search, out val))
                {
                    cmd.CommandText = "SELECT * FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID WHERE Participate_Record.memberID = @memberID AND " +
                        "(Participate_Record.recordID = @search1 OR " +
                        "Participate_Record.recordTotalPrice  = @search1 OR " +
                        "Participate_Record.recordTotalQuantity = @search1 OR " +
                        "Payment.totalPaid = @search1)ORDER BY Participate_Record.recordID DESC ";
                    cmd.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));
                    cmd.Parameters.AddWithValue("@search1", Convert.ToInt32(search));

                    SqlDataSource2.SelectCommand = "SELECT COUNT(Participate_Record.recordID) AS count FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID WHERE Participate_Record.memberID = @memberID AND " +
                        "(Participate_Record.recordID = @search1 OR " +
                        "Participate_Record.recordTotalPrice  = @search1 OR " +
                        "Participate_Record.recordTotalQuantity = @search1 OR " +
                        "Payment.totalPaid = @search1)";
                    SqlDataSource2.SelectParameters.Clear();
                    SqlDataSource2.SelectParameters.Add("memberID", DbType.Int32, Session["memberID"].ToString());
                    SqlDataSource2.SelectParameters.Add("search1", DbType.Int32, search);
                    Repeater2.DataBind();

                }
                else
                {

                    cmd.CommandText = "SELECT * FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID WHERE Participate_Record.memberID = @memberID AND " +
                                            "(Payment.paymentMethod LIKE '%' + @search2 + '%' " +
                                            ")ORDER BY Participate_Record.recordID DESC ";
                    cmd.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));
                    cmd.Parameters.AddWithValue("@search2", search);

                    SqlDataSource2.SelectCommand = "SELECT COUNT(Participate_Record.recordID) AS count FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID WHERE Participate_Record.memberID = @memberID AND " +
                                            "(Payment.paymentMethod LIKE '%' + @search2 + '%' " +
                                            ")";
                    SqlDataSource2.SelectParameters.Clear();
                    SqlDataSource2.SelectParameters.Add("memberID", DbType.Int32, Session["memberID"].ToString());
                    SqlDataSource2.SelectParameters.Add("search2", DbType.String, search);
                    Repeater2.DataBind();


                }

            }
            else
            {
                cmd.CommandText = "SELECT * FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID WHERE Participate_Record.memberID = @memberID " +
                                        "ORDER BY Participate_Record.recordID DESC ";
                cmd.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));

                SqlDataSource2.SelectCommand = "SELECT COUNT(Participate_Record.recordID) AS count FROM Participate_Record INNER JOIN Payment ON Payment.paymentID = Participate_Record.paymentID WHERE Participate_Record.memberID = @memberID";
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
                Response.Write("<script> alert('No record found'); window.location.replace(\"memberParticipateRecord.aspx\");</script>");

            } else if (Repeater1.Items.Count < 1) {
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