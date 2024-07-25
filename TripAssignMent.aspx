<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TripAssignMent.aspx.cs" Inherits="TripAssignMent" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <script src="plugins/morris/morris.js" type="text/javascript"></script>
    <!-- Theme style -->
    <link rel="stylesheet" type="text/css" href="dist/css/AdminLTE.css" />
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/iCheck/flat/blue.css">
    <!-- Morris chart -->
    <link rel="stylesheet" href="plugins/morris/morris.css">
    <!-- jvectormap -->
    <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker-bs3.css">
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
    <script src="JSF/jquery.min.js"></script>
    <script src="JSF/jquery-ui.js" type="text/javascript"></script>
    <script src="JSF/jquery.blockUI.js" type="text/javascript"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <script src="JSF/jquery.blockUI.js" type="text/javascript"></script>
    <link href="css/custom.css" rel="stylesheet" type="text/css" />
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
        ul#menulist
        {
            background: none repeat scroll 0 0 #ECECEC;
            margin: 0;
            padding: 7px 20px;
        }
        ul#menulist li
        {
            font-size: 12px;
            padding-bottom: 2px;
            margin: 1px 0px 1px 2px;
            color: #000000;
            line-height: 17px;
            padding: 2px 5px 2px 5px;
            border-bottom: #efefef 1px dotted;
            list-style-type: none;
            text-align: right;
            display: inline;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            get_vehiclenos();
            get_Plantnames();
            get_trip_configaration_details();
            $('#divclose').click(function () {
                $('#divRouteAssign').css('display', 'none');
            });
        });
        function get_vehiclenos() {
            var data = { 'op': 'get_vehicle_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillvehiclenos(msg);
                    }
                    else {
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function fillvehiclenos(msg) {
            var data = document.getElementById('slct_vehicle_no');
            var length = data.options.length;
            document.getElementById('slct_vehicle_no').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Vehicle No";
            opt.value = "Select Vehicle No";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].VehicleNo != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].VehicleNo;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }
        function get_Plantnames() {
            var data = { 'op': 'get_Plantname_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillPlantnames(msg);
                    }
                    else {
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function fillPlantnames(msg) {
            var data = document.getElementById('ddlPlantName');
            var length = data.options.length;
            document.getElementById('ddlPlantName').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Plant Name";
            opt.value = "Select Plant Name";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].plantname != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].plantname;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }
        function get_trip_configaration_details() {
            var data = { 'op': 'get_trip_configaration_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        bindplantdata(msg);
                    }
                    else {
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function bindplantdata(msg) {
            var results = '<div class="divcontainer" style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
            results += '<thead><tr><th></th><th>Sno</th><th scope="col" style="text-align: center !important;">Vehicle Number</th><th scope="col">Trip Name</th><th scope="col">Start Time</th><th scope="col">End Time</th><th scope="col">Status</th><th scope="col">Creation Date	</th><th scope="col">Is Repeat</th><th scope="col">Route Name</th><th scope="col">Plant Name</th><th scope="col">Kms</th><th scope="col">Empty kms</th><th scope="col">Chargeperkm</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr><td><input id="btn_poplate" type="button"  onclick="getme(this)" name="submit" class="btn btn-success" value="Edit" /></td>';
                results += '<td scope="row" class="1">' + i + '</td>';
                results += '<td scope="row" class="2">' + msg[i].vehicleno + '</td>';
                results += '<td data-title="Code" class="3">' + msg[i].tripname + '</td>';
                results += '<td data-title="Code" class="4">' + msg[i].starttime + '</td>';
                results += '<td data-title="Code" class="5">' + msg[i].endtime + '</td>';
                results += '<td data-title="Code" class="6">' + msg[i].status + '</td>';
                results += '<td data-title="Code" class="7">' + msg[i].creationdate + '</td>';
                results += '<td data-title="Code" class="8">' + msg[i].isrepeat + '</td>';
                results += '<td data-title="Code" class="9">' + msg[i].routename + '</td>';
                results += '<td data-title="Code" class="10">' + msg[i].plantname + '</td>';
                results += '<td data-title="Code" class="11">' + msg[i].kms + '</td>';
                results += '<td data-title="Code" class="12">' + msg[i].emptykms + '</td>';
                results += '<td data-title="Code" class="13">' + msg[i].chargeperkm + '</td>';
                results += '<td data-title="Code"  style="display:none;" class="15">' + msg[i].vehicle_sno + '</td>';
                results += '<td data-title="Code" class="14" style="display:none;">' + msg[i].tripsno + '</td></tr>';
            }
            results += '</table></div>';
            $("#div_Deptdata").html(results);
        }
        function getme(thisid) {
            var vehicleno = $(thisid).parent().parent().children('.2').html();
            var tripname = $(thisid).parent().parent().children('.3').html();
            var starttime = $(thisid).parent().parent().children('.4').html();
            var endtime = $(thisid).parent().parent().children('.5').html();
            var status = $(thisid).parent().parent().children('.6').html();
            var creationdate = $(thisid).parent().parent().children('.7').html();
            var isrepeat = $(thisid).parent().parent().children('.8').html();
            var routename = $(thisid).parent().parent().children('.9').html();
            var plantname = $(thisid).parent().parent().children('.10').html();
            var kms = $(thisid).parent().parent().children('.11').html();
            var emptykms = $(thisid).parent().parent().children('.12').html();
            var chargeperkm = $(thisid).parent().parent().children('.13').html();
            var tripsno = $(thisid).parent().parent().children('.14').html();
            var vehicle_sno = $(thisid).parent().parent().children('.15').html();
            document.getElementById('lbl_sno').innerHTML = tripsno;
            document.getElementById('txtTripName').value = tripname;
            document.getElementById('slct_vehicle_no').value = vehicle_sno;
            document.getElementById('txtstartTime').value = starttime;
            document.getElementById('txtendtime').value = endtime;
            if (isrepeat == "true") {
                document.getElementById('ckbRepeat').checked = true;
            }
            else {
                document.getElementById('ckbRepeat').checked = false;

            }
            document.getElementById('txtKms').value = kms;
            document.getElementById('txt_extrakms').value = emptykms;
            document.getElementById('txt_charge').value = chargeperkm;

            document.getElementById('ddlStatus').value = status;
            document.getElementById('txtRouteName').value = routename;
            document.getElementById('ddlPlantName').value = plantname;
            document.getElementById('btn_save').value = "Modify";
            $('#tripsave').css('display', 'block');

        }
        function btnSelectRouteclick() {
            var txtTripName = document.getElementById('txtTripName').value;
            var ddlVehicleno = document.getElementById('slct_vehicle_no').value;
            document.getElementById('txtTripNo1').innerHTML = txtTripName;
            document.getElementById('txtVehicleNo1').innerHTML = ddlVehicleno;
            if (txtTripName == "") {
                alert("Please Enter Trip Name");
                return false;
            }
            if (ddlVehicleno == "") {
                alert("Please Select Vehicleno");
                return false;
            }
            FillRoutes();
            $('#divTrip').css('display', 'block');
            //            $('#divTrip').setTemplateURL('Trip.htm');
            //            $('#divTrip').processTemplate();
            var data = [];
            var results = '<div class="divcontainer" style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
            results += '<thead><tr><th scope="col">#</th><th scope="col">Batch Name</th><th scope="col">Code</th></tr></thead></tbody>';
            for (var i = 0; i < data.length; i++) {
                results += '<tr><td scope="row" class="1" style="text-align:center;">' + data[i].Sno + '</td>';
                results += '<td data-title="Capacity" class="2">' + data[i].LocationID + '</td>';
                results += '<td data-title="Capacity" class="2">' + data[i].BranchName + '</td>';
                results += '<td style="display:none" class="3">' + data[i].Rank + '</td></tr>';
            }
            results += '</table></div>';
            $("#divTrip").html(results);
            $('#divRouteAssign').css("display", "block");
        }
        function ddlRouteNameChange() {
            var RoteName = document.getElementById('ddlRouteName').value;
            var data = { 'op': 'ddlRouteNameChange', 'RoteName': RoteName };
            var s = function (msg) {
                if (msg) {
                    BindtoGrid(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        var DataTable;
        function BindtoGrid(data) {
            DataTable = data;
            //            $('#divTrip').setTemplateURL('Trip.htm');
            //            $('#divTrip').processTemplate(data);
            var results = '<div class="divcontainer" style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
            results += '<thead><tr><th scope="col">#</th><th scope="col">Batch Name</th><th scope="col">Code</th></tr></thead></tbody>';
            for (var i = 0; i < data.length; i++) {
                results += '<tr><td scope="row" class="1" style="text-align:center;">' + data[i].Sno + '</td>';
                results += '<td data-title="Capacity" class="2">' + data[i].LocationID + '</td>';
                results += '<td data-title="Capacity" class="2">' + data[i].BranchName + '</td>';
                results += '<td style="display:none" class="3">' + data[i].Rank + '</td></tr>';
            }
            results += '</table></div>';
            $("#divTrip").html(results);
        }
        function FillRoutes() {
            var data = { 'op': 'GetRouteNames' };
            var s = function (msg) {
                if (msg) {
                    BindRouteName(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            callHandler(data, s, e);
        }
        function SelectionTrip() {
            $('#tripsave').css('display', 'block');
            FillRoutes();
            document.getElementById('ddlRouteName').value = '<%=Session["status"] %>';
        }
        function btnTripSaveClick() {

            $('#tripsave').css('display', 'block');
            document.getElementById('txtRouteName').value = document.getElementById('ddlRouteName').value;
            $('#divRouteAssign').css('display', 'none');
        }
        function BindRouteName(msg) {
            document.getElementById('ddlRouteName').options.length = "";
            var veh = document.getElementById('ddlRouteName');
            var length = veh.options.length;
            for (i = 0; i < length; i++) {
                veh.options[i] = null;
            }
            var opt = document.createElement('option');
            opt.innerHTML = "Select Route";
            opt.value = "";
            veh.appendChild(opt);
            for (var i = 0; i < msg[0].RouteNames.length; i++) {
                if (msg[0].RouteNames[i] != null) {
                    var opt = document.createElement('option');
                    opt.innerHTML = msg[0].RouteNames[i];
                    opt.value = msg[0].RouteNames[i];
                    veh.appendChild(opt);
                }
            }
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
        function Trip_configuaration_save_click() {
            var tripname = document.getElementById('txtTripName').value;
            var vehicleno = document.getElementById('slct_vehicle_no').value;
            var starttime = document.getElementById('txtstartTime').value;
            var endtime = document.getElementById('txtendtime').value;
            var kms = document.getElementById('txtKms').value;
            var emptykms = document.getElementById('txt_extrakms').value;
            var chargeperkm = document.getElementById('txt_charge').value;
            var status = document.getElementById('ddlStatus').value;
            var routename = document.getElementById('txtRouteName').value;
            var plantname = document.getElementById('ddlPlantName').value;
            var btn_val = document.getElementById('btn_save').value;
            var ckbRepeat = document.getElementById('ckbRepeat').checked;
            var tripsno = document.getElementById('lbl_sno').innerHTML;
            var data = { 'op': 'Trip_configuaration_save_click', 'tripname': tripname, 'vehicleno': vehicleno, 'starttime': starttime, 'endtime': endtime, 'isrepeat': ckbRepeat,
                'kms': kms, 'emptykms': emptykms, 'chargeperkm': chargeperkm, 'status': status, 'routename': routename, 'plantname': plantname, 'btn_val': btn_val, 'tripsno': tripsno
            };
            var s = function (msg) {
                if (msg) {
                    alert(msg);
                    clearall();
                    get_trip_configaration_details();
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function clearall() {
            document.getElementById('txtTripName').value = "";
            document.getElementById('slct_vehicle_no').value = "";
            document.getElementById('txtstartTime').value = "";
            document.getElementById('txtendtime').value = "";
            document.getElementById('ckbRepeat').value = "";
            document.getElementById('txtKms').value = "";
            document.getElementById('txt_extrakms').value = "";
            document.getElementById('txt_charge').value = "";
            document.getElementById('ddlStatus').value = "";
            document.getElementById('txtRouteName').value = "";
            document.getElementById('ddlPlantName').value = "";
            document.getElementById('btn_save').value = "Save";
            $('#tripsave').css('display', 'none');
        }
    </script>
    <br />
    <br />
    <div>
        
        <br />
        <section class="content">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">
                        <i style="padding-right: 5px;" class="fa fa-cog"></i>Trip AssignMent Details
                    </h3>
                </div>
                <div class="box-body">
                    <table align="center">
                        <tr>
                            <td>
                                <label>
                                    Trip Name</label>
                            </td>
                            <td style="height: 40px;">
                                <input type="text" id="txtTripName" placeholder="Enter Trip Name" class="form-control" />
                            </td>
                            <td style="width: 5px;">
                            </td>
                            <td>
                                <label>
                                    Vehicle No</label>
                            </td>
                            <td style="height: 40px;">
                                <select id="slct_vehicle_no" class="form-control">
                                    <option selected disabled value="Select Vehicle No">Select Vehicle No</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    Start Time</label>
                            </td>
                            <td style="height: 40px;">
                                <input type="datetime" id="txtstartTime" placeholder="Enter Start Time" class="form-control" />
                            </td>
                            <td style="width: 5px;">
                            </td>
                            <td>
                                <label>
                                    End Time</label>
                            </td>
                            <td style="height: 40px;">
                                <input type="datetime" id="txtendtime" placeholder="Enter End Time" class="form-control" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    Actual Kms</label>
                            </td>
                            <td style="height: 40px;">
                                <input type="text" id="txtKms" placeholder="Enter Actual Kms" class="form-control" />
                            </td>
                            <td style="width: 5px;">
                            </td>
                            <td>
                                <input type="checkbox" value="IsRepeat" id="ckbRepeat" /><label>IsRepeat</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    Empty Kms</label>
                            </td>
                            <td style="height: 40px;">
                                <input type="text" id="txt_extrakms" placeholder="Enter Empty Kms" class="form-control" />
                            </td>
                            <td style="width: 5px;">
                            </td>
                            <td>
                                <label>
                                    Charge Per Km</label>
                            </td>
                            <td style="height: 40px">
                                <input type="text" id="txt_charge" placeholder="Enter Charge Per Km" class="form-control" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    Status</label>
                            </td>
                            <td style="height: 40px">
                                <select id="ddlStatus" class="form-control">
                                    <option>Active</option>
                                    <option>Inactive</option>
                                </select>
                            </td>
                            <td style="width: 5px;">
                            </td>
                            <td colspan="3">
                                <input type="button" value="Select Route Name" id="btnSelectRoute" onclick="btnSelectRouteclick();"
                                    class="btn btn-success" />
                            </td>
                            <td style="width: 5px;">
                            </td>
                            <td>
                                <input type="text" id="txtRouteName" class="form-control" value="" readonly="readonly" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    Palnt Name</label>
                            </td>
                            <td style="height: 40px">
                                <select id="ddlPlantName" class="form-control">
                                    <option selected disabled value="Select Vehicle No">Select Plant Name</option>
                                </select>
                            </td>
                        </tr>
                        <tr hidden>
                            <td>
                                <label id="lbl_sno">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td id="tripsave" style="display: none;">
                                <input type="button" value="Save" id="btn_save" onclick="Trip_configuaration_save_click();"
                                    class="btn btn-success" />
                            </td>
                        </tr>
                    </table>
                    <div id="div_Deptdata" style="height: 400px; overflow: auto;">
                    </div>
                </div>
                <div id="divRouteAssign" class="pickupclass" style="text-align: center; height: 100%;
                    width: 100%; position: absolute; display: none; left: 0%; top: 0%; z-index: 99999;
                    background: rgba(192, 192, 192, 0.7);">
                    <div id="divRoute" style="border: 5px solid #A0A0A0; position: absolute; top: 10%;
                        background-color: White; left: 20%; right: 20%; width: 50%; height: 70%; -webkit-box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65);
                        -moz-box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65); box-shadow: 1px 1px 10px rgba(50, 50, 50, 0.65);
                        border-radius: 10px 10px 10px 10px;">
                        <br />
                        <br />
                        <table>
                            <tr>
                                <td>
                                    <label>
                                        Trip No</label>
                                </td>
                                <td>
                                    <span id="txtTripNo1" style="font-size: 12px; color: Red;"></span>
                                </td>
                                <td>
                                    <label>
                                        Vehicle No</label>
                                </td>
                                <td>
                                    <span id="txtVehicleNo1" style="font-size: 12px; color: Red;"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>
                                        Route Name</label>
                                </td>
                                <td>
                                    <select id="ddlRouteName" class="form-control" onchange="ddlRouteNameChange();">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="button" value="Add" id="btnAdd" onclick="btnTripAddClick();" style="display: none;"
                                        class="btn btn-success" />
                                </td>
                            </tr>
                        </table>
                        <div id="divTrip" style="height: 70%; overflow: auto;">
                        </div>
                        <table>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <input type="button" value="OK" id="btnSave" onclick="btnTripSaveClick();" class="btn btn-success"
                                        style="width: 100px;" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="divclose" style="width: 25px; top: 8.5%; right: 29%; position: absolute;
                        z-index: 99999; cursor: pointer;">
                        <img src="Images/Close.png" alt="close" />
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
