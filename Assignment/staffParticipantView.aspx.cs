using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class staffParticipantView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["staffID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }

            if (Request.QueryString["recordID"] == null)
            {
                Response.Redirect("~/staffParticipantHistory.aspx");
            }
        }
    }
}