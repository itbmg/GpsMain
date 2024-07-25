using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

public partial class Fuelreport : System.Web.UI.Page
{
    MySqlCommand cmd;
    string BranchID = "";
    VehicleDBMgr vdm;
   public double avgltrperkm = 0.26;
   public int dieselcutvalue = 30;
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
                    //Fillvehicleno();
                }
            }
        }
    }
    private DateTime GetLowDate(DateTime dt)
    {
        //double Hour, Min, Sec;
        //DateTime DT = DateTime.Now;
        //DT = dt;
        //Hour = -dt.Hour;
        //Min = -dt.Minute;
        //Sec = -dt.Second;
        //DT = DT.AddHours(Hour);
        //DT = DT.AddMinutes(Min);
        //DT = DT.AddSeconds(Sec);
        //return DT;
        double Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        DT = dt;
        //Hour = dt.Hour;
        //Min = dt.Minute;
        //Sec = dt.Second;
        //DT = DT.AddHours(Hour);
        //DT = DT.AddMinutes(Min);
        //DT = DT.AddSeconds(Sec);
        return DT;
    }
    private DateTime GetHighDate(DateTime dt)
    {
        //double Hour, Min, Sec;
        //DateTime DT = DateTime.Now;
        //Hour = 23 - dt.Hour;
        //Min = 59 - dt.Minute;
        //Sec = 59 - dt.Second;
        //DT = dt;
        //DT = DT.AddHours(Hour);
        //DT = DT.AddMinutes(Min);
        //DT = DT.AddSeconds(Sec);
        //return DT;
        double Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        //Hour = 23 - dt.Hour;
        //Min = 59 - dt.Minute;
        //Sec = 59 - dt.Second;
        DT = dt;
        //DT = DT.AddHours(Hour);
        //DT = DT.AddMinutes(Min);
        //DT = DT.AddSeconds(Sec);
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
            Report.Columns.Add("Diesel");
            Report.Columns.Add("ConsumedDiesel");
            Report.Columns.Add("Speed");
            Report.Columns.Add("Latitiude");
            Report.Columns.Add("Longitude");
            Report.Columns.Add("difference");
            List<string> logstbls = new List<string>();
            logstbls.Add("GpsTrackVehicleLogs");
            logstbls.Add("GpsTrackVehicleLogs1");
            logstbls.Add("GpsTrackVehicleLogs2");
            logstbls.Add("GpsTrackVehicleLogs3");
            logstbls.Add("GpsTrackVehicleLogs4");
            DataTable logs = new DataTable();
            DataTable tottable = new DataTable();
            string veh = "AP26TC6786";
            string user = Session["field1"].ToString();
            foreach (string tbname in logstbls)
            {
                cmd = new MySqlCommand("SELECT " + tbname + ".VehicleID, " + tbname + ".Speed, " + tbname + ".DateTime, " + tbname + ".Diesel, " + tbname + ".Latitiude, " + tbname + ".Longitude, " + tbname + ".TimeInterval, " + tbname + ".inp4, " + tbname + ".Status, " + tbname + ".Odometer, " + tbname + ".Direction, " + tbname + ".Direction AS Expr1," + tbname + ".Latitiude," + tbname + ".Longitude FROM " + tbname + "  WHERE (" + tbname + ".DateTime >= @starttime) AND (" + tbname + ".DateTime <= @endtime) AND (" + tbname + ".VehicleID = '" + veh + "') and (" + tbname + ".UserID='" + user + "') and (" + tbname + ".Diesel<=350)  ORDER BY " + tbname + ".DateTime");
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
                double prevLat = 0.0;
                double prevLon = 0.0;
                double difference = 0.0;
                double Totdifference = 0.0;
                
                double prevdiesel = 0.0;
                int status = 0;
                int speedstopstatus = 0;
                double prevconsumeddieselvalue = 0.0;
                int prevspeed = 0;
                double dieselmainvalue = 0.0;
                DateTime startdt3 = new DateTime();
                DateTime Enddt = new DateTime();
                double diffdiesel = 0.0;

                int[] arrminspeed = new int[table.Rows.Count];
                int[] arrmaxspeed = new int[table.Rows.Count];
                

                foreach (DataRow dr in sortedProductDT.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["VehicleID"] = dr["VehicleID"].ToString();
                    newrow["DateTime"] = dr["DateTime"].ToString();
                    newrow["Diesel"] = dr["Diesel"].ToString();
                    newrow["Speed"] = dr["Speed"].ToString();
                    newrow["Latitiude"] = dr["Latitiude"].ToString();
                    newrow["Longitude"] = dr["Longitude"].ToString();
                    //
                    double presLat = Convert.ToDouble(dr["Latitiude"].ToString());
                    double presLon = Convert.ToDouble(dr["Longitude"].ToString());
                    double presdiesel= Convert.ToDouble(dr["Diesel"].ToString());


                    if (status > 0)
                    {
                        difference = GPSApplication.GeoCodeCalc.CalcDistance(presLat, presLon, prevLat, prevLon);
                    }
                    Totdifference = Totdifference + Convert.ToDouble(difference.ToString("F2"));
                    newrow["difference"] = Totdifference.ToString("F2");

                    prevLat = presLat;
                    prevLon = presLon;
                   

                    int speed = 0;
                    int.TryParse(dr["Speed"].ToString(), out speed);                  

                    prevspeed = speed;
                    //Speed
                    if (speed > 0)
                    {
                        arrminspeed[status] = speed;
                        arrmaxspeed[status] = speed;
                    }
                    Lbl_minspeed.Text ="Min Speed :"+ arrminspeed.Min().ToString();

                    Lbl_maxspeed.Text = "Max Speed" + arrmaxspeed.Max().ToString();
                   
                    
                    //
                    if (speed >= 5)
                    {
                        if (prevdiesel == 0.0)
                        {
                            prevdiesel = Convert.ToDouble(dr["Diesel"].ToString());
                        }
                        newrow["ConsumedDiesel"] = (prevdiesel - (avgltrperkm * difference)).ToString("F2");
                        dieselmainvalue = Convert.ToDouble(newrow["ConsumedDiesel"]); 
                        prevdiesel = (prevdiesel - (avgltrperkm * difference));
                        speedstopstatus = 0;
                    }
                    else
                    {
                       // newrow["ConsumedDiesel"] = dr["Diesel"].ToString();
                        if (prevdiesel == 0.0)
                        {
                            prevdiesel = Convert.ToDouble(dr["Diesel"].ToString());
                        }
                        speedstopstatus++;
                        if (speedstopstatus > 2)
                        {
                            if (prevspeed == 0)
                            {                               
                              //  newrow["ConsumedDiesel"] = prevconsumeddieselvalue.ToString("F2");
                              // prevdiesel = prevconsumeddieselvalue;
                                
                                if (speedstopstatus == 3)
                                {
                                    // startdt3 = Convert.ToDateTime(dr["DateTime"].ToString());
                                    startdt3 = DateTime.Parse(dr["DateTime"].ToString());
                                }
                                 Enddt = DateTime.Parse(dr["DateTime"].ToString());
                                string h1 = startdt3.ToString("mm");
                                string h2 = Enddt.ToString("mm");
                                int d = (Convert.ToInt32(h2) - Convert.ToInt32(h1));


                                diffdiesel = (presdiesel - prevdiesel);
                                if (diffdiesel > dieselcutvalue && d > 5)
                                {
                                    newrow["ConsumedDiesel"] = dr["Diesel"].ToString();
                                    dieselmainvalue = Convert.ToDouble(newrow["ConsumedDiesel"]);
                                    prevdiesel = presdiesel;
                                }
                                else
                                {
                                    newrow["ConsumedDiesel"] = (prevdiesel - (avgltrperkm * difference)).ToString("F2");
                                    prevconsumeddieselvalue = (prevdiesel - (avgltrperkm * difference));
                                    prevdiesel = prevconsumeddieselvalue;
                                }
                              //  speedstopstatus = 0;
                            }
                            else
                            {
                                newrow["ConsumedDiesel"] = (prevdiesel - (avgltrperkm * difference)).ToString("F2");
                                dieselmainvalue = Convert.ToDouble(newrow["ConsumedDiesel"]); 
                                prevdiesel = prevconsumeddieselvalue;
                            }
                        }
                        else
                        {
                            if (speedstopstatus > 0 && speedstopstatus <=2)
                            {
                                newrow["ConsumedDiesel"] = (prevdiesel - (avgltrperkm * difference)).ToString("F2");
                                dieselmainvalue = Convert.ToDouble(newrow["ConsumedDiesel"]);
                                prevconsumeddieselvalue = prevdiesel - (avgltrperkm * difference);
                                prevdiesel = prevconsumeddieselvalue;
                            }
                            else
                            {
                                //newrow["ConsumedDiesel"] = (prevdiesel - (0.26 * difference)).ToString("F2");
                                //  prevconsumeddieselvalue = prevdiesel - (0.26 * difference);
                               
                               // double diffdiesel = presdiesel - Convert.ToDouble(dr["Diesel"].ToString());
                                if (diffdiesel > 30)
                                {
                                    newrow["ConsumedDiesel"] = dr["Diesel"].ToString();
                                    prevconsumeddieselvalue = Convert.ToDouble(dr["Diesel"].ToString());
                                    prevdiesel = prevconsumeddieselvalue;
                                }
                                else
                                {
                                    newrow["ConsumedDiesel"] = (prevdiesel - (avgltrperkm * difference)).ToString("F2");
                                    prevconsumeddieselvalue = (prevdiesel - (avgltrperkm * difference));
                                    prevdiesel = prevconsumeddieselvalue;
                                }
                            }

                           // prevdiesel = prevconsumeddieselvalue;
                        }
                    }
                    prevspeed = speed;
                    //
                    Report.Rows.Add(newrow);
                    status++;
                    //1.Totdifference  2.TotalDieselConsumed=(avgltrperkm*Totdifference) 
                    //3.Avgspeed=   4.Maxspeed=   5.TotalTriptime=   6. Trip Idletime  7.Trip Traveltime  8.No of stops

                    startdt3 = fromdate;
                    Enddt = todate;
                    //string dd = Enddt.Subtract(startdt3).TotalDays.ToString();
                    string hd = Enddt.Subtract(startdt3).TotalHours.ToString();
                    string md = Enddt.Subtract(startdt3).TotalMinutes.ToString();

                    //DateTime Tripstarttime = DateTime.Parse(dtp_FromDate.ToString());
                    //DateTime TripEndtime = DateTime.Parse(dtp_Todate.ToString());
                    Lbl_Totdistance.Text = "TotTravel Distance :" + Totdifference.ToString();
                    Lbl_TotFuel.Text = "TotFuel :" + (avgltrperkm * Totdifference).ToString("F2");
                    Lbl_TripStarttime.Text ="Trip Start :"+ dtp_FromDate.Text.ToString();
                    Lbl_TripEndtime.Text = "Trip End :" + dtp_Todate.Text.ToString();
                    Lbl_TotalTripinfo.Text = "Total Trip Info :" + hd + "hr" + ":" + md + "min";





                }
                string title = "Fuel Report From: " + fromdate.ToString() + "  To: " + todate.ToString();
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