using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;

public partial class Gpsdata_Report : System.Web.UI.Page
{
    MySqlCommand cmd;
    static VehicleDBMgr vdm;
    static string UserName = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["field1"] == null)
            Response.Redirect("Login.aspx");
        if (!Page.IsCallback)
        {
            if (!Page.IsPostBack)
            {
                vdm = new VehicleDBMgr();
                vdm.InitializeDB();
                UserName = Session["field1"].ToString();
                getreport();
            }
        }
    }
    public void getreport()
    {
        try
        {
            vdm = new VehicleDBMgr();
            vdm.InitializeDB();
            lblmsg.Text = "";
            hidePanel.Visible = true;
            DataTable Report = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("VehicleNumber");
            Report.Columns.Add("GprsDevID");
            Report.Columns.Add("DeviceType");
            Report.Columns.Add("PhoneNumber");
            Report.Columns.Add("PlantName");
            Report.Columns.Add("RouteName");
            int i = 1;
            cmd = new MySqlCommand("SELECT paireddata.VehicleNumber, paireddata.GprsDevID, paireddata.DeviceType, paireddata.PhoneNumber, cabmanagement.PlantName, cabmanagement.RouteCode as RouteName FROM loginsconfigtable INNER JOIN paireddata ON loginsconfigtable.VehicleID = paireddata.VehicleNumber INNER JOIN loginstable ON paireddata.UserID = loginstable.main_user AND loginsconfigtable.Refno = loginstable.refno INNER JOIN cabmanagement ON paireddata.VehicleNumber = cabmanagement.VehicleID WHERE (loginstable.loginid = @UserName) order by PlantName,RouteName");
            cmd.Parameters.Add("@UserName", UserName);
            DataTable dt = vdm.SelectQuery(cmd).Tables[0];
            foreach (DataRow dr in dt.Rows)
            {
                DataRow newrow = Report.NewRow();
                newrow["Sno"] = i++.ToString();
                newrow["VehicleNumber"] = dr["VehicleNumber"].ToString();
                newrow["GprsDevID"] = dr["GprsDevID"].ToString();
                newrow["DeviceType"] = dr["DeviceType"].ToString();
                newrow["PhoneNumber"] = dr["PhoneNumber"].ToString();
                newrow["PlantName"] = dr["PlantName"].ToString();
                newrow["RouteName"] = dr["RouteName"].ToString();
                Report.Rows.Add(newrow);
            }
            grdReport.DataSource = Report;
            grdReport.DataBind();
            Session["xportdata"] = Report;
            Session["title"] = "Vehicle Master";
        }
        catch(Exception ex)
        {
            lblmsg.Text = ex.Message;
        }
    }
}