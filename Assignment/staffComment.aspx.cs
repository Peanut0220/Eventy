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
    public partial class staffComment : System.Web.UI.Page
    {
        static string DatabaseConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

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

        protected void btnSearchEvent_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/staffComment.aspx?search=" + txtSearch.Text);


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


                    cmd.CommandText = "SELECT * FROM [Comment] AS C INNER JOIN Event AS E ON C.eventID = E.eventID " +
                "INNER JOIN Member AS M ON C.memberID = M.memberID " +
                "WHERE C.commentID = @SearchTerm1 OR M.name LIKE '%' + @SearchTerm + '%' OR M.memberID = @SearchTerm1 OR E.eventID = @SearchTerm1  OR E.eventName LIKE '%' + @SearchTerm + '%' ORDER BY C.commentID DESC";

                    cmd.Parameters.AddWithValue("@SearchTerm1", Convert.ToInt32(search));
                    cmd.Parameters.AddWithValue("@SearchTerm", search);


                }
                else
                {



                    cmd.CommandText = "SELECT * FROM [Comment] AS C INNER JOIN Event AS E ON C.eventID = E.eventID " +
               "INNER JOIN Member AS M ON C.memberID = M.memberID " +
               "WHERE C.commentID LIKE '%' + @SearchTerm + '%' OR M.name LIKE '%' + @SearchTerm + '%'OR M.memberID LIKE '%' + @SearchTerm + '%'OR E.eventID LIKE '%' + @SearchTerm + '%' OR E.eventName LIKE '%' + @SearchTerm + '%' ORDER BY C.commentID DESC";


                    cmd.Parameters.AddWithValue("@SearchTerm", search);



                }

            }
            else
            {


                cmd.CommandText = "SELECT * FROM [Comment] AS C INNER JOIN Event AS E ON C.eventID = E.eventID INNER JOIN Member AS M ON C.memberID = M.memberID ORDER BY C.commentID DESC";




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
                Response.Write("<script> alert('No record found'); window.location.replace(\"staffComment.aspx\");</script>");

            }
            else if (Repeater1.Items.Count < 1)
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