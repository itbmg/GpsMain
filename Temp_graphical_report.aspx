<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Temp_graphical_report.aspx.cs" Inherits="Temp_graphical_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
    <script src="https://www.amcharts.com/lib/3/serial.js"></script>
    <script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
   <%-- <script src="AMCharts/amcharts.js?v=1501" type="text/javascript"></script>
    <script src="AMCharts/light.js?v=1501" type="text/javascript"></script>
    <script src="AMCharts/serial.js?v=1501" type="text/javascript"></script>--%>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" type="text/css" href="dist/css/AdminLTE.css" />
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <script src="js/jquery.blockUI.js" type="text/javascript"></script>
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
        #chartdiv
        {
            width: 100%;
            height: 500px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            get_Vehicledetails();
            var date = new Date();
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (month < 10) month = "0" + month;
            if (day < 10) day = "0" + day;
            today = year + "-" + month + "-" + day;
            $('#txt_fromdate').val(today);
            $('#txt_todate').val(today);
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
        function GetFuel_GraphicalClick() {
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
            var Vehcielno = document.getElementById('ddlVehcielno').value;
            if (Vehcielno == "") {
                alert("Select Vehicle No");
                return false;
            }
            var data = { 'op': 'GetTemparature_GraphicalClick', 'fromdate': fromdate, 'todate': todate, 'Vehcielno': Vehcielno };
            var s = function (msg) {
                if (msg) {
                    LineChartforVehicleDiesel(msg);
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
            for (var k = 0; k < databind.length; k++) {
                var BranchName = [];
                var IndentDate = databind[k].TripDate;
                var DeliveryQty = databind[k].diesel;
                var speedlist = databind[k].speedlist;
                var Status = databind[k].Status;
                newXarray = IndentDate.split(',');
                datainXSeries = DeliveryQty.split(',')
                speedseries = speedlist.split(',')
                var firstDate = new Date();
                // now set 500 minutes back
                firstDate.setMinutes(firstDate.getDate() - 1000); ;
                for (var i = 0; i < datainXSeries.length; i++) {
                    var diesel = 0;
                    var datet = newXarray[i];
                    var datetest = new Date(datet);
                    diesel = parseInt(datainXSeries[i]);
                    var newDate = new Date(datetest);
                    // each time we add one minute
                    newDate.setMinutes(newDate.getMinutes() + i);
                    var ravi = newDate;
                    var speed = 0;
                    speed = parseInt(speedseries[i]);
                    //                var visits = Math.round(Math.random() * 40 + 10 + i + Math.random() * i / 5);
                    newYarray.push({ 'date': newDate, 'visits': diesel, 'Speed': speed });
                }
            }
            //        var chartData = generateChartData();

            var chart = AmCharts.makeChart("chartdiv", {
                "type": "serial",
                "theme": "light",
                "marginRight": 80,
                "dataProvider": newYarray,
                "valueAxes": [{
                    "position": "left",
                    "title": "Temperature"
                }],
                "graphs": [{
                    "id": "g1",
                    "fillAlphas": 0.4,
                    "valueField": "visits",
                    "balloonText": "<div style='margin:5px; font-size:19px;'>Temperature:<b>[[value]]</b><br /> Speed:<b>[[Speed]]</b></div>"
                }],
                "chartScrollbar": {
                    "graph": "g1",
                    "scrollbarHeight": 80,
                    "backgroundAlpha": 0,
                    "selectedBackgroundAlpha": 0.1,
                    "selectedBackgroundColor": "#888888",
                    "graphFillAlpha": 0,
                    "graphLineAlpha": 0.5,
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <br />
    <br />
    <section class="content-header">
        <h1>
            Temparature Graphical Report<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Tools</a></li>
            <li><a href="#">Temparature Graphical</a></li>
        </ol>
    </section>
    <br />
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Temparature Graphical Detailes
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
                                <select id="ddlType" class="form-control" onchange="get_Vehicledetails()">
                                    <option>Select Vehicle Type</option>
                                    <option>Puff</option>
                                    <option>Tanker</option>
                                </select>
                            </td>
                            <td style="width: 5px;">
                            </td>
                            <td>
                                <select id="ddlVehcielno" class="form-control">
                                </select>
                            </td>
                            <td style="width: 5px;">
                            </td>
                            <td>
                                From Date
                            </td>
                            <td>
                                <input type="date" class="form-control" id="txt_fromdate" />
                            </td>
                            <td>
                                To Date
                            </td>
                            <td>
                                <input type="date" class="form-control" id="txt_todate" />
                            </td>
                            <td style="width: 5px;">
                            </td>
                            <td>
                                <input type="button" id="submit" value="Generate" class="btn btn-success" onclick="GetFuel_GraphicalClick()" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="chartdiv">
                </div>
            </div>
        </div>
    </section>
</asp:Content>
