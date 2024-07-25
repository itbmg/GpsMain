using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;

public partial class TempratureReport : System.Web.UI.Page
{
    MySqlCommand cmd;
    string BranchID = "";
    VehicleDBMgr vdm;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["field1"] == null)
            Response.Redirect("Login.aspx");
        else
        {
            BranchID = Session["field1"].ToString();
            vdm = new VehicleDBMgr();
            if (!Page.IsPostBack)
            {
                if (!Page.IsCallback)
                {
                    dtp_FromDate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                    dtp_Todate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                    lblAddress.Text = "Near Ayyappa Swamy Temple, Shasta Nagar, WYRA-507165,KHAMMAM (District), TELANGANA (State).Phone: 08749 – 251326, Fax: 08749 – 252198. ";
                    lblTitle.Text = "SRI VYSHNAVI FOODS (P) LTD ";
                    Fillvehicleno();
                }
            }
        }
    }
    void Fillvehicleno()
    {
        vdm = new VehicleDBMgr();
        vdm.InitializeDB();
        cmd = new MySqlCommand("SELECT UserID, VehicleNumber FROM paireddata where vehicletype='Puff' ");
        DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
        ddlVehicleno.DataSource = dtRoutedata;
        ddlVehicleno.DataTextField = "VehicleNumber";
        ddlVehicleno.DataValueField = "VehicleNumber";
        ddlVehicleno.DataBind();
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
    DataTable Report = new DataTable();
    DataTable table;
    Dictionary<string, DataTable> reportData = new Dictionary<string, DataTable>();
    protected void btn_Generate_Click(object sender, EventArgs e)
    {
        try
        {
            lblmsg.Text = "";
            hidePanel.Visible = true;
            DateTime fromdate = DateTime.Now;
            DateTime todate = DateTime.Now;
            vdm = new VehicleDBMgr();
            vdm.InitializeDB();
            string[] datestrig = dtp_FromDate.Text.Split(' ');
            if (datestrig.Length > 1)
            {
                if (datestrig[0].Split('-').Length > 0)
                {
                    string[] dates = datestrig[0].Split('-');
                    string[] times = datestrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            datestrig = dtp_Todate.Text.Split(' ');
            if (datestrig.Length > 1)
            {
                if (datestrig[0].Split('-').Length > 0)
                {
                    string[] dates = datestrig[0].Split('-');
                    string[] times = datestrig[1].Split(':');
                    todate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            Report.Columns.Add("VehicleID");
            Report.Columns.Add("DateTime");
            Report.Columns.Add("Temprature");
            Report.Columns.Add("Speed");
            List<string> logstbls = new List<string>();
            logstbls.Add("GpsTrackVehicleLogs");
            logstbls.Add("GpsTrackVehicleLogs1");
            logstbls.Add("GpsTrackVehicleLogs2");
            logstbls.Add("GpsTrackVehicleLogs3");
            logstbls.Add("GpsTrackVehicleLogs4");
            DataTable logs = new DataTable();
            DataTable tottable = new DataTable();
            string veh = ddlVehicleno.SelectedValue;
            string user = Session["field1"].ToString();
            foreach (string tbname in logstbls)
            {
                cmd = new MySqlCommand("SELECT " + tbname + ".VehicleID, " + tbname + ".Speed, " + tbname + ".DateTime, " + tbname + ".tempsensor1, " + tbname + ".Latitiude, " + tbname + ".Longitude, " + tbname + ".TimeInterval, " + tbname + ".inp4, " + tbname + ".Status, " + tbname + ".Odometer, " + tbname + ".Direction, " + tbname + ".Direction AS Expr1 FROM " + tbname + "  WHERE (" + tbname + ".DateTime >= @starttime) and (" + tbname + ".tempsensor1 >0) AND (" + tbname + ".DateTime <= @endtime) AND (" + tbname + ".VehicleID = '" + veh + "') and (" + tbname + ".UserID='" + user + "') ORDER BY " + tbname + ".DateTime");
                cmd.Parameters.Add(new MySqlParameter("@starttime", GetLowDate(fromdate)));
                cmd.Parameters.Add(new MySqlParameter("@endtime", GetHighDate(todate)));
                logs = vdm.SelectQuery(cmd).Tables[0];
                if (tottable.Rows.Count == 0)
                {
                    tottable = logs.Clone();
                }
                foreach (DataRow dr in logs.Rows)
                {
                    tottable.ImportRow(dr);
                }
            }
            DataView dv1 = tottable.DefaultView;
            dv1.Sort = "DateTime ASC";
            table = dv1.ToTable();
            if (table.Rows.Count > 0)
            {
                DataView dv = table.DefaultView;
                dv.Sort = "DateTime ASC";
                DataTable sortedProductDT = dv.ToTable();
                foreach (DataRow dr in sortedProductDT.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["VehicleID"] = dr["VehicleID"].ToString();
                    newrow["DateTime"] = dr["DateTime"].ToString();
                    newrow["Temprature"] = dr["tempsensor1"].ToString();
                    newrow["Speed"] = dr["Speed"].ToString();
                    Report.Rows.Add(newrow);
                }
                string title = "Temprature Report From: " + fromdate.ToString() + "  To: " + todate.ToString();
                Session["title"] = title;
                Session["filename"] = "FuelReport";
                Session["xportdata"] = Report;
                dataGridView1.DataSource = Report;
                dataGridView1.DataBind();
            }
            else
            {
                lblmsg.Text = "No data found";
                dataGridView1.DataSource = Report;
                dataGridView1.DataBind();
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
            dataGridView1.DataSource = Report;
            dataGridView1.DataBind();
        }
    }
}