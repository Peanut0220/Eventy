using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class memberHome : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Eventy.mdf;Integrated Security=SSPI;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["memberID"] == null)
            {
                Response.Redirect("~/memberLogin.aspx");
            }

            con.Open();
            string strSelect = "Select * FROM Member where memberID=@memberID";
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);
             cmdSelect.Parameters.AddWithValue("@memberID", Convert.ToInt32(Session["memberID"]));


            SqlDataReader dtrCart = cmdSelect.ExecuteReader();

            while (dtrCart.Read())
            {
                lblMemberHomeName.Text = dtrCart["name"].ToString();
            }
            con.Close();

           
        }
    }
}