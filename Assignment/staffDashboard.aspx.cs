using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class staffDashboard : System.Web.UI.Page
    {
        int i = 0;
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

        }

        protected void btnViewAll_Click(object sender, EventArgs e)
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
    }
}