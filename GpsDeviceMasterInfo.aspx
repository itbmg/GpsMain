<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="GpsDeviceMasterInfo.aspx.cs" Inherits="GpsDeviceMasterInfo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
    <script src="plugins/morris/morris.js" type="text/javascript"></script>
    <!-- Theme style -->
    <link rel="stylesheet" type="text/css" href="dist/css/AdminLTE.css" />
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css" />
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/iCheck/flat/blue.css" />
    <!-- Morris chart -->
    <link rel="stylesheet" href="plugins/morris/morris.css" />
    <!-- jvectormap -->
    <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css" />
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css" />
    <!-- Daterange picker -->
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker-bs3.css" />
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />
    <script src="JSF/jquery.min.js"></script>
    <script src="JSF/jquery-ui.js" type="text/javascript"></script>
    <script src="JSF/jquery.blockUI.js" type="text/javascript"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <script src="JSF/jquery.blockUI.js" type="text/javascript"></script>
    <link href="css/custom.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            get_mainuser();
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

        function IsMobileNumber(txt_phoneno) {
            var mob = /^[1-9]{1}[0-9]{9}$/;
            var txtMobile = document.getElementById(txt_phoneno);
            if (mob.test(txtMobile.value) == false) {
                alert("Please enter valid mobile number.");
                txtMobile.focus();
                return false;
            }
            return true;
        }

        function get_mainuser() {
            var data = { 'op': 'show_mainuser_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillmainuserdetails(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            callHandler(data, s, e);
        }

        function fillmainuserdetails(msg) {
            var data = document.getElementById('slct_mainuser');
            var length = data.options.length;
            document.getElementById('slct_mainuser').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select mainuser";
            opt.value = "Select mainuser";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].sno != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].drivername;
                    option.value = msg[i].drivername;
                    data.appendChild(option);
                }
            }
        }


        function get_GpsdeviceInfo() {
            var mainuser = document.getElementById('slct_mainuser').value;
        var data = { 'op': 'get_GpsdeviceInfo', 'mainuser': mainuser };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillgpsdetails(msg);
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

        function fillgpsdetails(msg) {
            var result = '<div style="overflow:fixed;"><table class="table table-bordered table-hover dataTable no-footer">';
            result += '<thead><tr><th scope="col"></th><th scope="col">VehicleNo</th><th scope="col">DeviceId</th><th scope="col">DeviveType</th><th scope="col">PhoneNo</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                result += '<tr><td><input id="btn_poplate" type="button"  onclick="getme(this)" name="submit" class="btn btn-primary" value="Edit" /></td>';
                result += '<th scope="row" class="1" style="text-align:center;">' + msg[i].VehicleNumber + '</th>';
                result += '<td data-title="code" class="2">' + msg[i].GprsDevID + '</td>';
                result += '<td data-title="code" class="3">' + msg[i].DeviceType + '</td>';
                result += '<td data-title="code" class="4">' + msg[i].phonenumber + '</td>';
                result += '<td style="display:none" class="10">' + msg[i].sno + '</td></tr>';
            }
            result += '</table></div>'
            $('#div_vehicledata').html(result);
        }


        function getme(thisid) {
            var mainuser = document.getElementById('slct_mainuser').value;              
            var vehicleno = $(thisid).parent().parent().children('.1').html();
            var deviceno = $(thisid).parent().parent().children('.2').html();
            var devicetype = $(thisid).parent().parent().children('.3').html();
            var phoneno = $(thisid).parent().parent().children('.4').html();
            var sno = $(thisid).parent().parent().children('.10').html();

            document.getElementById('txt_vehicle_no').value = vehicleno;
            document.getElementById('txt_deviceid').value = deviceno;
            document.getElementById('txt_devicetype').value = devicetype;
            document.getElementById('txt_phoneno').value = phoneno;
            document.getElementById('lbl_sno').value = sno;
        }



        function UpdateGpsdeviceMasterInfo() {
            var mainuser = document.getElementById('slct_mainuser').value;
            var vehicleno = document.getElementById('txt_vehicle_no').value;
            var deviceno = document.getElementById('txt_deviceid').value;
            var devicetype = document.getElementById('txt_devicetype').value;
            var phoneno = document.getElementById('txt_phoneno').value;
            var sno = document.getElementById('lbl_sno').value;

            if (phoneno == "") {
                alert("Please fill the PhoneNumber...");
                return false;
            }


            var data = { 'op': 'Update_GpsDevice_Paired', 'mainuser': mainuser, 'phoneno': phoneno, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        get_GpsdeviceInfo();
                        $('#div_vehicledata').show();
                        Clear();
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

        function Clear() {
            document.getElementById('txt_vehicle_no').value = "";
            document.getElementById('txt_deviceid').value = "";
            document.getElementById('txt_devicetype').value = "";
            document.getElementById('txt_phoneno').value = "";
            document.getElementById('lbl_sno').innerHTML = "";
        }

    </script>
    <section class="content-header">
        <h1>
            GpsDevice MasterInfo<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Manage</a></li>
            <li><a href="#">GpsDevice MasterInfo</a></li>
        </ol>
    </section>
     <section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary">
                <div class="box-header">
                    <table class="inputstable" align="center">
                        <tr>
                            <td style="height: 40px;">
                                Main User Name
                            </td>
                            <td>
                                <select class="form-control" id="slct_mainuser" placeholder="Main user" onchange="get_GpsdeviceInfo()">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 40px;">
                                Vehicle ID
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txt_vehicle_no" placeholder="Vehicleno" />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 40px;">
                                GPS DeviceID
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txt_deviceid" placeholder="Deviceid" />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 40px;">
                                Device Type
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txt_devicetype" placeholder="Devicetype" />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 40px;">
                                Phone Number
                            </td>
                            <td>
                                <input type="text" class="form-control" id="txt_phoneno" placeholder="Phoneno" onblur="return IsMobileNumber(txt_phoneno)" />
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td>
                                <label id="lbl_sno">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 40px;">
                            </td>
                            <td>
                                <input type="button" class="btn btn-success" id="btn_Update" name="submit" value="Update" onclick="UpdateGpsdeviceMasterInfo()" />
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
