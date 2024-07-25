<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DashBoard.aspx.cs" Inherits="DashBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link rel="stylesheet" href="css/style.css?v=1113" type="text/css" media="all" />
    <script src="js/jquery-1.4.4.js" type="text/javascript"></script>
    <script src="Kendo/jquery.min.js" type="text/javascript"></script>
    <script src="Kendo/kendo.all.min.js" type="text/javascript"></script>
    <link href="Kendo/kendo.common.min.css" rel="stylesheet" type="text/css" />
    <link href="Kendo/kendo.default.min.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.blockUI.js" type="text/javascript"></script>
    <script src="Js/JTemplate.js?v=3000" type="text/javascript"></script>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" type="text/css" href="dist/css/AdminLTE.css" />
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <style type="text/css">
        .h1, .h2, .h3, h1, h2, h3
        {
            margin-top: 5px;
            margin-bottom: 10px;
        }
        .menuclass
        {
            height: 59px !important;
        }
        .form-control
        {
            display: block;
            width: 100%;
            height: 34px;
            padding: 6px 12px;
            font-size: 14px;
            line-height: 1.428571429;
            color: #555;
            vertical-align: middle;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
            -webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
        }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDbt9z3InHbzrV66t1eSZB5TnlJ2HQ-Uc8&v=3.exp&sensor=false&libraries=geometry"></script>
    <script type="text/javascript">
        $(function () {
            GetLocations();
            var countdown = 0;
            countdown = 10 * 60 * 1000;
            GetPopUpTime = setInterval(function () { GetLocations() }, countdown);
        });
        function GetLocations() {
            var Username = '<%= Session["field1"] %>';
            var data = { 'op': 'ShowMyLocations', 'Username': Username };
            var s = function (msg) {
                if (msg) {
                    Locationsdata = msg;
                    liveupdate();
                }
                else {
                }
            };
            var e = function (x, h, e) {
                // $('#BookingDetails').html(x);
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function GetVehicleTypeClick() {
            GetLocations();
            var Emp = [];
            $('#divVehicles').removeTemplate();
            $('#divVehicles').setTemplateURL('dashboard.htm');
            $('#divVehicles').processTemplate(Emp);
        }
        var Locationsdata = null;
        var livedata = null;
        function liveupdate() {
            var Username = '<%= Session["field1"] %>';
            var data = { 'op': 'LiveUpdate', Username: Username };
            var s = function (msg) {
                if (msg) {
                    livedata = msg.vehiclesupdatelist;
                    GetAllVehicleInformation();
                }
                else {
                }
            };
            var e = function (x, h, e) {
                // $('#BookingDetails').html(x);
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        var statuses = "";
        var AllVehicles = 0;
        var StoppedVehicles = 0;
        var RunningVehicles = 0;
        var MainPowerOffVehicles = 0;
        var DelayVehicles = 0;
        var InsidePOIVehicles = 0;
        var OutsidePOIVehicles = 0;

        var ArrInsidePOIVehicles = new Array();
        var ArrAllVehicles = new Array();
        var ArrStoppedVehicles = new Array();
        var ArrRunningVehicles = new Array();
        var ArrOutsidePOIVehicles = new Array();
        var ArrMainPowerOffVehicles = new Array();
        var ArrDelayVehicles = new Array();
        function GetAllVehicleInformation() {
            var selectedgroup = "";
            VehicleType = "All Vehicle Types";
            Zones = "All Plants";
            statuses = "All Vehicles";
            Totalstring = VehicleType + '#' + Zones + '#' + statuses;
            filvehdiv(Totalstring);
        }
        var vehiclesdata;
        function filvehdiv(selectedgrp) {
            VehicleType = "All Vehicle Types";
            Zones = "All Plants";
            statuses = "All Vehicles";
            Totalstring = VehicleType + '#' + Zones + '#' + statuses;
            //    if (Totalstring != "All Vehicle Types#All Plants") {
            initializedata = true;
            var data = { 'op': 'GetVehicleDashBoard', 'filterstring': selectedgrp };
            var s = function (msg) {
                if (msg) {
                    Groupsfilling(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);

            function Groupsfilling(groupsdata) {
                var vehiclenos = new Array();
                AllVehicles = 0;
                StoppedVehicles = 0;
                RunningVehicles = 0;
                MainPowerOffVehicles = 0;
                DelayVehicles = 0;
                InsidePOIVehicles = 0;
                OutsidePOIVehicles = 0;
                var VehicleType = document.getElementById('ddlType').value;
                ArrInsidePOIVehicles = new Array();
                ArrAllVehicles = new Array();
                ArrStoppedVehicles = new Array();
                ArrRunningVehicles = new Array();
                ArrOutsidePOIVehicles = new Array();
                ArrMainPowerOffVehicles = new Array();
                ArrDelayVehicles = new Array();

                var mainpower = new Array();

                var updation = "MainPower Off Vehicles,All Vehicles,Stopped Vehicles,Running Vehicles,Inside POI Vehicles,Outside POI Vehicles,MainPower Off Vehicles,Delay in Update Vehicles";
                var res = updation.split(",");
                for (i = 0; i < res.length; i++) {

                    for (var vehicleid in groupsdata) {
                        if (res[i] == "All Vehicles") {
                            if (VehicleType == "All Vehcicles") {
                                if (ArrAllVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                    ArrAllVehicles.push({ sno: ArrAllVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename });
                                    AllVehicles = ArrAllVehicles.length;
                                }
                            }
                            if (VehicleType == "Puff") {
                                if (groupsdata[vehicleid].vehiclemodeltype == "Puff") {
                                    if (ArrAllVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                        ArrAllVehicles.push({ sno: ArrAllVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename });
                                        AllVehicles = ArrAllVehicles.length;
                                    }
                                }
                            }
                            if (VehicleType == "Tanker") {
                                if (groupsdata[vehicleid].vehiclemodeltype == "Tanker") {
                                    if (ArrAllVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                        ArrAllVehicles.push({ sno: ArrAllVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename });
                                        AllVehicles = ArrAllVehicles.length;
                                    }
                                }
                            }
                        }
                        else if (res[i] == "Stopped Vehicles") {
                            for (var veh in livedata) {
                                if (groupsdata[vehicleid].vehicleno == livedata[veh].vehiclenum && livedata[veh].Speed == 0) {
                                    if (VehicleType == "All Vehcicles") {
                                        if (ArrStoppedVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                            ArrStoppedVehicles.push({ sno: ArrStoppedVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                            StoppedVehicles = ArrStoppedVehicles.length;
                                        }
                                    }
                                    if (VehicleType == "Puff") {
                                        if (groupsdata[vehicleid].vehiclemodeltype == "Puff") {
                                            if (ArrStoppedVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                ArrStoppedVehicles.push({ sno: ArrStoppedVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                StoppedVehicles = ArrStoppedVehicles.length;
                                            }
                                        }
                                    }
                                    if (VehicleType == "Tanker") {
                                        if (groupsdata[vehicleid].vehiclemodeltype == "Tanker") {
                                            if (ArrStoppedVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                ArrStoppedVehicles.push({ sno: ArrStoppedVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                StoppedVehicles = ArrStoppedVehicles.length;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else if (res[i] == "Running Vehicles") {
                            for (var veh in livedata) {
                                if (groupsdata[vehicleid].vehicleno == livedata[veh].vehiclenum && livedata[veh].Speed > 0) {
                                    if (VehicleType == "All Vehcicles") {
                                        if (ArrRunningVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                            ArrRunningVehicles.push({ sno: ArrRunningVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                            RunningVehicles = ArrRunningVehicles.length;
                                        }
                                    }
                                    if (VehicleType == "Puff") {
                                        if (groupsdata[vehicleid].vehiclemodeltype == "Puff") {
                                            if (ArrRunningVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                ArrRunningVehicles.push({ sno: ArrRunningVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                RunningVehicles = ArrRunningVehicles.length;
                                            }
                                        }
                                    }
                                    if (VehicleType == "Tanker") {
                                        if (groupsdata[vehicleid].vehiclemodeltype == "Tanker") {
                                            var latitude = livedata[veh].latitude;
                                            var longitude = livedata[veh].longitude;

                                            if (ArrRunningVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                ArrRunningVehicles.push({ sno: ArrRunningVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                RunningVehicles = ArrRunningVehicles.length;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else if (res[i] == "Inside POI Vehicles") {
                            for (var veh in livedata) {
                                if (groupsdata[vehicleid].vehicleno == livedata[veh].vehiclenum) {
                                    var Latitude = livedata[veh].latitude;
                                    var Longitude = livedata[veh].longitude;
                                    for (var cont = 0; cont < Locationsdata.length; cont++) {
                                        var targetLoc = new google.maps.LatLng(Latitude, Longitude);
                                        var center = new google.maps.LatLng(Locationsdata[cont].latitude, Locationsdata[cont].longitude);
                                        var radius = Locationsdata[cont].radius;
                                        var isinside = pointInCircle(targetLoc, radius, center);
                                        function pointInCircle(point, radius, center) {
                                            return (google.maps.geometry.spherical.computeDistanceBetween(point, center) <= radius)
                                        }
                                        if (isinside) {
                                            if (VehicleType == "All Vehcicles") {
                                                if (ArrInsidePOIVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                    ArrInsidePOIVehicles.push({ sno: ArrInsidePOIVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                    InsidePOIVehicles = ArrInsidePOIVehicles.length;
                                                    break;
                                                }
                                            }
                                            if (VehicleType == "Puff") {
                                                if (groupsdata[vehicleid].vehiclemodeltype == "Puff") {
                                                    if (ArrInsidePOIVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                        ArrInsidePOIVehicles.push({ sno: ArrInsidePOIVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                        InsidePOIVehicles = ArrInsidePOIVehicles.length;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (VehicleType == "Tanker") {
                                                if (groupsdata[vehicleid].vehiclemodeltype == "Tanker") {
                                                    if (ArrInsidePOIVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                        ArrInsidePOIVehicles.push({ sno: ArrInsidePOIVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                        InsidePOIVehicles = ArrInsidePOIVehicles.length;
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else if (res[i] == "Outside POI Vehicles") {
                            for (var veh in livedata) {
                                if (groupsdata[vehicleid].vehicleno == livedata[veh].vehiclenum) {
                                    var Latitude = livedata[veh].latitude;
                                    var Longitude = livedata[veh].longitude;
                                    for (var cont = 0; cont < Locationsdata.length; cont++) {
                                        var targetLoc = new google.maps.LatLng(Latitude, Longitude);
                                        var center = new google.maps.LatLng(Locationsdata[cont].latitude, Locationsdata[cont].longitude);
                                        var radius = Locationsdata[cont].radius;
                                        var isinside = pointInCircle(targetLoc, radius, center);
                                        function pointInCircle(point, radius, center) {
                                            return (google.maps.geometry.spherical.computeDistanceBetween(point, center) <= radius)
                                        }
                                        if (isinside) {
                                            if (VehicleType == "All Vehcicles") {
                                                if (ArrOutsidePOIVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                    ArrOutsidePOIVehicles.push({ sno: ArrOutsidePOIVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                    OutsidePOIVehicles = ArrOutsidePOIVehicles.length;
                                                    break;
                                                }
                                            }
                                            if (VehicleType == "Puff") {
                                                if (groupsdata[vehicleid].vehiclemodeltype == "Puff") {
                                                    if (ArrOutsidePOIVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                        ArrOutsidePOIVehicles.push({ sno: ArrOutsidePOIVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                        OutsidePOIVehicles = ArrOutsidePOIVehicles.length;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (VehicleType == "Tanker") {
                                                if (groupsdata[vehicleid].vehiclemodeltype == "Tanker") {
                                                    if (ArrOutsidePOIVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                        ArrOutsidePOIVehicles.push({ sno: ArrOutsidePOIVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                        OutsidePOIVehicles = ArrOutsidePOIVehicles.length;
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else if (res[i] == "MainPower Off Vehicles") {
                            for (var veh in livedata) {
                                if (groupsdata[vehicleid].vehicleno == livedata[veh].vehiclenum && livedata[veh].mainpower == "OFF") {
                                    if (VehicleType == "All Vehcicles") {
                                        if (mainpower.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                            ArrMainPowerOffVehicles.push({ sno: ArrMainPowerOffVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                            MainPowerOffVehicles = ArrMainPowerOffVehicles.length;
                                            mainpower.push(groupsdata[vehicleid].vehicleno);
                                        }
                                    }
                                    if (VehicleType == "Puff") {
                                        if (groupsdata[vehicleid].vehiclemodeltype == "Puff") {
                                            if (mainpower.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                ArrMainPowerOffVehicles.push({ sno: ArrMainPowerOffVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                MainPowerOffVehicles = ArrMainPowerOffVehicles.length;
                                                mainpower.push(groupsdata[vehicleid].vehicleno);
                                            }
                                        }
                                    }
                                    if (VehicleType == "Tanker") {
                                        if (groupsdata[vehicleid].vehiclemodeltype == "Tanker") {
                                            if (mainpower.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                ArrMainPowerOffVehicles.push({ sno: ArrMainPowerOffVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                MainPowerOffVehicles = ArrMainPowerOffVehicles.length;
                                                mainpower.push(groupsdata[vehicleid].vehicleno);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        else if (res[i] == "Delay in Update Vehicles") {
                            for (var veh in livedata) {
                                var updatedata = livedata[veh].Datetime;
                                var date = updatedata.split(" ")[0];
                                var time = updatedata.split(" ")[1];
                                var datevalues = new Array();
                                var timevalues = new Array();
                                if (date == "0") {
                                }
                                else {
                                    datevalues = date.split('/');
                                    timevalues = time.split(':');
                                }
                                var updatetime = new Date(datevalues[2], datevalues[1] - 1, datevalues[0], timevalues[0], timevalues[1], timevalues[2]);
                                var todaydate = new Date();
                                var _MS_PER_DAY = 86400000;
                                var _MS_PER_aaa = 3600000;
                                var _MS_PER_sss = 60000;
                                var _MS_PER_ddd = 1000;
                                var days = Math.floor((todaydate - updatetime) / _MS_PER_DAY);
                                var hours = Math.floor((todaydate - updatetime) / _MS_PER_aaa);
                                if (hours > 24) {
                                    hours = hours % 24;
                                }
                                var min = Math.floor((todaydate - updatetime) / _MS_PER_sss);
                                if (min > 60) {
                                    min = min % 60;
                                }
                                var sec = Math.floor((todaydate - updatetime) / _MS_PER_ddd);
                                if (sec > 60) {
                                    sec = sec % 60;
                                }
                                if (groupsdata[vehicleid].vehicleno == livedata[veh].vehiclenum && (min > 30 || hours >= 1 || days >= 1)) {
                                    if (VehicleType == "All Vehcicles") {
                                        if (ArrDelayVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                            ArrDelayVehicles.push({ sno: ArrDelayVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                            DelayVehicles = ArrDelayVehicles.length;
                                        }
                                    }
                                    if (VehicleType == "Puff") {
                                        if (groupsdata[vehicleid].vehiclemodeltype == "Puff") {
                                            if (ArrDelayVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                ArrDelayVehicles.push({ sno: ArrDelayVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                DelayVehicles = ArrDelayVehicles.length;
                                            }
                                        }
                                    }
                                    if (VehicleType == "Tanker") {
                                        if (groupsdata[vehicleid].vehiclemodeltype == "Tanker") {
                                            if (ArrDelayVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                                ArrDelayVehicles.push({ sno: ArrDelayVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                                DelayVehicles = ArrDelayVehicles.length;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if (res[i] == "Outside POI Vehicles") {
                        for (var vehicleid in groupsdata) {
                            var existed = false;
                            for (var veh in ArrInsidePOIVehicles) {
                                if (groupsdata[vehicleid].vehicleno == ArrInsidePOIVehicles[veh].vehicleno) {
                                    existed = true;
                                    break;
                                }
                            }
                            if (!existed) {
                                existed = false;
                                if (VehicleType == "All Vehcicles") {
                                    if (ArrAllVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                        ArrAllVehicles.push({ sno: ArrAllVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                        //                                OutsidePOIVehicles = ArrAllVehicles.length;
                                    }
                                }
                                if (VehicleType == "Puff") {
                                    if (groupsdata[vehicleid].vehiclemodeltype == "Puff") {
                                        if (ArrAllVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                            ArrAllVehicles.push({ sno: ArrAllVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                        }
                                    }
                                }
                                if (VehicleType == "Tanker") {
                                    if (groupsdata[vehicleid].vehiclemodeltype == "Tanker") {
                                        if (ArrAllVehicles.indexOf(groupsdata[vehicleid].vehicleno) == -1) {
                                            ArrAllVehicles.push({ sno: ArrAllVehicles.length, vehicleno: groupsdata[vehicleid].vehicleno, vehiclemodeltype: groupsdata[vehicleid].vehiclemodeltype, Routename: groupsdata[vehicleid].Routename, Odometer: livedata[veh].odometervalue, Speed: livedata[veh].Speed, ignation: livedata[veh].ignation, DriverName: livedata[veh].DriverName, MobileNo: livedata[veh].MobileNo });
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                $('#divassainedvehs').css('display', 'block');
                document.getElementById('txtAll').innerHTML = AllVehicles;
                document.getElementById('txtRunning').innerHTML = RunningVehicles;
                document.getElementById('txtStopped').innerHTML = StoppedVehicles;
                document.getElementById('txtMainpower').innerHTML = MainPowerOffVehicles;
                document.getElementById('txtDelay').innerHTML = DelayVehicles;
                document.getElementById('txtInside').innerHTML = InsidePOIVehicles;
                document.getElementById('txtOutSide').innerHTML = OutsidePOIVehicles;
                var newXarray = new Array();
                newXarray.push({ "category": "All Vehicles", "value": parseFloat(AllVehicles) });
                newXarray.push({ "category": "Running Vehicles", "value": parseFloat(RunningVehicles) });
                newXarray.push({ "category": "Stopped Vehicles", "value": parseFloat(StoppedVehicles) });
                newXarray.push({ "category": "Main Power Vehicles", "value": parseFloat(MainPowerOffVehicles) });
                newXarray.push({ "category": "Delay Vehicles", "value": parseFloat(DelayVehicles) });
                newXarray.push({ "category": "Inside POI Vehicles", "value": parseFloat(InsidePOIVehicles) });
                newXarray.push({ "category": "OutSide POI Vehicles", "value": parseFloat(OutsidePOIVehicles) });
                $('#divChart').kendoChart({
                    title: {
                        text: "Vehicle Status Report",
                        color: "#FE2E2E",
                        align: "left",
                        font: "20px Verdana"

                    },
                    legend: {
                        visible: true
                    },
                    chartArea: {
                        background: ""
                    },
                    seriesDefaults: {
                        labels: {
                            visible: true,
                            background: "transparent",
                            template: "#= category #: #= value#"
                        }
                    },
                    dataSource: {
                        data: newXarray
                    },
                    series: [{
                        type: "pie",
                        field: "value",
                        categoryField: "category"
                    }],
                    seriesColors: ["#C0C0C0", "#FF00FF", "#00FFFF", "#322B2B", "#0000FF", "#00FF00", "#FF0000", "#B43104", "#8A084B", "#0041C2", "#800517", "#1C1715"],
                    tooltip: {
                        visible: true,
                        format: "{0}"
                    }
                });
            }
        }
        function RunningVehicleclick() {
            $('#divVehicles').removeTemplate();
            $('#divVehicles').setTemplateURL('dashboard.htm');
            $('#divVehicles').processTemplate(ArrRunningVehicles);
            document.getElementById('txtdashtext').innerHTML = "Running Vehicles";
        }
        function AllVehiclesclick() {
            $('#divVehicles').removeTemplate();
            $('#divVehicles').setTemplateURL('dashboard.htm');
            $('#divVehicles').processTemplate(ArrAllVehicles);
            document.getElementById('txtdashtext').innerHTML = "All Vehicles";
        }
        function StoppedVehiclesclick() {
            $('#divVehicles').removeTemplate();
            $('#divVehicles').setTemplateURL('dashboard.htm');
            $('#divVehicles').processTemplate(ArrStoppedVehicles);
            document.getElementById('txtdashtext').innerHTML = "Stopped Vehicles";
        }
        function MainPowerOffVehiclesclick() {
            $('#divVehicles').removeTemplate();
            $('#divVehicles').setTemplateURL('dashboard.htm');
            $('#divVehicles').processTemplate(ArrMainPowerOffVehicles);
            document.getElementById('txtdashtext').innerHTML = "Main Power Off Vehicles";
        }
        function DelayVehiclesclick() {
            $('#divVehicles').removeTemplate();
            $('#divVehicles').setTemplateURL('dashboard.htm');
            $('#divVehicles').processTemplate(ArrDelayVehicles);
            document.getElementById('txtdashtext').innerHTML = "Delay Vehicles";
        }
        function InsidePOIVehiclesclick() {
            $('#divVehicles').removeTemplate();
            $('#divVehicles').setTemplateURL('dashboard.htm');
            $('#divVehicles').processTemplate(ArrInsidePOIVehicles);
            document.getElementById('txtdashtext').innerHTML = "Inside POI Vehicles";
        }
        function OutSidePOIVehiclesclick() {
            $('#divVehicles').removeTemplate();
            $('#divVehicles').setTemplateURL('dashboard.htm');
            $('#divVehicles').processTemplate(ArrOutsidePOIVehicles);
            document.getElementById('txtdashtext').innerHTML = "Outside POI Vehicles";
        }
        function callHandler(d, s, e) {
            $.ajax({
                url: 'Bus.axd',
                data: d,
                type: 'GET',
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                async: true,
                cache: true,
                success: s,
                error: e
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <br />
    <section class="content-header">
        <h1>
            Dash Board<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">DashBoard</a></li>
        </ol>
    </section>
    <br />
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Dash Board For Vehicle Status
                </h3>
            </div>
            <div class="box-body">
                <div style="text-align: center;">
                    <table align="center">
                        <tr>
                            <td>
                                <span>Type</span>
                            </td>
                            <td style="width: 200px;">
                                <select id="ddlType" class="form-control">
                                    <option>All Vehcicles</option>
                                    <option>Puff</option>
                                    <option>Tanker</option>
                                </select>
                            </td>
                            <td style="width: 5px;">
                            </td>
                            <td>
                                <input type="button" id="submit" value="Generate" class="btn btn-success" onclick="GetVehicleTypeClick()" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="width: 100%;">
                    <div style="width: 50%; float: left;">
                        <div id="divChart">
                        </div>
                    </div>
                    <div style="width: 50%; float: right;">
                        <br />
                        <br />
                        <br />
                        <table border="1" style="width: 400px; height: 300px;">
                            <thead>
                                <tr style="color: #2f3293; font-size: 22px; font-weight: bold; text-align: center;">
                                    <th>
                                        Status Name
                                    </th>
                                    <th>
                                        Count
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr style="color: #C0C0C0; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" onclick="AllVehiclesclick();">All Vehicles</span>
                                    </td>
                                    <td>
                                        <span id="txtAll"></span>
                                    </td>
                                </tr>
                                <tr style="color: #FF00FF; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" onclick="RunningVehicleclick();">Running Vehicles</span>
                                    </td>
                                    <td>
                                        <span id="txtRunning"></span>
                                    </td>
                                </tr>
                                <tr style="color: #00FFFF; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" onclick="StoppedVehiclesclick();">Stopped Vehicles</span>
                                    </td>
                                    <td>
                                        <span id="txtStopped"></span>
                                    </td>
                                </tr>
                                <tr style="color: #322B2B; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" onclick="MainPowerOffVehiclesclick();">Main Power Off
                                            Vehicles</span>
                                    </td>
                                    <td>
                                        <span id="txtMainpower"></span>
                                    </td>
                                </tr>
                                <tr style="color: #0000FF; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" onclick="DelayVehiclesclick();">Delay Vehicles</span>
                                    </td>
                                    <td>
                                        <span id="txtDelay"></span>
                                    </td>
                                </tr>
                                <tr style="color: #00FF00; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" onclick="InsidePOIVehiclesclick();">Inside POI Vehicles</span>
                                    </td>
                                    <td>
                                        <span id="txtInside"></span>
                                    </td>
                                </tr>
                                <tr style="color: #FF0000; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" onclick="OutSidePOIVehiclesclick();">OutSide POI Vehicles</span>
                                    </td>
                                    <td>
                                        <span id="txtOutSide"></span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="divVehicles">
                </div>
            </div>
        </div>
    </div>
    </section>
</asp:Content>
