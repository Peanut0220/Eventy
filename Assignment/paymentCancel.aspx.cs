using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class paymentCancel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["paymentOnGoing"] == null)
            {
                Response.Redirect("~/memberHome.aspx");
            }
            Session["paymentOnGoing"] = null;
        }
    }
}