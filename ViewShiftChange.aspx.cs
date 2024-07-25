using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;

public partial class ViewShiftChange : System.Web.UI.Page
{
    MySqlCommand cmd;
    string BranchID = "";
    DataTable dtAddress = new DataTable();
    VehicleDBMgr vdm;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["field1"] == null)
            Response.Redirect("Login.aspx");
        else
        {
            BranchID = Session["field1"].ToString();
            if (!this.IsPostBack)
            {
                if (!Page.IsCallback)
                {
                    if (Session["OperatedBy"] == null)
                    {
                    }
                    else
                    {
                        txtEmpID.Text = Session["OperatedBy"].ToString();
                    }
                    dtp_Todate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                    lblAddress.Text = "Near Ayyappa Swamy Temple, Shasta Nagar, WYRA-507165,KHAMMAM (District), TELANGANA (State).Phone: 08749 – 251326, Fax: 08749 – 252198. ";
                    lblTitle.Text = "SRI VYSHNAVI FOODS (P) LTD ";
                    lblName.Text = Session["EmpName"].ToString();
                }
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
    string TripSno = "0";
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        try
        {
            vdm = new VehicleDBMgr();
            vdm.InitializeDB();
                lblmsg.Text = "";
            lblmsg.Text = "";
            DateTime fromdate = DateTime.Now;
            DateTime todate = DateTime.Now;
            string[] datestrig = dtp_Todate.Text.Split(' ');
            if (datestrig.Length > 1)
            {
                if (datestrig[0].Split('-').Length > 0)
                {
                    string[] dates = datestrig[0].Split('-');
                    string[] times = datestrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
           
            DataTable trips = new DataTable();
            lblDate.Text = fromdate.ToString("dd/MM/yyyy");
            DataTable Report = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("DespTime");
            Report.Columns.Add("Vehicle No");
            Report.Columns.Add("Description");
            Report.Columns.Add("Driver Name");
            Report.Columns.Add("Phone No");
            Report.Columns.Add("Route Name");
            Report.Columns.Add("Power On");
            Report.Columns.Add("Type");
            Report.Columns.Add("Problems");
            Report.Columns.Add("Solutions");
            Report.Columns.Add("Work To Be Done");
            cmd = new MySqlCommand("SELECT shiftchangetable.sno, shiftchangetable.desptime, shiftchangetable.vehicleno, shiftchangetable.description, shiftchangetable.drivername, shiftchangetable.phoneno, shiftchangetable.routename, shiftchangetable.poweron, shiftchangetable.pbms, shiftchangetable.slns, shiftchangetable.work, shiftchangetable.type, loginstable.loginid FROM shiftchangetable INNER JOIN loginstable ON shiftchangetable.operatedby = loginstable.refno WHERE (shiftchangetable.doe BETWEEN @d1 AND @d2) AND (shiftchangetable.operatedby = @EmpID)");  
            cmd.Parameters.Add("@d1", GetLowDate(fromdate));
            cmd.Parameters.Add("@d2", GetHighDate(todate));
            cmd.Parameters.Add("@EmpID", txtEmpID.Text);
            trips = vdm.SelectQuery(cmd).Tables[0];
            if (trips.Rows.Count > 0)
            {
                int i = 1;
                foreach (DataRow dr in trips.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["Sno"] = i++.ToString();
                    newrow["DespTime"] = dr["desptime"].ToString();
                    newrow["Vehicle No"] = dr["vehicleno"].ToString();
                    newrow["Description"] = dr["description"].ToString();
                    newrow["Driver Name"] = dr["drivername"].ToString();
                    newrow["Phone No"] = dr["phoneno"].ToString();
                    newrow["Route Name"] = dr["routename"].ToString();
                    newrow["Power On"] = dr["poweron"].ToString();
                    newrow["Type"] = dr["type"].ToString();
                    newrow["Problems"] = dr["pbms"].ToString();
                    newrow["Solutions"] = dr["slns"].ToString();
                    newrow["Work To Be Done"] = dr["work"].ToString();
                    Report.Rows.Add(newrow);
                }
                string title = "ShiftChange Report From: " + fromdate.ToString() + "  To: " + todate.ToString();
                Session["title"] = title;
                Session["filename"] = "ShiftChangeReport";
                Session["xportdata"] = Report;
                grdReports.DataSource = Report;
                grdReports.DataBind();
            }
            else
            {
                lblmsg.Text = "No data found";
                grdReports.DataSource = Report;
                grdReports.DataBind();
            }
        }
        catch
        {
        }


    }
}