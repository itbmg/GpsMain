<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Vehiclemaster.aspx.cs" Inherits="Vehiclemaster1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
    <script type="text/javascript">
        $(function () {
            show_vehicleno_details();
            show_Plantname_details();
            ddlvehcletype();
            show_route_details();
            show_Vehiclemake_details();
            show_vehiclemodel_details();
            get_vehicle_master();
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
            d = d.replace(/&/g, '\uFF06');
            d = d.replace(/#/g, '\uFF03');
            d = d.replace(/\+/g, '\uFF0B');
            d = d.replace(/\=/g, '\uFF1D');
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
        function IsMobileNumber(txt_phnno) {
            var mob = /^[1-9]{1}[0-9]{9}$/;
            var txtMobile = document.getElementById(txt_phnno);
            if (mob.test(txtMobile.value) == false) {
                alert("Please enter valid mobile number.");
                txtMobile.focus();
                return false;
            }
            return true;
        }
        function save_vehicle_master() {
            var vehicleno = document.getElementById('slct_vehicle_no').value;
            var vehicletype = document.getElementById('ddlVehicleType').value;
            var drivername = document.getElementById('txt_dname').value;
            var plantname = document.getElementById('ddlPlantName').value;
            var Phonenumber = document.getElementById('txt_phnno').value;
            var vehiclemake = document.getElementById('ddlvehmake').value;
            var companyid = document.getElementById('txt_cid').value;
            var vehiclemodel = document.getElementById('slct_vmodel').value;
            var address = document.getElementById('txt_address').value;
            var capacity = document.getElementById('txt_capacity').value;
            var scheduledroute = document.getElementById('ddlRouteName').value;
            var routename = document.getElementById('txt_rname').value;
            var status = document.getElementById('slct_status').value;
            var btnval = document.getElementById('btn_save').value;
            var sno = document.getElementById('lbl_sno').value;
            var data = { 'op': 'save_vehicle_master', 'vehicleno': vehicleno, 'vehicletype': vehicletype, 'drivername': drivername, 'plantname': plantname, 'Phonenumber': Phonenumber, 'vehiclemake': vehiclemake, 'companyid': companyid, 'vehiclemodel': vehiclemodel, 'address': address, 'capacity': capacity, 'scheduledroute': scheduledroute, 'routename': routename, 'status': status, 'btnVal': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        get_vehicle_master();
                        $('#div_vehicledata').show();
                        reset_vehicle();
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


        function show_vehicleno_details() {
            var data = { 'op': 'show_vehicleno_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        filldetails(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            callHandler(data, s, e);
        }
        function filldetails(msg) {
            var data = document.getElementById('slct_vehicle_no');
            var length = data.options.length;
            document.getElementById('slct_vehicle_no').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select vehicle no";
            opt.value = "Select vehicle no";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].VehicleNo != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].VehicleNo;
                    option.value = msg[i].VehicleNo;
                    data.appendChild(option);
                }
            }
        }

        function ddlvehcletype() {
            var data = { 'op': 'show_Vehcletype_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillvehicletypedetails(msg);
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
        function fillvehicletypedetails(msg) {
            var data = document.getElementById('ddlVehicleType');
            var length = data.options.length;
            document.getElementById('ddlVehicleType').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select vehicle type";
            opt.value = "Select vehicle type";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].ItemName != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].ItemName;
                    option.value = msg[i].ItemName;
                    data.appendChild(option);
                }
            }
        }

        var fillroutedetails1 = [];
        function show_route_details() {
            var data = { 'op': 'show_route_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillroutedetails1 = msg;
                        fillroutedetails();
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

        function fillroutedetails() {
            fillroutedetails1;
            var data = document.getElementById('ddlRouteName');
            var length = data.options.length;
            document.getElementById('ddlRouteName').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Route Name";
            opt.value = "Select Route Name";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < fillroutedetails1.length; i++) {
                if (fillroutedetails1[i].ItemCode != null) {
                    var option = document.createElement('option');
                    option.innerHTML = fillroutedetails1[i].ItemCode;
                    option.value = fillroutedetails1[i].ItemCode;
                    data.appendChild(option);
                }
                ddlroutechange(ddlRouteName);
            }
        }
        function ddlroutechange(ddlRouteName) {
            var sqty = document.getElementById('ddlRouteName').value;
            for (var i = 0; i < fillroutedetails1.length; i++) {
                if (sqty == fillroutedetails1[i].ItemCode) {
                    document.getElementById('txt_rname').value = fillroutedetails1[i].ItemName;
                }
            }
        }

        function show_Plantname_details() {
            var data = { 'op': 'show_Plantname_details' };
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
                    option.value = msg[i].plantname;
                    data.appendChild(option);
                }
            }
        }
        function show_Vehiclemake_details() {
            var data = { 'op': 'show_Vehiclemake_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillvehiclemakedetails(msg);
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
        function fillvehiclemakedetails(msg) {
            var data = document.getElementById('ddlvehmake');
            var length = data.options.length;
            document.getElementById('ddlvehmake').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select vehicle type";
            opt.value = "Select vehicle type";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].ItemCode != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].ItemCode;
                    option.value = msg[i].ItemCode;
                    data.appendChild(option);
                }
            }
        }
        function show_vehiclemodel_details() {
            var data = { 'op': 'show_vehiclemodel_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillvehiclemodeldetails(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            callHandler(data, s, e);
        }
        function fillvehiclemodeldetails(msg) {
            var data = document.getElementById('slct_vmodel');
            var length = data.options.length;
            document.getElementById('slct_vmodel').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select vehicle model";
            opt.value = "Select vehicle model";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].ItemName != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].ItemName;
                    option.value = msg[i].ItemName;
                    data.appendChild(option);
                }
            }
        }

        function get_vehicle_master() {
            var data = { 'op': 'get_vehicle_master' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillvehdetails(msg);
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
        function fillvehdetails(msg) {
            var results = '<div  style="overflow:fixed;"><table class="table table-bordered table-hover dataTable no-footer">';
            results += '<thead><tr><th scope="col"></th><th scope="col">VehicleNo</th><th scope="col">VehicleType</th><th scope="col">DriverName</th><th scope="col">PlantName</th><th scope="col">PhoneNumber</th><th scope="col">VehicleMake</th><th scope="col">CompanyID</th><th scope="col">VehicleModel</th><th scope="col">Address</th><th scope="col">Capacity</th><th scope="col">ScheduledRoute</th><th scope="col">RouteName</th><th scope="col">Status</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr><td><input id="btn_poplate" type="button"  onclick="getme(this)" name="submit" class="btn btn-primary" value="Edit" /></td>';
                results += '<th scope="row" class="1" style="text-align:center;">' + msg[i].vehicleno + '</th>';
                results += '<td data-title="code" class="2">' + msg[i].vehicletype + '</td>';
                results += '<td data-title="code" class="3">' + msg[i].drivername + '</td>';
                results += '<td data-title="code" class="4">' + msg[i].plantname + '</td>';
                results += '<td data-title="code" class="5">' + msg[i].Phonenumber + '</td>';
                results += '<td data-title="code" class="6">' + msg[i].vehiclemake + '</td>';
                results += '<td data-title="code" class="7">' + msg[i].companyid + '</td>';
                results += '<td data-title="code" class="8">' + msg[i].vehiclemodel + '</td>';
                results += '<td data-title="code" class="9">' + msg[i].address + '</td>';
                results += '<td data-title="code" class="10">' + msg[i].capacity + '</td>';
                results += '<td data-title="code" class="11">' + msg[i].scheduledroute + '</td>';
                results += '<td data-title="code" class="12">' + msg[i].routename + '</td>';
                results += '<td data-title="code" class="22">' + msg[i].status + '</td>';
                results += '<td style="display:none" class="23">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#div_vehicledata").html(results);
        }
        function getme(thisid) {
            var vehicleno = $(thisid).parent().parent().children('.1').html();
            var vehicletype = $(thisid).parent().parent().children('.2').html();
            var drivername = $(thisid).parent().parent().children('.3').html();
            var plantname = $(thisid).parent().parent().children('.4').html();
            var Phonenumber = $(thisid).parent().parent().children('.5').html();
            var vehiclemake = $(thisid).parent().parent().children('.6').html();
            var companyid = $(thisid).parent().parent().children('.7').html();
            var vehiclemodel = $(thisid).parent().parent().children('.8').html();
            var address = $(thisid).parent().parent().children('.9').html();
            var capacity = $(thisid).parent().parent().children('.10').html();
            var scheduledroute = $(thisid).parent().parent().children('.11').html();
            var routename = $(thisid).parent().parent().children('.12').html();
            var status = $(thisid).parent().parent().children('.22').html();
            var sno = $(thisid).parent().parent().children('.23').html();


            document.getElementById('slct_vehicle_no').value = vehicleno;
            document.getElementById('ddlVehicleType').value = vehicletype;
            document.getElementById('txt_dname').value = drivername;
            document.getElementById('ddlPlantName').value = plantname;
            document.getElementById('txt_phnno').value = Phonenumber;
            document.getElementById('ddlvehmake').selectedIndex = vehiclemake;
            document.getElementById('txt_cid').value = companyid;
            document.getElementById('slct_vmodel').selectedIndex = vehiclemodel;
            document.getElementById('txt_address').value = address;
            document.getElementById('txt_capacity').value = capacity;
            document.getElementById('ddlRouteName').value = routename;
            document.getElementById('txt_rname').value = scheduledroute;
            document.getElementById('slct_status').value = status;
            document.getElementById('btn_save').value = "Modify";
            document.getElementById('lbl_sno').value = sno;
        }
        function reset_vehicle() {
            document.getElementById('slct_vehicle_no').selectedIndex = 0;
            document.getElementById('ddlVehicleType').selectedIndex = 0;
            document.getElementById('txt_dname').value = "";
            document.getElementById('ddlPlantName').selectedIndex = 0;
            document.getElementById('txt_phnno').value = "";
            document.getElementById('ddlvehmake').selectedIndex = 0;
            document.getElementById('txt_cid').value = "";
            document.getElementById('slct_vmodel').selectedIndex = 0;
            document.getElementById('txt_address').value = "";
            document.getElementById('txt_capacity').value = "";
            document.getElementById('ddlRouteName').selectedIndex = 0;
            document.getElementById('txt_rname').value = "";
            document.getElementById('slct_status').selectedIndex = 0;
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('btn_save').value = "Add";
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("select").searchable({
                maxListSize: 200, // if list size are less than maxListSize, show them all
                maxMultiMatch: 300, // how many matching entries should be displayed
                exactMatch: false, // Exact matching on search
                wildcards: true, // Support for wildcard characters (*, ?)
                ignoreCase: true, // Ignore case sensitivity
                latency: 200, // how many millis to wait until starting search
                warnMultiMatch: 'top {0} matches ...',
                warnNoMatch: 'no matches ...',
                zIndex: 'auto'
            });
        });
 </script>
    </br> </br> </br>
    <section class="content-header">
        <h1>
            Vehicle Master<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Manage</a></li>
            <li><a href="#">Vehicle Master</a></li>
        </ol>
    </section>
    <section class="content">
       <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header">
            <table id="tbl_vehicle" class="inputstable" align="center">
                <tr>
                    <td style="height: 40px;">
                        Vehicle No
                    </td>
                    <td>
                        <select class="form-control" id="slct_vehicle_no" placeholder="select vehicleno">
                        </select>
                    </td>
                    <td style="height: 40px;">
                        Vehicle Type
                    </td>
                    <td>
                        <select class="form-control" id="ddlVehicleType" placeholder="select vehicletype" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 40px;">
                        Phone Number <span style="color: red;">*</span>
                    </td>
                    <td>
                        <input type="text" id="txt_phnno" class="form-control" placeholder="Enter Phoneno"
                            onblur="return IsMobileNumber(txt_phnno)" />
                    </td>
                    <td>
                        Plant Name <span style="color: red;">*</span>
                    </td>
                    <td>
                        <select class="form-control" id="ddlPlantName" placeholder="select plantname" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 40px;">
                        Company ID
                    </td>
                    <td>
                        <input type="text" id="txt_cid" class="form-control" placeholder="Enter companyid">
                    </td>
                    <td>
                        Vehicle Make <span style="color: red;">*</span>
                    </td>
                    <td>
                        <select class="form-control" id="ddlvehmake" placeholder="select vehiclemake" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 40px;">
                        Address <span style="color: red;">*</span>
                    </td>
                    <td>
                        <textarea cols="20" rows="3" id="txt_address" placeholder="Enter Address" class="form-control"></textarea>
                    </td>
                    <td>
                        Vehicle Model<span style="color: red;">*</span>
                    </td>
                    <td>
                        <select class="form-control" id="slct_vmodel" placeholder="select Vehicle">
                        </select>
                    </td>
                </tr>
                <tr>
                     <td style="height: 40px;">
                        Scheduled Route
                    </td>
                    <td>
                        <select class="form-control" id="ddlRouteName" placeholder="select Route" onchange="ddlroutechange(this);">
                        </select>
                    </td>
                    <td style="height: 40px;">
                        Capacity
                    </td>
                    <td>
                        <input type="text" id="txt_capacity" class="form-control" placeholder="Enter capacity">
                    </td>
                </tr>
                <tr>
                    <td style="height: 40px;">
                        Status
                    </td>
                    <td>
                        <select class="form-control" id="slct_status" placeholder="select">
                            <option value="1">Enable</option>
                            <option value="0">Disable</option>
                        </select>
                    </td>
                    <td style="height: 40px;">
                        Route Name
                    </td>
                    <td>
                      <input type="text" id="txt_rname" class="form-control" readonly placeholder="Enter Routename">
                       <%-- <span id="txt_rname" class="form-control" readonly placeholder="Enter Routename">--%>
                    </td>
                </tr>
                <tr style="display:none;">
                     <td style="height: 40px;">
                        Driver Name <span style="color: red;">*</span>
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txt_dname" value="Driver"  />
                    </td>

                </tr>
                <tr style="display: none;">
                    <td>
                        <label id="lbl_sno">
                        </label>
                    </td>
                </tr>
                <tr style="height: 10px;">
                </tr>
                <tr>
                    <td>
                    </td>
                    <td style="height: 40px;">
                        <input id="btn_save" type="button" class="btn btn-success" name="submit" value="Add"
                            onclick="save_vehicle_master();">
                        <input id="btn_reset" type="button" class="btn btn-warning" name="submit" value="Reset"
                            onclick="reset_vehicle();">
                        <%--<input id="btn_cancel" type="button" class="btn btn-danger" name="submit" value="Delete"
                            onclick="Delete_vehicle();" >--%>
                    </td>
                </tr>
            </table>
            <div id="div_vehicledata" style="width: 100%; height: 400px; overflow: auto;">
            </div>
        </div>
        </div>
        </div>
        </div>
        
    </section>
</asp:Content>
