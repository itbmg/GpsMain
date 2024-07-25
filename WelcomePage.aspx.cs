using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WelcomePage : System.Web.UI.Page
{
    string UserName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["main_user"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            UserName = Session["main_user"].ToString();
        }
    }
}