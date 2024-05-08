using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class errorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            if (Session["memberID"] != null)
            {
                Response.Redirect("memberHome.aspx");
            }
            else if (Session["staffID"] != null)
            {
                Response.Redirect("staffHome.aspx");
            }
            else
            {
                Response.Redirect("userHome.aspx");
            }
        }
    }
}