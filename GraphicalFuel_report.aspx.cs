using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class test : System.Web.UI.Page
{
    string BranchID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["field1"] == null)
            Response.Redirect("Login.aspx");
        else
        {
            BranchID = Session["field1"].ToString();

            if (!Page.IsPostBack)
            {
                if (!Page.IsCallback)
                {
                   

                }
            }
        }
    }

}