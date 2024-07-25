<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="GraphicalFuel_report.aspx.cs" Inherits="test" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
    <script src="https://www.amcharts.com/lib/3/serial.js"></script>
    <script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
    <%--  <script src="AMCharts/amcharts.js?v=1501" type="text/javascript"></script>
    <script src="AMCharts/light.js?v=1501" type="text/javascript"></script>
    <script src="AMCharts/serial.js?v=1501" type="text/javascript"></script>--%>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDbt9z3InHbzrV66t1eSZB5TnlJ2HQ-Uc8&v=3.exp&sensor=false&libraries=geometry"></script>
    <link rel="stylesheet" type="text/css" href="dist/css/AdminLTE.css" />
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <script src="js/jquery.blockUI.js" type="text/javascript"></script>
    <script src="Kendo/jquery.min.js" type="text/javascript"></script>
    <script src="Kendo/kendo.all.min.js" type="text/javascript"></script>
    <link href="Kendo/kendo.common.min.css" rel="stylesheet" type="text/css" />
    <link href="Kendo/kendo.default.min.css" rel="stylesheet" type="text/css" />
    <script src="https://code.jquery.com/jquery-2.1.1.min.js" type="text/javascript"></script>
		<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.1/css/select2.min.css" rel="stylesheet" />
		<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.1/js/select2.min.js" type="text/javascript"></script>
        <script src="plugins/jQuery/jquery.searchabledropdown.js" type="text/javascript"></script>
    <%-- <link rel="stylesheet" href="styles/kendo.common.min.css" />
    <link rel="stylesheet" href="styles/kendo.default.min.css" />
    <link rel="stylesheet" href="styles/kendo.default.mobile.min.css" />--%>
    <style type="text/css">
        #chartdiv
        {
            width: 100%;
            height: 500px;
        }
    </style>
    

    <script type="text/javascript">
        function CallPrint(strid) {
            var divToPrint = document.getElementById(strid);
            var newWin = window.open('', 'Print-Window', 'width=400,height=400,top=100,left=100');
            newWin.document.open();
            newWin.document.write('<html><body   onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
            newWin.document.close();
        }
    </script>
    

    <script type="text/javascript">
        $(function () {
           // $('.se-pre-con').css('display', 'none');
           // get_Vehicledetails();
            var date = new Date();
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (month < 10) month = "0" + month;
            if (day < 10) day = "0" + day;
            var today = year + "-" + month + "-" + day;
            $('#txt_fromdate').val(today);
            $('#txt_todate').val(today);
            
            $('#print1').hide();
            $('#print2').hide();
            $('#print3').hide();
            $('#tblrawdata').hide();

            $('#txt_fromdate1').hide();
            $('#txt_todate1').hide();
            //
//            $(window).load(function () {
//                // Animate loader off screen
//              //  $(".se-pre-con").fadeOut("slow"); ;
//            });

        });
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

        function CallHandlerUsingJson(d, s, e) {
            d = JSON.stringify(d);
            d = encodeURIComponent(d);
            $.ajax({
                type: "GET",
                url: "Bus.axd?json=",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: d,
                async: true,
                cache: true,
                success: s,
                error: e
            });
        }

//        $(document).ready(function () {
//            var country = document.getElementById('ddlVehcielno').value;
//            $("#ddlVehcielno").select2({
//                data: country
//            });
//        });

//        $(".chosen-select").chosen({ width: "100%" });


        function get_Vehicledetails() {
            var vehicleType = document.getElementById('ddlType').value;
            var data = { 'op': 'get_Vehicledetails', 'vehicleType': vehicleType };
            var s = function (msg) {
                if (msg) {
                    fillVehicledetails(msg);
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
        var geodata = [];
        function gaddress(stopdetails) {
            for (var i = 0; i < stopdetails.length; i++) {
                var point = new google.maps.LatLng(stopdetails[i].InLat, stopdetails[i].InLon);
                var address;
                geocoder = new google.maps.Geocoder();
                address = geocoder.geocode({ 'latLng': point }, function (results, addstatus) {
                    if (addstatus == google.maps.GeocoderStatus.OK) {
                        address = results[0].formatted_address;
                        geodata = results;
                    }
                });
            }
        }

        var res = "l";
        function FindAddress(lati, longi) {
            var lat = lati;
            var lng = longi;
            var latlng = new google.maps.LatLng(lat, lng);
            var geocoder = geocoder = new google.maps.Geocoder();
            var address;
            geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[1]) {
                        address = results[1].formatted_address;
                        res = address;
                        alert(address);
                    }
                }
            });
        }

        function filldetails(stopdetails) {
            var name = "KS";
            var Addre = "kk";
            var table = document.getElementById("tblrawdata");
            for (var i = table.rows.length - 1; i > 0; i--) {
                table.deleteRow(i);
            }
            var j = 1;
            var add = [];
            add = geodata;
            for (var i = 0; i < stopdetails.length; i++) {
                var tablerowcnt = document.getElementById("tblrawdata").rows.length;
                var Urlpar = stopdetails[i].InLat + "&long=" + stopdetails[i].InLon + "&lat1=" + stopdetails[i].InToLat + "&long1=" + stopdetails[i].InToLon;
              

                //FindAddress(stopdetails[i].InLat, stopdetails[i].InLon)
                var Dlevel = stopdetails[i].InAvailDiesel;

                if (Dlevel >= 0 && Dlevel < 10) {
                    //$('#tblrawdata').append('<tr scope="row"><td data-title="categorysno">' + stopdetails[i].sno + '</td><th scope="Category Name">' + stopdetails[i].InLat + '</th><th scope="Category Name">' + stopdetails[i].InLon + '</th><th scope="Category Name">' + stopdetails[i].Infrmdate + '</th><th scope="Category Name">' + stopdetails[i].Intodate + '</th><th scope="Category Name">' + stopdetails[i].Ind + '</th><th scope="Category Name">' + stopdetails[i].Inaddress + '</th><th scope="Category Name"><a href="StoppedLocation.aspx?lat=' + Urlpar + '" target="_blank" style="text-decoration: underline;">View Location</a></th><th scope="Category Name">' + stopdetails[i].InFrmDiesel + '</th><th scope="Category Name" >' + stopdetails[i].IntoDiesel + '</th><th scope="Category Name"><span id="spbltr"  class="badge bg-yellow"><span class="clsqtyltr">' + stopdetails[i].InAvailDiesel + '</span></span></th></tr>');
                    // $('#tblrawdata').append('<tr scope="row"><td data-title="categorysno">' + stopdetails[i].sno + '</td><th scope="Category Name">' + stopdetails[i].InLat + '</th><th scope="Category Name">' + stopdetails[i].InLon + '</th><th scope="Category Name">' + stopdetails[i].Infrmdate + '</th><th scope="Category Name">' + stopdetails[i].Intodate + '</th><th scope="Category Name">' + stopdetails[i].Ind + '</th><th scope="Category Name">' + stopdetails[i].Inaddress + '</th><th scope="Category Name"><a href="StoppedLocationDetails.aspx?lat=' + Urlpar + '" target="_blank" style="text-decoration: underline;">View Location</a></th><th scope="Category Name">' + stopdetails[i].InFrmDiesel + '</th><th scope="Category Name" >' + stopdetails[i].IntoDiesel + '</th><th scope="Category Name"><span id="spbltr"  class="badge bg-yellow"><span class="clsqtyltr">' + stopdetails[i].InAvailDiesel + '</span></span></th></tr>');
                }
                else if (Dlevel >= 10) {
                    // $('#tblrawdata').append('<tr scope="row"><td data-title="categorysno">' + stopdetails[i].sno + '</td><th scope="Category Name">' + stopdetails[i].InLat + '</th><th scope="Category Name">' + stopdetails[i].InLon + '</th><th scope="Category Name">' + stopdetails[i].Infrmdate + '</th><th scope="Category Name">' + stopdetails[i].Intodate + '</th><th scope="Category Name">' + stopdetails[i].Ind + '</th><th scope="Category Name">' + stopdetails[i].Inaddress + '</th><th scope="Category Name"><a href="StoppedLocation.aspx?lat=' + Urlpar + '" target="_blank" style="text-decoration: underline;">View Location</a></th><th scope="Category Name">' + stopdetails[i].InFrmDiesel + '</th><th scope="Category Name" >' + stopdetails[i].IntoDiesel + '</th><th scope="Category Name"><span id="spbltr"  class="badge bg-green"><span class="clsqtyltr">' + stopdetails[i].InAvailDiesel + '</span></span></th></tr>');
                    $('#tblrawdata').append('<tr scope="row"><td data-title="categorysno">' + stopdetails[i].sno + '</td><th scope="Category Name">' + stopdetails[i].InLat + '</th><th scope="Category Name">' + stopdetails[i].InLon + '</th><th scope="Category Name">' + stopdetails[i].Infrmdate + '</th><th scope="Category Name">' + stopdetails[i].Intodate + '</th><th scope="Category Name">' + stopdetails[i].Ind + '</th><th scope="Category Name">' + stopdetails[i].Inaddress + '</th><th scope="Category Name"><a href="StoppedLocationDetails.aspx?lat=' + Urlpar + '" target="_blank" style="text-decoration: underline;">View Location</a></th><th scope="Category Name">' + stopdetails[i].InFrmDiesel + '</th><th scope="Category Name" >' + stopdetails[i].IntoDiesel + '</th><th scope="Category Name"><span id="spbltr"  class="badge bg-green"><span class="clsqtyltr">' + stopdetails[i].InAvailDiesel + '</span></span></th></tr>');

                }
                else if (Dlevel <= -10) {
                    //$('#tblrawdata').append('<tr scope="row"><td data-title="categorysno">' + stopdetails[i].sno + '</td><th scope="Category Name">' + stopdetails[i].InLat + '</th><th scope="Category Name">' + stopdetails[i].InLon + '</th><th scope="Category Name">' + stopdetails[i].Infrmdate + '</th><th scope="Category Name">' + stopdetails[i].Intodate + '</th><th scope="Category Name">' + stopdetails[i].Ind + '</th><th scope="Category Name">' + stopdetails[i].Inaddress + '</th><th scope="Category Name"><a href="StoppedLocation.aspx?lat=' + Urlpar + '" target="_blank" style="text-decoration: underline;">View Location</a></th><th scope="Category Name">' + stopdetails[i].InFrmDiesel + '</th><th scope="Category Name" >' + stopdetails[i].IntoDiesel + '</th><th scope="Category Name"><span id="spbltr"  class="badge bg-red"><span class="clsqtyltr">' + stopdetails[i].InAvailDiesel + '</span></span></th></tr>');
                    $('#tblrawdata').append('<tr scope="row"><td data-title="categorysno">' + stopdetails[i].sno + '</td><th scope="Category Name">' + stopdetails[i].InLat + '</th><th scope="Category Name">' + stopdetails[i].InLon + '</th><th scope="Category Name">' + stopdetails[i].Infrmdate + '</th><th scope="Category Name">' + stopdetails[i].Intodate + '</th><th scope="Category Name">' + stopdetails[i].Ind + '</th><th scope="Category Name">' + stopdetails[i].Inaddress + '</th><th scope="Category Name"><a href="StoppedLocationDetails.aspx?lat=' + Urlpar + '" target="_blank" style="text-decoration: underline;">View Location</a></th><th scope="Category Name">' + stopdetails[i].InFrmDiesel + '</th><th scope="Category Name" >' + stopdetails[i].IntoDiesel + '</th><th scope="Category Name"><span id="spbltr"  class="badge bg-red"><span class="clsqtyltr">' + stopdetails[i].InAvailDiesel + '</span></span></th></tr>');
                }
                else {
                }
                j++;
            }
        }

        function fillVehicledetails(msg) {
            var vehmake = document.getElementById('ddlVehcielno');
            var length = vehmake.options.length;
            document.getElementById('ddlVehcielno').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Vehicle No";
            opt.value = "Select Vehicle No";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            vehmake.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                var option = document.createElement('option');
                option.innerHTML = msg[i].VehicleID;
                option.value = msg[i].VehicleID;
                vehmake.appendChild(option);
            }
        }
        function createBarChart(msg) {
            var newYarray = [];
            var newYarray1 = [];
            var newYarray2 = [];
            var newXarray = [];
            //            var Section = msg[0].branchid;
            for (var k = 0; k < msg.length; k++) {
                // var BranchName = [];
                var Dateandtime = msg[k].Kmdata;
                var newYarr = msg[k].SkSpeedInfo;
                //                var DeliveryQty = msg[k].branchname;
                //                var Status = msg[k].StoresValue;
                newXarray = Dateandtime.split(',');
                newYarray1 = newYarr.split(',');

                for (var i = 0; i < msg.length; i++) {
                    newYarray.push({ 'data': msg[i].Rawdata.split(','), 'name': "LogsData" });
                    //                }
                    //                for (var i = 0; i < msg.length; i++) {
                    newYarray.push({ 'data': msg[i].Avgdata.split(','), 'name': newYarray1[i] });
                    //                }
                    //                for (var i = 0; i < msg.length; i++) {
                    newYarray.push({ 'data': msg[i].Resultdata.split(','), 'name': "ActualData" });
                    //                }
                }
            }
            $("#barchartdiv").kendoChart({
                title: {
                    text: "Fuel BarChart"
                },
                legend: {
                    position: "top"
                },
                seriesDefaults: {
                    type: "column"
                },
                series: newYarray,
                //                series: [{
                //                    name: "LogsData",
                //                    data: newYarray
                //                }, {
                //                    name: "MinimumData",
                //                    data: newYarray1
                //                }, {
                //                    name: "ActualData",
                //                    data: newYarray2
                //                }],
                valueAxis: {
                    labels: {
                        format: "{0}%"
                    },
                    line: {
                        visible: false
                    },
                    axisCrossingValue: -10
                },
                categoryAxis: {
                    categories: newXarray,
                    majorGridLines: {
                        visible: false
                    },
                    labels: {
                        rotation: 65
                    }
                },
                tooltip: {
                    visible: true,
                    format: "{0}%",
                    template: "#= series.name #: #= value #"
                }
            });
        }

        function GetFuel_GraphicalClick() {
           // $('.se-pre-con').css('display', 'block');
            var fromdate = document.getElementById('txt_fromdate').value;
            if (fromdate == "") {
                alert("Please select from date");
                return false;
            }
            var todate = document.getElementById('txt_todate').value;
            if (todate == "") {
                alert("Please select to date");
                return false;
            }
            var ddlVehcielno = document.getElementById('ddlVehcielno').value;
            if (ddlVehcielno == "") {
                alert("Select Vehicle No");
                return false;
            }

             var Tripid1 = document.getElementById('slct_Tripid').value;
            if (Tripid1 == "") {
                alert("Select Tripid");
                return false;
            }




            var data = { 'op': 'GetFuel_GraphicalClick', 'fromdate': fromdate, 'todate': todate, 'vehlno': ddlVehcielno, 'Tripid1': Tripid1 };
            var s = function (msg) {
                if (msg) {
                    $('#div_Tripinfo').show();
                    $('#print1').show();
                    $('#print2').show();
                    $('#print3').show();
                    $('#tblrawdata').show();
                    LineChartforVehicleDiesel(msg);
                    createBarChart(msg);
                   // $('.se-pre-con').css('display', 'none');
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

        function LineChartforVehicleDiesel(databind) {
            var datainXSeries = 0;
            var datainYSeries = 0;
            var speedseries = 0;
            var newXarray = [];
            var newYarray = [];
            $('#div_data').css('display', 'block');
            var Startlevel = databind[0].Startinglevel;
            var Endlevel = databind[0].Endinglevel;
            var totdistance = databind[0].totdistance;
            var todaydiesel = databind[0].todaydiesel;
            var maxspeed = databind[0].maxspeed;
            Startlevel = parseFloat(Startlevel).toFixed(2);
            Endlevel = parseFloat(Endlevel).toFixed(2);
            totdistance = parseFloat(totdistance).toFixed(2);
            todaydiesel = parseFloat(todaydiesel).toFixed(2);
            document.getElementById('txt_Startlevel').innerHTML = Startlevel;
            document.getElementById('txt_Endlevel').innerHTML = Endlevel;
            document.getElementById('tot_distance').innerHTML = totdistance;
            document.getElementById('txt_diesel').innerHTML = todaydiesel;
            var mileage = 0;
            mileage = parseFloat(totdistance) / parseFloat(todaydiesel);
            mileage = parseFloat(mileage).toFixed(2);
            document.getElementById('txt_Mileage').innerHTML = mileage;
            document.getElementById('txt_Maxspeed').innerHTML = maxspeed;
            //Fleet
            var Fleetkm = databind[0].Fleetkm;
            var Fleetmileage = databind[0].Fleetmileage;
            var Fleetfuel = databind[0].Fleetfuel

            document.getElementById('tot_Fleetdistance').innerHTML = Fleetkm;
            document.getElementById('txt_Fleetdiesel').innerHTML = Fleetfuel;
            document.getElementById('txt_FleetMileage').innerHTML = Fleetmileage;

            for (var k = 0; k < databind.length; k++) {

                var IndentDate = databind[k].TripDate;
                var DeliveryQty = databind[k].diesel;
                var speedlist = databind[k].speedlist;
                // var Status = databind[k].Status;
                //
                var stoplist = databind[k].Stopeddatafilldetails;
                // gaddress(stoplist)
                //
                newXarray = IndentDate.split(',');
                datainXSeries = DeliveryQty.split(',')
                speedseries = speedlist.split(',')
                var firstDate = new Date();
                filldetails(stoplist)
                // now set 500 minutes back
                firstDate.setMinutes(firstDate.getDate() - 1000); ;
                for (var i = 0; i < datainXSeries.length; i++) {
                    var diesel = 0;
                    var datet = newXarray[i];
                    var datetest = new Date(datet);
                    diesel = parseInt(datainXSeries[i]);
                    var newDate = new Date(datetest);
                    // each time we add one minute
                    // newDate.setMinutes(newDate.getMinutes() + i);
                    newDate.setMinutes(newDate.getMinutes());
                    var ravi = newDate;
                    var speed = 0;
                    speed = parseInt(speedseries[i]);
                    //                var visits = Math.round(Math.random() * 40 + 10 + i + Math.random() * i / 5);
                    newYarray.push({ 'date': newDate, 'visits': diesel, 'Speed': speed, 'Ddate': datet });
                }
            }
            //        var chartData = generateChartData();

            var chart = AmCharts.makeChart("chartdiv", {
                "type": "serial",
                "theme": "none",
                "marginRight": 80,
                "dataProvider": newYarray,
                "valueAxes": [{
                    "position": "left",
                    "title": "Diesel Value"
                }],
                "graphs": [{
                    "id": "g1",
                    "fillAlphas": 0.9,
                    "lineAlpha": 9.0,
                    "valueField": "visits",
                    "balloonText": "<div style='margin:2px; font-size:12px;'>Diesel:<b>[[value]]</b><br /> Speed:<b>[[Speed]]</b><br />Date:<b>[[Ddate]]</b><br /></div>"
                }],
                "chartScrollbar": {
                    "graph": "g1",
                    "scrollbarHeight": 80,
                    "backgroundAlpha": 0,
                    "selectedBackgroundAlpha": 0.1,
                    "selectedBackgroundColor": "#888888",
                    "graphFillAlpha": 0,
                    "graphLineAlpha": 1.0,
                    "selectedGraphFillAlpha": 0,
                    "selectedGraphLineAlpha": 1,
                    "autoGridCount": true,
                    "color": "#AAAAAA"
                },
                "chartCursor": {
                    "categoryBalloonDateFormat": "JJ:NN, DD MMMM",
                    "cursorPosition": "mouse"
                },
                "categoryField": "date",
                "categoryAxis": {
                    "minPeriod": "mm",
                    "parseDates": true
                },
                "export": {
                    "enabled": true,
                    "dateFormat": "YYYY-MM-DD HH:NN:SS"
                }
            });

            chart.addListener("dataUpdated", zoomChart);
            // when we apply theme, the dataUpdated event is fired even before we add listener, so
            // we need to call zoomChart here
            zoomChart();
            // this method is called when chart is first inited as we listen for "dataUpdated" event
            function zoomChart() {
                // different zoom methods can be used - zoomToIndexes, zoomToDates, zoomToCategoryValues
                //            chart.zoomToIndexes(chartData.length - 250, chartData.length - 100);
            }
        }

        //
        function Load_vehicle() {
            get_Vehicledetails();
        }

        //Load Tripid
        function Load_tripid() {
            Tripclear();
            var vehicleno = document.getElementById('ddlVehcielno').value;
            var data = { 'op': 'LoadTripid', 'vehicleno': vehicleno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillTripid(msg);
                    }
                    else {
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }

        var tripid_array = [];
        function fillTripid(msg) {
            var department = document.getElementById('slct_Tripid');
            var length = department.options.length;
            document.getElementById('slct_Tripid').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Tripid";
            opt.value = "Select Tripid";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            department.appendChild(opt);
            if (msg.length > 0) {
                
                tripid_array = msg;
            }
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].Tripid != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].Tripid;
                    option.value = msg[i].Tripno;
                    department.appendChild(option);
                }
            }
        }

        function Tripclear() {
            document.getElementById('divVehicleTripTimes').innerHTML = "";
            document.getElementById('chartdiv').innerHTML = "";
            document.getElementById('tblrawdata').innerHTML = "";
            document.getElementById('barchartdiv').innerHTML = "";
            document.getElementById('tot_Fleetdistance').innerHTML = "";
            document.getElementById('txt_Fleetdiesel').innerHTML = "";
            document.getElementById('txt_FleetMileage').innerHTML = "";
            document.getElementById('tot_distance').innerHTML = "";
            document.getElementById('txt_diesel').innerHTML = "";
            document.getElementById('txt_Mileage').innerHTML = "";
            document.getElementById('txt_Startlevel').innerHTML = "";
            document.getElementById('txt_Endlevel').innerHTML = "";
            document.getElementById('txt_Maxspeed').innerHTML = "";            
            $('#div_Tripinfo').hide();
            $('#print1').hide();
            $('#print2').hide();
            $('#print3').hide();
        }


        function Load_TripTimes() {
            //
            Tripclear();
           //         
            var Tripid = document.getElementById('slct_Tripid').value;
            var t = document.getElementById('slct_Tripid');
            var Tripso = t.options[t.selectedIndex].text;
            //
            var Tripidarry = [];
            var Tripidatetimes = [];
            for (var i = 0; i < tripid_array.length; i++) {
                var Tripno = "";
                Tripno = tripid_array[i].Tripno;
                Tripidarry.push({ 'Tripno': Tripno });
            }
            //
            
            var TripIndex = document.getElementById('slct_Tripid').selectedIndex;
            var data = { 'op': 'LoadTripTimes', 'Tripid': Tripid, 'Tripso': Tripso, 'TripIndex': TripIndex, 'Tripidarry': Tripidarry };
            var s = function (msg) {
                //
                for (var i = 0; i < msg.length; i++) {
                    var Triptype = "";
                    var TripstartTime = "";
                    var TripendTime = "";
                    Triptype = msg[i].Triptype;
                    TripstartTime = msg[i].TripstartTime;
                    TripendTime = msg[i].TripendTime;
                    Tripidatetimes.push({ 'Triptype': Triptype, 'TripstartTime': TripstartTime, 'TripendTime': TripendTime });
                }
                FillDates(Tripidatetimes);
                //

            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            CallHandlerUsingJson(data, s, e);
        }
        function FillDates(Tripidatetimes1) {
            document.getElementById('divVehicleTripTimes').innerHTML = "";
           
            var data = "<table style='margin: 12px 25px 12px 25px;'>";
            for (var i = 0; i < Tripidatetimes1.length; i++) {

                data += "<tr><td style='border: 1px solid #B2BEB5 ;'><input type='checkbox' name='checkbox' value='checkbox' onchange='Time_onchange(this);' id = " + i + " class = 'chkclass'/><span for=" + i + ">" + Tripidatetimes1[i].Triptype + "</span></td><td style='border: 1px solid #B2BEB5 ;'><span for=" + i + ">" + Tripidatetimes1[i].TripstartTime + "</span></td><td style='border: 1px solid #B2BEB5 ;'><span for=" + i + ">" + Tripidatetimes1[i].TripendTime + "</span></td></tr>";               
            }
            data += "</table>";
            $('#divVehicleTripTimes').append(data);
        }
        function Time_onchange(thisid) {
            var ckdvlsdiv = document.getElementById('divVehicleTripTimes').childNodes;
            var checkedvehicleTools = "";
            for (var i = 0, row; row = ckdvlsdiv[0].rows[i]; i++) {
                if (row.cells[0].childNodes[0].type == 'checkbox' && row.cells[0].childNodes[0].checked == true) {
                    var labelval = row.cells[0].childNodes[1].innerHTML;
                    checkedvehicleTools += labelval + ",";
                    var labelval1 = row.cells[1].childNodes[0].innerHTML;
                    var labelval2 = row.cells[2].childNodes[0].innerHTML;

                    $('#txt_fromdate').val(labelval1);
                    $('#txt_todate').val(labelval2);
                  // document.getElementById('txt_fromdate').innerHTML = labelval1;
                    // document.getElementById('txt_todate').innerHTML = labelval2;

                }
                else {

                }
                    
            }
            $(".chkclass").click(function () {
                $(".chkclass").attr("checked", false); //uncheck all checkboxes
                $(this).attr("checked", true);  //check the clicked one
              

            });
        }
       


       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <div class="se-pre-con"></div>
    <br />
    <br />
    <section class="content-header">
        <h1>
            Fuel Graphical Report<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Tools</a></li>
            <li><a href="#">Fuel Graphical</a></li>
        </ol>
    </section>
    <br />
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Fuel Graphical Detailes
                </h3>
            </div>
            <div class="box-body">
            
             
                <div style="text-align: center;">
                    <table align="center">
                        <tr>                            
                            <td style="width: 160px;">                            
                                <select id="ddlType" class="form-control" onchange="Load_vehicle()">
                                    <option>Select Vehicle Type</option>
                                    <option>Puff</option>
                                    <option>Tanker</option>
                                </select>
                            </td>
                            <td style="width: 20px;">
                            </td>
                            <td>
                                <select id="ddlVehcielno" onchange="Load_tripid()" class="form-control" style="width: 200px;">
                                </select>
                            </td>
                            <td style="width: 4px;">
                            </td>
                            <td>
                                <select id="slct_Tripid" onchange="Load_TripTimes()" class="form-control">
                                <option selected disabled value="Select Location" >Select Location</option>
                                </select>
                            </td>
                            
                            <td style="width: 4px;">
                            </td>
                            <td>
                                From Date
                            </td>
                            <td>
                            <%--<span contenteditable type="datetime-local" class="form-control"  id="txt_fromdate" /></span>     --%> 
                            <input  type="datetime-local" class="form-control"  id="txt_fromdate1" />   
                            <input  type="datetime" class="form-control"  id="txt_fromdate" />                          
                            </td>
                            <td>
                                To Date
                            </td>
                            <td>
                            <input contenteditable type="datetime-local" class="form-control" id="txt_todate1"/>
                             <input  type="datetime" class="form-control"  id="txt_todate" />       
                                <%--<span contenteditable type="datetime-local" class="form-control" id="txt_todate" /></span>--%>
                            </td>
                            <td style="width: 4px;">
                            </td>
                            <td>
                                <input type="button" id="submit" value="Generate" class="btn btn-success" onclick="GetFuel_GraphicalClick()" />
                            </td>
                        </tr>
                        <tr>                     
                        
                        <td colspan="13" align="center">
                          <div class="col-lg-3 col-xs-6" style="width: 100%;">               
                                <div class="inner">
                                   <div id="divVehicleTripTimes" style="height: 130px;  overflow: auto; padding-left: 10%; border-radius: 7px 7px 7px 7px; font-size: 18px">
                                </div>
                                </div>        
                        </div>
                            
                             </td>
                        </tr>
                    </table>
                    

                </div>
               
                <br />
                <div style="width: 100%;">
                    <div style="width: 80%; float: left;">
                    <input type="button" id="print1" class="btn btn-primary" onclick="javascript:CallPrint('divPrint');" value="Print">
                    <div id="divPrint">
                        <div id="chartdiv">
                        </div>
                        </div>
                    </div>
                      <div id="div_data" style="display:none;">
                    <div id="div_Tripinfo" style="width: 19%; float: right;">
                        <div class="col-lg-3 col-xs-6"  style="width: 100%;">
                            <!-- small box -->
                            <div class="small-box bg-red">
                                <div class="inner">
                                    <h3>
                                    <span id="txt_Startlevel"></span><sup style="font-size: 15px"></sup></h3>
                                    <p>Starting Level</p>
                                     <h3>
                                     <span id="txt_Endlevel"></span><sup style="font-size: 15px"></sup></h3>
                                    <p>Ending Level</p>
                                </div>
                                <div class="icon">
                                  <i class="ion ion-stats-bars"></i>
                                    
                                </div>                               
                            </div>
                        </div>
                        <div style="display:none;"  class="col-lg-3 col-xs-6" style="width: 100%;">
                            <div class="small-box bg-aqua">
                                <div class="inner">
                                    <h3><span id="tot_distance"></span><sup style="font-size: 15px">kms</sup></h3>
                                        <h3> <span id="txt_diesel"></span><sup style="font-size: 15px">ltr</sup></h3>
                                        <h3><span id="txt_Mileage"></span><sup style="font-size: 15px">km/ltr</sup></h3>
                                    <p>Gps Informations</p>
                                </div>
                                <div class="icon">
                                    <i class="ion ion-bag"></i>
                                </div>
                                <%--      <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>--%>
                            </div>
                        </div>
                        <div class="col-lg-3 col-xs-6" style="width: 100%;">
                            <!-- small box -->
                            <div class="small-box bg-green">
                                <div class="inner">
                                      <h3><span id="tot_Fleetdistance"></span><sup style="font-size: 15px">kms</sup></h3>
                                        <h3> <span id="txt_Fleetdiesel"></span><sup style="font-size: 15px">ltr</sup></h3>
                                        <h3><span id="txt_FleetMileage"></span><sup style="font-size: 15px">km/ltr</sup></h3>                           
                                     <p>Fleet Informations</p>
                                </div>
                                <div class="icon">
                                  <i class="ion ion-pie-graph"></i>
                                </div>
                                <%--<a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>--%>
                            </div>
                        </div>
                      
                        <div class="col-lg-3 col-xs-6"  style="width: 100%;">
                            <!-- small box -->
                            <div class="small-box bg-yellow">
                                <div class="inner">
                                    <h3>
                                        <span id="txt_Maxspeed"></span><sup style="font-size: 15px"></sup></h3>
                                    <p>
                                        Max Speed</p>
                                </div>
                                <div class="icon">
                                  <i class="ion ion-stats-bars"></i>
                                    
                                </div>
                                <%--   <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>--%>
                            </div>
                        </div>                        
                    </div>
                    </div>                    
                </div>
                 <div style="width: 100%;">
                    <div style="width: 80%; float: left;">
                    <input type="button" id="print2" class="btn btn-primary" onclick="javascript:CallPrint('Stoppeddatadiv');" value="Print">
                        <div id="Stoppeddatadiv">
                         <table id="tblrawdata" class="table table-bordered table-hover dataTable no-footer" border="1" >
                                    <tr style="border: 1px solid ; background-color: #d5d5d5; height: 30px;
                                        font-family: Arial; font-weight: normal; font-size: 12px;">
                                         <th style="width: 50px;">
                                            Sno
                                        </th>
                                        <th style="width: 100px;">
                                            latitude
                                        </th>
                                        <th style="width: 100px;">
                                            longitude
                                        </th>
                                        <th style="width: 150px;">
                                            From Time
                                        </th>
                                        <th style="width: 150px;">
                                            To Time
                                        </th>
                                        <th style="width: 120px;">
                                            Ideal Time
                                        </th>  
                                        <th style="width: 500px;">
                                            Address
                                        </th>                                      
                                        <th style="width: 120px;">
                                            Location
                                        </th>
                                        <th style="width: 120px;">
                                           Level1(Diesel)
                                        </th>
                                        <th style="width: 120px;">
                                           Level2(Diesel)
                                        </th>
                                        <th style="width: 120px;">
                                           Diff Diesel
                                        </th>
                                    </tr>
                                </table>
                        </div>
                    </div>                    
                </div>
                 <div style="width: 100%;">
                    <div style="width: 80%; float: left;">
                    <input type="button" id="print3" class="btn btn-primary" onclick="javascript:CallPrint('barchartdiv');" value="Print">
                        <div id="barchartdiv">
                        </div>
                    </div>
                    </div>
             <%--   <asp:Label ID="Lbl_TotDiesel" runat="server" Text="Total Diesl Consumed"></asp:Label>
                <asp:TextBox ID="Txt_TotDiesel" runat="server"></asp:TextBox>--%>
            </div>
              

        </div>
    </section>
</asp:Content>
