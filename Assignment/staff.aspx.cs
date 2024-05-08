using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class staff : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");
        static string DatabaseConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }
            if (Session["staffRole"].ToString() != "Manager")
            {
                Response.Redirect("~/staffRestricted.aspx");
            }

          
                BindRepeater();
          
          
 
           

        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnSearchStaff_Click(object sender, EventArgs e)
        {
            if (MultiView1.ActiveViewIndex == 0)
            {
        

                Response.Redirect("~/staff.aspx?archive=2&search=" + txtSearch.Text);
            }
            else if (MultiView1.ActiveViewIndex == 1)
            {

                Response.Redirect("~/staff.aspx?archive=1&search=" + txtSearch.Text);
            }
     
         
           

        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {

        }

        protected void btnViewStaff_Click(object sender, EventArgs e)
        {

        }

        protected void btnEditStaff_Click(object sender, EventArgs e)
        {

        }

        protected void btnDeleteStaff_Click(object sender, EventArgs e)
        {
            LinkButton btnDelete = (LinkButton)sender;
            string delete = btnDelete.CommandArgument;
            RepeaterItem item = (RepeaterItem)btnDelete.NamingContainer;
            Label ok = (Label)item.FindControl("Label5");
            string strDelete = "Update Staff Set isArchive=@isArchive where staffID=@staffID";
            SqlCommand cmdDelete = new SqlCommand(strDelete, conn);
            cmdDelete.Parameters.AddWithValue("@isArchive", 1);
            cmdDelete.Parameters.AddWithValue("@staffID", ok.Text);

            conn.Open();
            int n = cmdDelete.ExecuteNonQuery();

            conn.Close();
            if (n > 0)
            {
                Response.Write("<script> alert('Record is successfully delete'); window.location.replace(\"staff.aspx\");</script>");
            }
        }

        protected void btnUnarchive_Click(object sender, EventArgs e)
        {
            LinkButton btnUnarchive = (LinkButton)sender;
            string unarchive = btnUnarchive.CommandArgument;
            RepeaterItem item = (RepeaterItem)btnUnarchive.NamingContainer;
            Label ok = (Label)item.FindControl("Label6");
            string strUnarchive = "Update Staff Set isArchive=@isArchive where staffID=@staffID";
            SqlCommand cmdUnarchive = new SqlCommand(strUnarchive, conn);
            cmdUnarchive.Parameters.AddWithValue("@isArchive", 0);
            cmdUnarchive.Parameters.AddWithValue("@staffID", ok.Text);

            conn.Open();
            int n = cmdUnarchive.ExecuteNonQuery();

            conn.Close();
            if (n > 0)
            {
                Response.Write("<script> alert('Record is successfully recovered'); window.location.replace(\"staff.aspx\");</script>");
            }
        }

        protected void archive_Click(object sender, EventArgs e)
        {
            if (MultiView1.ActiveViewIndex == 0)
            {
                MultiView1.ActiveViewIndex = 1;
                archive.Text = "Back";
                title.Text = "Archived Staff";
        
                Response.Redirect("~/staff.aspx?archive=1");
            }
            else if (MultiView1.ActiveViewIndex == 1)
            {
                MultiView1.ActiveViewIndex = 0;
                archive.Text = "Show Archived";
                title.Text = "Staff";
                Response.Redirect("~/staff.aspx?archive=2");
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
                title.Text = "Archived Staff";

               
            }
            else if (archive1 == 2)
            {
                MultiView1.ActiveViewIndex = 0;
                archive.Text = "Show Archived";
                title.Text = "Staff";

            }
            else { 
            }

            string search = Request.QueryString["search"];
            if (search != "" && search != null)
            {
                if (int.TryParse(search, out val))
                {
                    if (MultiView1.ActiveViewIndex == 0)
                    {
                        cmd.CommandText = "SELECT * FROM Staff WHERE  (name LIKE '%' + @SearchTerm + '%' OR staffID = @SearchTerm1 OR email LIKE '%' + @SearchTerm + '%' OR phoneNo LIKE '%' + @SearchTerm + '%')  AND isArchive=0 ORDER BY staffID DESC";

                        cmd.Parameters.AddWithValue("@SearchTerm1", Convert.ToInt32(search));
                        cmd.Parameters.AddWithValue("@SearchTerm", search);
                    }
                    else
                    {
                        cmd.CommandText = "SELECT * FROM Staff WHERE  (name LIKE '%' + @SearchTerm + '%' OR staffID = @SearchTerm1 OR email LIKE '%' + @SearchTerm + '%' OR phoneNo LIKE '%' + @SearchTerm + '%')  AND isArchive=1 ORDER BY staffID DESC";
                        cmd.Parameters.AddWithValue("@SearchTerm1", Convert.ToInt32(search));
                        cmd.Parameters.AddWithValue("@SearchTerm", search);
                    }

                }
                else
                {


                    if (MultiView1.ActiveViewIndex == 0)
                    {
                        cmd.CommandText = "SELECT * FROM Staff WHERE  (name LIKE '%' + @SearchTerm + '%' OR email LIKE '%' + @SearchTerm + '%' OR phoneNo LIKE '%' + @SearchTerm + '%')  AND isArchive=0 ORDER BY staffID DESC";

             
                        cmd.Parameters.AddWithValue("@SearchTerm", search);
                    }
                    else
                    {
                        cmd.CommandText = "SELECT * FROM Staff WHERE  (name LIKE '%' + @SearchTerm + '%' OR email LIKE '%' + @SearchTerm + '%' OR phoneNo LIKE '%' + @SearchTerm + '%')  AND isArchive=1 ORDER BY staffID DESC";
                    
                        cmd.Parameters.AddWithValue("@SearchTerm", search);
                    }



                }

            }
            else
            {
                if (MultiView1.ActiveViewIndex == 0)
                {
                    cmd.CommandText = "SELECT * FROM Staff WHERE isArchive=0 ORDER BY staffID DESC";


                  
                }
                else
                {
                    cmd.CommandText = "SELECT * FROM Staff WHERE isArchive=1 ORDER BY staffID DESC";

               
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
                    Response.Write("<script> alert('No record found'); window.location.replace(\"staff.aspx?archive=2\");</script>");

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
                Repeater2.DataSourceID = null;
                Repeater2.DataSource = pgitems;
                Repeater2.DataBind();
                if (Repeater2.Items.Count < 1 && search != "" && search != null)
                {
                    Response.Write("<script> alert('No record found'); window.location.replace(\"staff.aspx?archive=1\");</script>");

                }
                else if(Repeater2.Items.Count < 1)
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