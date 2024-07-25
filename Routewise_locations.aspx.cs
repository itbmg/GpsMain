using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

public partial class Routewise_locations : System.Web.UI.Page
{
    MySqlCommand cmd;
    static VehicleDBMgr vdm;
    static string UserName = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["main_user"] == null)
            Response.Redirect("Login.aspx");
        if (!Page.IsCallback)
        {
            if (!Page.IsPostBack)
            {
                vdm = new VehicleDBMgr();
                vdm.InitializeDB();
                UserName = Session["main_user"].ToString();
                cmd = new MySqlCommand("SELECT SNo,UserName, BranchID, Description, Latitude, Longitude, PhoneNumber, ImagePath, ImageType, Radious, PlantName, IsPlant FROM branchdata WHERE (UserName = @UserName) AND (IsPlant = '1')");
                cmd.Parameters.Add("@UserName", UserName);
                DataTable plants = vdm.SelectQuery(cmd).Tables[0];
                ddl_plant.Items.Clear();
                DataRow row = plants.NewRow();
                row["SNo"] = 0;
                row["BranchID"] = "Select Plant";
                plants.Rows.InsertAt(row, 0);
                ddl_plant.DataSource = plants;
                ddl_plant.DataTextField = "BranchID";
                ddl_plant.DataValueField = "SNo";
                ddl_plant.DataBind();
                //cmd = new MySqlCommand("SELECT sno, TripName, StartTime, EndTime, RouteID, Status, CreationDate, Isrepeat, UserID, PlantName, Kms, extrakms, Chargeperkm FROM tripconfiguration WHERE (UserID = @UserName)");
                //cmd = new MySqlCommand("SELECT routetable.RouteName, tripconfiguration.StartTime, tripconfiguration.EndTime, routetable.SNo, tripconfiguration.Kms,tripconfiguration.extrakms,tripconfiguration.Chargeperkm FROM loginsconfigtable INNER JOIN loginstable ON loginsconfigtable.Refno = loginstable.refno INNER JOIN cabmanagement ON loginsconfigtable.VehicleID = cabmanagement.VehicleID INNER JOIN vehiclemanage ON cabmanagement.PlantName = vehiclemanage.ItemName INNER JOIN tripconfiguration ON vehiclemanage.SNo = tripconfiguration.PlantName INNER JOIN routetable ON tripconfiguration.RouteID = routetable.SNo WHERE (loginstable.loginid = @UserName) GROUP BY routetable.RouteName");
                cmd = new MySqlCommand("SELECT routetable.RouteName, tripconfiguration.StartTime, tripconfiguration.EndTime, routetable.SNo, tripconfiguration.Kms, tripconfiguration.extrakms, tripconfiguration.Chargeperkm FROM tripconfiguration INNER JOIN branchdata ON tripconfiguration.PlantName = branchdata.Sno INNER JOIN cabmanagement ON branchdata.BranchID = cabmanagement.PlantName INNER JOIN loginsconfigtable ON cabmanagement.VehicleID = loginsconfigtable.VehicleID INNER JOIN loginstable ON loginsconfigtable.Refno = loginstable.refno INNER JOIN routetable ON tripconfiguration.RouteID = routetable.SNo WHERE (loginstable.loginid = @UserName) GROUP BY routetable.RouteName");
                cmd.Parameters.Add("@UserName", UserName);
                DataTable routetabledata = vdm.SelectQuery(cmd).Tables[0];
                ddl_routes.Items.Clear();
                DataRow newrow = routetabledata.NewRow();
                newrow["SNo"] = 0;
                newrow["RouteName"] = "Select All";
                routetabledata.Rows.InsertAt(newrow, 0);
                ddl_routes.DataSource = routetabledata;
                ddl_routes.DataTextField = "RouteName";
                ddl_routes.DataValueField = "SNo";
                ddl_routes.DataBind();
            }
        }
    }
    private DateTime GetLowDate(DateTime dt)
    {
        double Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        DT = dt;
        Hour = -dt.Hour;
        Min = -dt.Minute;
        Sec = -dt.Second;
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        return DT;

    }

    private DateTime GetHighDate(DateTime dt)
    {
        double Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        Hour = 23 - dt.Hour;
        Min = 59 - dt.Minute;
        Sec = 59 - dt.Second;
        DT = dt;
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        return DT;
    }
    protected void ddl_plant_selectionchanged(object sender, EventArgs e)
    {
        if (ddl_plant.SelectedIndex > 0)
        {
            vdm = new VehicleDBMgr();
            vdm.InitializeDB();
            cmd = new MySqlCommand("SELECT routetable.RouteName, routetable.SNo FROM routetable INNER JOIN tripconfiguration ON routetable.SNo = tripconfiguration.RouteID WHERE (tripconfiguration.PlantName = @PlantNameSno) AND (routetable.status=1)  GROUP BY routetable.SNo");
            cmd.Parameters.Add("@PlantNameSno", ddl_plant.SelectedValue);
            DataTable routetabledata = vdm.SelectQuery(cmd).Tables[0];
            ddl_routes.Items.Clear();
            DataRow newrow = routetabledata.NewRow();
            newrow["SNo"] = 0;
            newrow["RouteName"] = "Select All";
            routetabledata.Rows.InsertAt(newrow, 0);
            ddl_routes.DataSource = routetabledata;
            ddl_routes.DataTextField = "RouteName";
            ddl_routes.DataValueField = "SNo";
            ddl_routes.DataBind();
        }
    }
    protected void btn_Generate_Click(object sender, EventArgs e)
    {
        try
        {
            hidePanel.Visible = true;
            lblmsg.Text = "";
            if (Session["main_user"] == null)
                Response.Redirect("Login.aspx");
            else
                UserName = Session["main_user"].ToString();
            cmd = new MySqlCommand("SELECT branchdata.BranchID as LocationName, branchdata.Latitude, branchdata.Longitude, branchdata.Radious, branchdata.Description FROM routesubtable INNER JOIN branchdata ON routesubtable.LocationID = branchdata.Sno WHERE (routesubtable.SNo  = @RouteID)");
            cmd.Parameters.Add("@RouteID", ddl_routes.SelectedValue);
            DataTable routetabledata = vdm.SelectQuery(cmd).Tables[0];
            Session["filename"] = "LocationsReport";
            Session["xportdata"] = routetabledata;
            dataGridView1.DataSource = routetabledata;
            dataGridView1.DataBind();
        }
        catch(Exception ex)
        {
            lblmsg.Text = ex.Message;
            hidePanel.Visible = false;
        }
    }
}