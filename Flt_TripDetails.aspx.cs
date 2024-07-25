using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;
using GPSApplication;
public partial class Flt_TripDetails : System.Web.UI.Page
{
    string UserName = string.Empty;
    VehicleDBMgr vdm;
    FleetDBMngr Fdb;
    MySqlCommand cmd;
    DataTable resdt = new DataTable();
    DataTable viewdt = new DataTable();
    DataTable tempdt = new DataTable();
    string str = string.Empty;
    double Maxspeed = 0;
    double totalSpeed = 0;
    DataTable table;
    Dictionary<string, DataTable> reportData = new Dictionary<string, DataTable>();
    string mainuser = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["main_user"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            UserName = Session["main_user"].ToString();
            Lbl_MsgInfo.Visible = false;
            Fdb = new FleetDBMngr();
            Fdb.InitializeDB();
            vdm = new VehicleDBMgr();
            vdm.InitializeDB();

            lblTitle.Text = Session["TitleName"].ToString();
            lblAddress.Text = Session["Address"].ToString();
            
            if (!this.IsPostBack)
            {
                if (!Page.IsCallback)
                {

                    
                    Get_VehicleType();
                    Get_VehicleNo();
                    Get_tripId();
                    Get_TripdDetails();         
                }
            }          
        }
    }

    protected void btn_Generate_Click(object sender, EventArgs e)
    {
        clear1();
        Load_History();
    }
    protected void ddl_VehicleType_SelectedIndexChanged(object sender, EventArgs e)
    {
        clear();
        clear1();
        Get_VehicleNo();
        Get_tripId();
        Get_TripdDetails();      
    }
    protected void ddl_VehicleNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        clear();
        clear1();
        Get_tripId();
        Get_TripdDetails();    
    }

    protected void ddl_Tripid_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            clear();
            clear1();
            Get_TripdDetails();            
        }
        catch (Exception ex)
        {
        }
    }

    private void Get_VehicleType()
    {
        try
        {
            DataTable dt = new DataTable();
            DataColumn col = new DataColumn("TypeId");
            dt.Columns.Add(col);
            col = new DataColumn("TypeName");
            dt.Columns.Add(col);

            DataRow dr = dt.NewRow();
            dr["TypeId"] = "7";
            dr["TypeName"] = "Puff";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["TypeId"] = "22";
            dr["TypeName"] = "Tanker";
            dt.Rows.Add(dr);

            ddl_VehicleType.DataSource = dt;
            ddl_VehicleType.DataTextField = "TypeName";
            ddl_VehicleType.DataValueField = "TypeId";
            ddl_VehicleType.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    private void Get_VehicleNo()
    {
        try
        {
            
            str = "Select vhtype_refno,registration_no,vm_sno from  vehicel_master Where vhtype_refno=@refNo  order by vm_sno desc";
            cmd = new MySqlCommand(str);
            cmd.Parameters.AddWithValue("@refNo", ddl_VehicleType.SelectedItem.Value);
            resdt = Fdb.SelectQuery(cmd).Tables[0];
            if (resdt.Rows.Count > 0)
            {
                ddl_VehicleNo.DataSource = resdt;
                ddl_VehicleNo.DataTextField = "registration_no";
                ddl_VehicleNo.DataValueField = "vm_sno";
                ddl_VehicleNo.DataBind();
            }
            else
            {
                Lbl_MsgInfo.Text = "VehicleNo Not Found...";
            }
        }
        catch (Exception ex)
        {
        }

    }

    private void Get_tripId()
    {
        try
        {
            str = "Select sno,tripsheetno,DATE_FORMAT(tripdate, '%d-%m-%Y %T') AS tripdate,DATE_FORMAT(enddate, '%d-%m-%Y %T') AS enddate,gpskms,qty,routeid,endfuelvalue,mileage from tripdata where vehicleno=@vehicleno AND Status='C'  order by sno desc Limit 10;";
            cmd = new MySqlCommand(str);
            cmd.Parameters.AddWithValue("@vehicleno", ddl_VehicleNo.SelectedItem.Value);
            resdt = Fdb.SelectQuery(cmd).Tables[0];
            if (resdt.Rows.Count > 0)
            {
                ddl_Tripid.DataSource = resdt;
                ddl_Tripid.DataTextField = "tripsheetno";
                ddl_Tripid.DataValueField = "sno";
                ddl_Tripid.DataBind();
                viewdt=resdt;
                ViewState["TripDetailsdt"] = viewdt;
            }
            else
            {
                ddl_Tripid.DataSource = resdt;
                ddl_Tripid.DataTextField = "tripsheetno";
                ddl_Tripid.DataValueField = "sno";
                ddl_Tripid.DataBind();
                viewdt = resdt;
                ViewState["TripDetailsdt"] = viewdt;

                Lbl_MsgInfo.Visible = true;
                Lbl_MsgInfo.Text = "TripData Not Found...";
                Lbl_MsgInfo.ForeColor = System.Drawing.Color.Red;
            }
        }
        catch (Exception ex)
        {
        }
    }

    private void Get_TripdDetails()
    {
        try
        {
            tempdt = (DataTable)ViewState["TripDetailsdt"];
            DataView dv = new DataView();
            dv = tempdt.DefaultView;
            dv.Sort = "sno ASC";
            tempdt = dv.ToTable();
            DataRow[] tempdtdr = tempdt.Select("tripsheetno='" + ddl_Tripid.SelectedItem.Text + "' ");

            if (tempdtdr.Length > 0)
            {
                foreach (DataRow dr in tempdtdr)
                {
                    startdate.Text = dr["tripdate"].ToString();
                    enddate.Text = dr["enddate"].ToString();
                    //
                    lbl_Startdate.Text = dr["tripdate"].ToString();
                    lbl_Enddate.Text = dr["enddate"].ToString();
                    lbl_Gpskms.Text = dr["gpskms"].ToString();
                    lbl_Qty.Text = dr["qty"].ToString();
                    lbl_RouteName.Text = dr["routeid"].ToString();
                    lbl_Endfuelvalue.Text = dr["endfuelvalue"].ToString();
                    lbl_mileage.Text = dr["mileage"].ToString();
                }
            }
            else
            {
                clear();
            }
        }
        catch (Exception ex)
        {
        }
    }

    private void clear()
    {
        lbl_Startdate.Text = "NA";
        lbl_Enddate.Text = "NA";
        lbl_Gpskms.Text = "NA";
        lbl_Qty.Text = "NA";
        lbl_RouteName.Text = "NA";
        lbl_Endfuelvalue.Text = "NA";
        lbl_mileage.Text = "NA";
    }

    private void clear1()
    {
        lbl_vehicleNos.Text = "NA";
        lbl_TotalDistance.Text = "NA";
        lbl_WorkingHours.Text = "NA";
        lbl_StationaryHours.Text = "NA";
        lbl_MaxSpeed.Text = "NA";
        lbl_AvgSpeed.Text = "NA";
        lbl_IdleTime.Text = "NA";
        lbl_NoOfStops.Text = "NA";
        lbl_ACONTime.Text = "NA";        
    }

    public enum GeoCodeCalcMeasurement : int
    {
        Miles = 0,
        Kilometers = 1
    }
    public string GoogleGeoCode(string latlong)
    {
        string url = "http://maps.googleapis.com/maps/api/geocode/json?sensor=true&address=";

        dynamic googleResults = new Uri(url + latlong).GetDynamicJsonObject();
        string strresult = "";
        foreach (var result in googleResults.results)
        {
            //Console.WriteLine("[" + result.geometry.location.lat + "," + result.geometry.location.lng + "] " + result.formatted_address);
            strresult = result.formatted_address;
            break;
        }
        return strresult;
    }

    private void Load_History()
    {
        try
        {
            DataTable sampletable = new DataTable();    
           
            int count = 0;
            Lbl_MsgInfo.Text = "";
            if (Session["main_user"] == null)
            {
                cmd = new MySqlCommand("SELECT main_user FROM loginstable WHERE (loginid = @loginid)");
                cmd.Parameters.Add("@loginid", UserName);
                DataTable mainusertbl = vdm.SelectQuery(cmd).Tables[0];
                if (mainusertbl.Rows.Count > 0)
                {
                    mainuser = mainusertbl.Rows[0]["main_user"].ToString();
                    Session["main_user"] = mainuser;
                }
                else
                {
                    mainuser = UserName;
                }
            }
            else
            {
                mainuser = Session["main_user"].ToString();
            }
            reportData = new Dictionary<string, DataTable>();

            if (startdate.Text != "" && enddate.Text != "" && startdate.Text != "NA" && enddate.Text != "NA")
            {
                DateTime fromdate = DateTime.Now;
                DateTime todate = DateTime.Now;
                DateTime AMfromdate = DateTime.Now;
                DateTime AMtodate = DateTime.Now;
                DateTime PMfromdate = DateTime.Now;
                DateTime PMtodate = DateTime.Now;
                // d/M/yyyy HH:mm
                string[] datestrig = startdate.Text.Split(' ');

                if (datestrig.Length > 1)
                {
                    if (datestrig[0].Split('-').Length > 0)
                    {
                        string[] dates = datestrig[0].Split('-');
                        string[] times = datestrig[1].Split(':');
                        fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                        AMfromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                        PMfromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                    }
                }
                else
                {
                    Lbl_MsgInfo.Text = "From Date Time Format Wrong";
                    return;
                }

                datestrig = enddate.Text.Split(' ');
                if (datestrig.Length > 1)
                {
                    if (datestrig[0].Split('-').Length > 0)
                    {
                        string[] dates = datestrig[0].Split('-');
                        string[] times = datestrig[1].Split(':');
                        todate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                        AMtodate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                        PMtodate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                    }
                }
                else
                {
                    Lbl_MsgInfo.Text = "To Date Time Format Wrong";
                    return;
                }

                List<string> logstbls = new List<string>();
                logstbls.Add("GpsTrackVehicleLogs");
                logstbls.Add("GpsTrackVehicleLogs1");
                logstbls.Add("GpsTrackVehicleLogs2");
                logstbls.Add("GpsTrackVehicleLogs3");
                logstbls.Add("GpsTrackVehicleLogs4");

                #region GeneralReports
                DataTable rpttable = new DataTable();
                DataColumn col = new DataColumn("VehicleID");
                rpttable.Columns.Add(col);
                //"Report From: " + fromdate.ToString() + "  To: " + todate.ToString() + " and  TotalDistance Travelled:" + (int)TotalDistance + "\n" +
                //    "Motion Hours:" + (int)RunningTime / 3600 + "H " + (int)RunningTime % (60) + "Min  Stationary Hours:" + (int)StopTime / 3600 + "H " + (int)StopTime % 60 + "Min  Max Speed:" + (int)Maxspeed + "KMPH  AvgSpeed: " + String.Format("{0:0.00}", avgspeed) + "KMPH  Idle Time: " + (int)IdleTime / 3600 + "H " + (int)IdleTime % 60 + " Min";
                col = new DataColumn("TotalDistanceTravelled(Kms)");
                rpttable.Columns.Add(col);
                col = new DataColumn("WorkingHours");
                rpttable.Columns.Add(col);
                col = new DataColumn("MotionHours");
                rpttable.Columns.Add(col);
                col = new DataColumn("StationaryHours");
                rpttable.Columns.Add(col);
                col = new DataColumn("IdleTime");
                rpttable.Columns.Add(col);
                col = new DataColumn("MaxSpeed");
                rpttable.Columns.Add(col);
                col = new DataColumn("AvgSpeed");
                rpttable.Columns.Add(col);
                col = new DataColumn("A/C ON Time");
                rpttable.Columns.Add(col);
                col = new DataColumn("No Of Stops");
                rpttable.Columns.Add(col);
                col = new DataColumn("Remarks");
                rpttable.Columns.Add(col);
                string vehiclestr = ddl_VehicleNo.SelectedItem.Text;
                if (vehiclestr.Length > 0)
                {
                    Maxspeed = 0;
                    #region codefor selected vehicles
                    double SpeedLimit = 0.0;
                    double MaxIdleLimit = 0.0;
                    double MaxStopLimit = 0.0;
                    DataTable logs = new DataTable();
                    DataTable tottable = new DataTable();
                    foreach (string tbname in logstbls)
                    {
                        cmd = new MySqlCommand("SELECT " + tbname + ".VehicleID, " + tbname + ".Speed, " + tbname + ".DateTime, " + tbname + ".Diesel, " + tbname + ".Latitiude, " + tbname + ".Longitude, " + tbname + ".TimeInterval, " + tbname + ".inp4, " + tbname + ".Status, " + tbname + ".Odometer, " + tbname + ".Direction, " + tbname + ".Direction AS Expr1, vehiclemaster.VendorNo, vehiclemaster.VendorName, vehiclemaster.VehicleTypeName, vehiclemaster.MaintenancePlantName FROM " + tbname + " LEFT OUTER JOIN vehiclemaster ON " + tbname + ".VehicleID = vehiclemaster.VehicleID AND " + tbname + ".UserID = vehiclemaster.UserName WHERE (" + tbname + ".DateTime >= @starttime) AND (" + tbname + ".DateTime <= @endtime) AND (" + tbname + ".VehicleID = '" + vehiclestr + "') and (" + tbname + ".UserID='" + mainuser + "') ORDER BY " + tbname + ".DateTime");
                        //cmd = new MySqlCommand("select * from " + tbname + " where DateTime>= @starttime and DateTime<=@endtime and VehicleID='" + vehiclestr + "' and UserID='" + UserName + "' order by DateTime");
                        cmd.Parameters.Add(new MySqlParameter("@starttime", fromdate));
                        cmd.Parameters.Add(new MySqlParameter("@endtime", todate));
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
                    DataView dv = tottable.DefaultView;
                    dv.Sort = "DateTime ASC";
                    table = dv.ToTable();
                    reportData.Add(vehiclestr, table);


                    double lat = 0.0;
                    double longi = 0.0;
                    double prvlat = 0.0;
                    double prevLongi = 0.0;
                    double TotalDistance = 0.0;
                    double IdleTime = 0.0;
                    double TotalTimeSpent = 0.0;
                    double StopTime = 0.0;
                    double totalStops = 0.0;
                    double RunningTime = 0.0;
                    double TotalACTime = 0.0;

                    bool onceMet = false;
                    bool IdleStarted = false;
                    bool runningStarted = false;
                    bool StopStarted = false;
                    bool SpentStarttime = false;
                    bool IsDisplayed = false;
                    bool ACStatred = false;

                    DateTime PrvIdletime = DateTime.Now;
                    DateTime presIdletime = DateTime.Now;
                    DateTime PrvRunningtime = DateTime.Now;
                    DateTime PresRunningtime = DateTime.Now;
                    DateTime PrvStoptime = DateTime.Now;
                    DateTime PresStoptime = DateTime.Now;
                    DateTime PresSpenttime = DateTime.Now;
                    DateTime PrvSpenttime = DateTime.Now;
                    DateTime PresACOnTime = DateTime.Now;
                    DateTime PrvACOnTime = DateTime.Now;

                    DateTime PrevGenTime = DateTime.Now;
                    string vehicleEnteredDate = "";
                    string vehicleLeftDate = "";
                    string Remarks = "No";
                    string PrvBranch = "";
                    string PresBranchName = "";


                    DataRow firstrow = null;
                    DataRow lastrow = null;
                    if (table.Rows.Count > 1)
                    {
                        firstrow = table.Rows[0];
                        lastrow = table.Rows[table.Rows.Count - 1];



                        foreach (DataRow dr1 in table.Rows)
                        {
                            int AC = 0;
                            int.TryParse(dr1["inp4"].ToString(), out AC);

                            if (lat == 0.0 && longi == 0.0)
                            {
                                lat = (double)dr1["Latitiude"];
                                longi = (double)dr1["Longitude"];
                                prvlat = lat;
                                prevLongi = longi;
                                TotalDistance = 0.0;
                                PrevGenTime = (DateTime)dr1["DateTime"];

                                if (AC == 1)
                                {
                                    PrvACOnTime = (DateTime)dr1["DateTime"];
                                    PresACOnTime = (DateTime)dr1["DateTime"];
                                    ACStatred = true;
                                }
                                else
                                {
                                    ACStatred = false;
                                }
                            }
                            else
                            {

                                #region Calculations
                                lat = (double)dr1["Latitiude"];
                                longi = (double)dr1["Longitude"];
                                TotalDistance += GeoCodeCalc.CalcDistance(lat, longi, prvlat, prevLongi);
                                prvlat = lat;
                                prevLongi = longi;

                                double deisel = (double)dr1["Diesel"];
                                double speed = (double)dr1["Speed"];
                                if (deisel > 50 && speed == 0)
                                {
                                    runningStarted = false;
                                    StopStarted = false;
                                    if (IdleStarted)
                                    {
                                        presIdletime = (DateTime)dr1["DateTime"];
                                        TimeSpan t = new TimeSpan(presIdletime.Ticks);//presIdletime.Hour, presIdletime.Minute, presIdletime.Second);
                                        TimeSpan t1 = new TimeSpan(PrvIdletime.Ticks);//PrvIdletime.Hour, PrvIdletime.Minute, PrvIdletime.Second);
                                        IdleTime += Math.Abs(t.Subtract(t1).TotalSeconds);
                                        PrvIdletime = presIdletime;
                                        PrevGenTime = presIdletime;
                                        if (IdleTime > MaxIdleLimit)
                                            Remarks = "YES";
                                    }
                                    else
                                    {
                                        IdleStarted = true;
                                        PrvIdletime = (DateTime)dr1["DateTime"];
                                        TimeSpan t = new TimeSpan(PrevGenTime.Ticks);//presIdletime.Hour, presIdletime.Minute, presIdletime.Second);
                                        TimeSpan t1 = new TimeSpan(PrvIdletime.Ticks);//PrvIdletime.Hour, PrvIdletime.Minute, PrvIdletime.Second);
                                        IdleTime += Math.Abs(t.Subtract(t1).TotalSeconds);
                                        PrevGenTime = PrvIdletime;
                                    }
                                }
                                //else if (deisel > 50 && speed > 0)
                                else if (speed > 0)
                                {
                                    IdleStarted = false;
                                    StopStarted = false;
                                    if (runningStarted)
                                    {
                                        PresRunningtime = (DateTime)dr1["DateTime"];
                                        TimeSpan t = new TimeSpan(PresRunningtime.Ticks);//PresRunningtime.Hour, PresRunningtime.Minute, PresRunningtime.Second);
                                        TimeSpan t1 = new TimeSpan(PrvRunningtime.Ticks);//PrvRunningtime.Hour, PrvRunningtime.Minute, PrvRunningtime.Second);
                                        RunningTime += Math.Abs(t.Subtract(t1).TotalSeconds);
                                        if (speed > Maxspeed)
                                            Maxspeed = speed;

                                        totalSpeed += speed;
                                        PrvRunningtime = PresRunningtime;
                                        PrevGenTime = PresRunningtime;
                                    }
                                    else
                                    {
                                        runningStarted = true;
                                        PrvRunningtime = (DateTime)dr1["DateTime"];
                                        TimeSpan t = new TimeSpan(PrevGenTime.Ticks);//presIdletime.Hour, presIdletime.Minute, presIdletime.Second);
                                        TimeSpan t1 = new TimeSpan(PrvRunningtime.Ticks);//PrvIdletime.Hour, PrvIdletime.Minute, PrvIdletime.Second);
                                        RunningTime += Math.Abs(t.Subtract(t1).TotalSeconds);
                                        totalSpeed += speed;
                                        if (speed > Maxspeed)
                                            Maxspeed = speed;
                                        PrevGenTime = PrvRunningtime;
                                    }
                                }
                                else if (deisel < 50 && speed == 0)
                                {
                                    IdleStarted = false;
                                    runningStarted = false;
                                    if (StopStarted)
                                    {
                                        PresStoptime = (DateTime)dr1["DateTime"];
                                        TimeSpan t = new TimeSpan(PresStoptime.Ticks);//PresStoptime.Hour, PresStoptime.Minute, PresStoptime.Second);
                                        TimeSpan t1 = new TimeSpan(PrvStoptime.Ticks);//PrvStoptime.Hour, PrvStoptime.Minute, PrvStoptime.Second);
                                        StopTime += Math.Abs(t.Subtract(t1).TotalSeconds);
                                        PrvStoptime = PresStoptime;
                                        //if (speed > MaxStopLimit)
                                        //    Remarks = "YES-stopped";
                                        PrevGenTime = PresStoptime;
                                    }
                                    else
                                    {
                                        StopStarted = true;
                                        PrvStoptime = (DateTime)dr1["DateTime"];
                                        TimeSpan t = new TimeSpan(PrevGenTime.Ticks);//presIdletime.Hour, presIdletime.Minute, presIdletime.Second);
                                        TimeSpan t1 = new TimeSpan(PrvStoptime.Ticks);//PrvIdletime.Hour, PrvIdletime.Minute, PrvIdletime.Second);
                                        StopTime += Math.Abs(t.Subtract(t1).TotalSeconds);
                                        PrevGenTime = PrvStoptime;
                                        totalStops += 1;
                                    }
                                }
                                #endregion


                                if (AC == 1)
                                {
                                    if (ACStatred == false)

                                        PrvACOnTime = (DateTime)dr1["DateTime"];
                                    PresACOnTime = (DateTime)dr1["DateTime"];

                                    ACStatred = true;
                                }
                                else
                                {
                                    ACStatred = false;
                                }

                                if (ACStatred)
                                {
                                    PresACOnTime = (DateTime)dr1["DateTime"];
                                    TimeSpan t = new TimeSpan(PresACOnTime.Ticks);//presIdletime.Hour, presIdletime.Minute, presIdletime.Second);
                                    TimeSpan t1 = new TimeSpan(PrvACOnTime.Ticks);
                                    TotalACTime += Math.Abs(t.Subtract(t1).TotalSeconds);
                                    PrvACOnTime = PresACOnTime;
                                }
                            }
                        }


                        if (firstrow != null && lastrow != null)
                        {
                            double firstval = 0;
                            double.TryParse(firstrow["Odometer"].ToString(), out firstval);
                            double lastval = 0;
                            double.TryParse(lastrow["Odometer"].ToString(), out lastval);
                            if (lastval > 0 && firstval > 0)
                                TotalDistance = lastval - firstval;
                        }

                        double avgspeeddiv = (RunningTime / 3600);
                        double avgspeed = 0;
                        if (avgspeeddiv > 0)
                            avgspeed = TotalDistance / avgspeeddiv;
                        DataRow tablerow = rpttable.NewRow();
                        tablerow["VehicleID"] = vehiclestr;
                        tablerow["TotalDistanceTravelled(Kms)"] = (Math.Abs(Math.Round(TotalDistance, 3))).ToString();
                        tablerow["WorkingHours"] = (int)(RunningTime + IdleTime) / 3600 + "H " + (int)((RunningTime + IdleTime) % (60)) + "Min";
                        tablerow["MotionHours"] = (int)RunningTime / 3600 + "H " + (int)RunningTime % (60) + "Min";
                        tablerow["StationaryHours"] = (int)StopTime / 3600 + "H " + (int)StopTime % 60 + "Min";
                        //tablerow["Stopped Time"]=
                        tablerow["MaxSpeed"] = (int)Maxspeed + "KMPH";
                        tablerow["AvgSpeed"] = String.Format("{0:0.00}", avgspeed) + "KMPH";
                        tablerow["IdleTime"] = (int)IdleTime / 3600 + "H " + (int)IdleTime % 60 + " Min";
                        tablerow["No Of Stops"] = totalStops.ToString();
                        tablerow["A/C ON Time"] = (int)TotalACTime / 3600 + "H " + (int)TotalACTime % 60 + " Min";//.ToString();
                        rpttable.Rows.Add(tablerow);

                        lbl_vehicleNos.Text = vehiclestr;
                        lbl_TotalDistance.Text = (Math.Abs(Math.Round(TotalDistance, 3))).ToString();
                        lbl_WorkingHours.Text= (int)(RunningTime + IdleTime) / 3600 + "H " + (int)((RunningTime + IdleTime) % (60)) + "Min";
                        lbl_StationaryHours.Text = (int)StopTime / 3600 + "H " + (int)StopTime % 60 + "Min";
                        lbl_MaxSpeed.Text = (int)Maxspeed + "KMPH";
                        lbl_AvgSpeed.Text = String.Format("{0:0.00}", avgspeed) + "KMPH";
                        lbl_IdleTime.Text = (int)IdleTime / 3600 + "H " + (int)IdleTime % 60 + " Min";
                        lbl_NoOfStops.Text = totalStops.ToString();
                        lbl_ACONTime.Text = (int)TotalACTime / 3600 + "H " + (int)TotalACTime % 60 + " Min";

                    #endregion
                    }
                }
                #endregion
            }


        }
        catch (Exception ex)
        {
        }

    }


   
}