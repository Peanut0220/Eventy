using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class memberPaymentMessage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["paymentID"]==""|| Request.QueryString["paymentID"] ==null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }

          
        }
    }
}