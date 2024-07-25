using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;

public partial class AMCharts_Tally_jv_report : System.Web.UI.Page
{
    MySqlCommand cmd;
    string username = "";
    VehicleDBMgr vdm;
    private object ddlType;
    private object lblmsg;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["field1"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            username = Session["field1"].ToString();
        }
        if (!this.IsPostBack)
        {
            if (!Page.IsCallback)
            {
                txtFromdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                Fillbranchdetails();

            }
        }
    }
    void Fillbranchdetails()
    {
        vdm = new VehicleDBMgr();
        vdm.InitializeDB();
        cmd = new MySqlCommand("SELECT SNo,UserName, BranchID, Description, Latitude, Longitude, PhoneNumber, ImagePath, ImageType, Radious, PlantName, IsPlant FROM branchdata WHERE (UserName = @UserName) AND (IsPlant = '1')");
        cmd.Parameters.Add("@UserName", username);
        DataTable dtPlant = vdm.SelectQuery(cmd).Tables[0];
        ddlbranchname.DataSource = dtPlant;
        ddlbranchname.DataTextField = "BranchID";
        ddlbranchname.DataValueField = "SNo";
        ddlbranchname.DataBind();
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
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GetReport();
    }
    DataTable Report = new DataTable();
    void GetReport()
    {
        try
        {
            lbl_msg.Text = "";
            pnlHide.Visible = true;
            Session["RouteName"] = ddlbranchname.SelectedItem.Text;
            Session["IDate"] = DateTime.Now.AddDays(1).ToString("dd/MM/yyyy");
            vdm = new VehicleDBMgr();
            vdm.InitializeDB();
            DateTime fromdate = DateTime.Now;
            string[] dateFromstrig = txtFromdate.Text.Split(' ');
            if (dateFromstrig.Length > 1)
            {
                if (dateFromstrig[0].Split('-').Length > 0)
                {
                    string[] dates = dateFromstrig[0].Split('-');
                    string[] times = dateFromstrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            lbl_selfromdate.Text = fromdate.ToString("dd/MM/yyyy");
            lblRoutName.Text = ddlbranchname.SelectedItem.Text;
            Session["xporttype"] = "TallyJV";
            string ledger = "";
            Report.Columns.Add("JV No.");
            Report.Columns.Add("JV Date");
            Report.Columns.Add("Ledger Name");
            Report.Columns.Add("Amount");
            Report.Columns.Add("Narration");
            Session["filename"] = ddlbranchname.SelectedItem.Text + " Tally JV" + fromdate.ToString("dd/MM/yyyy");
            cmd = new MySqlCommand("SELECT journel_entry.sno, journel_entry.plantid, journel_entry.amount, journel_entry.remarks, journel_entry.doe, journel_entry.createdby, journel_entry.status,  branchdata.BranchID AS Branchname FROM journel_entry INNER JOIN branchdata ON journel_entry.plantid = branchdata.Sno WHERE (journel_entry.doe BETWEEN @d1 AND @d2) AND (journel_entry.plantid = @plantid) ORDER BY journel_entry.doe");
            cmd.Parameters.Add("@plantid", ddlbranchname.SelectedValue);
            cmd.Parameters.Add("@d1", GetLowDate(fromdate));
            cmd.Parameters.Add("@d2", GetHighDate(fromdate));
            DataTable dtble = vdm.SelectQuery(cmd).Tables[0];
            double totamount = 0;
            fromdate = fromdate.AddDays(-1);
            string frmdate = fromdate.ToString("dd-MM-yyyy");
            string[] strjv = frmdate.Split('-');
            foreach (DataRow branch in dtble.Rows)
            {
                cmd = new MySqlCommand("SELECT headofaccounts_master.accountname, subjournel_entry.amount FROM subjournel_entry INNER JOIN headofaccounts_master ON subjournel_entry.headofaccount = headofaccounts_master.sno WHERE (subjournel_entry.refno = @RefNo)");
                cmd.Parameters.Add("@RefNo", branch["sno"].ToString());
                DataTable dtdebit = vdm.SelectQuery(cmd).Tables[0];
                foreach (DataRow drdebit in dtdebit.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["JV No."] ="PROCTRANS" + "_" + branch["sno"].ToString();
                    newrow["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                    newrow["Ledger Name"] = drdebit["accountname"].ToString();
                    double amount = 0;
                    double.TryParse(drdebit["amount"].ToString(), out amount);
                    totamount += amount;
                    newrow["Amount"] = amount;
                    newrow["Narration"] = "Being the " + drdebit["accountname"].ToString() + " for the month of " + fromdate.ToString("MMM-yyyy") + " Total Amount " + drdebit["amount"].ToString() + ",Emp Name  " + Session["field1"].ToString();
                    Report.Rows.Add(newrow);
                }
                cmd = new MySqlCommand("SELECT headofaccounts_master.accountname, subjournel_credit_entry.amount, subjournel_credit_entry.sno FROM headofaccounts_master INNER JOIN subjournel_credit_entry ON headofaccounts_master.sno = subjournel_credit_entry.headofaccount WHERE (subjournel_credit_entry.refno = @refno)");
                cmd.Parameters.Add("@RefNo", branch["sno"].ToString());
                DataTable dtcredit = vdm.SelectQuery(cmd).Tables[0];
                foreach (DataRow drcredit in dtcredit.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["JV No."] = "PROCTRANS" + "_" + branch["sno"].ToString();
                    newrow["JV Date"] = fromdate.ToString("dd-MMM-yyyy");
                    newrow["Ledger Name"] = drcredit["accountname"].ToString();
                    double amount = 0;
                    double.TryParse(drcredit["amount"].ToString(), out amount);
                    totamount += amount;
                    newrow["Amount"] = "-" + amount;
                    newrow["Narration"] = "Being the " + drcredit["accountname"].ToString() + " for the month of " + fromdate.ToString("MMM-yyyy") + " Total Amount " + drcredit["amount"].ToString() + ",Emp Name  " + Session["field1"].ToString();
                    Report.Rows.Add(newrow);
                }
            }
            grdReports.DataSource = Report;
            grdReports.DataBind();
            Session["xportdata"] = Report;
        }
        catch (Exception ex)
        {
            lbl_msg.Text = ex.Message;
            grdReports.DataSource = Report;
            grdReports.DataBind();
        }
    }
}