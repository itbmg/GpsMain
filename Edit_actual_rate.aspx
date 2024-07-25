<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Edit_actual_rate.aspx.cs" Inherits="Edit_actual_rate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
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
    </style>
    <script type="text/javascript">
        $(function () {
            getPlantnames();
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
                Error: e
            });
        }

        function getPlantnames() {
            var data = { 'op': 'get_Plantname_details' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillPlantnames(msg);
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
        function fillPlantnames(msg) {
            var data = document.getElementById('ddlPlantName');
            var length = data.options.length;
            document.getElementById('ddlPlantName').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "select Plantname";
            opt.value = "select Plantname";
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
        function ddlPlantName_change() {
            var PlantName = document.getElementById('ddlPlantName').value;
            var data = { 'op': 'get_PlantName_change_details', 'PlantName': PlantName };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillroutenames(msg);
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
        function fillroutenames(msg) {
            var data = document.getElementById('ddlRouteName');
            var length = data.options.length;
            document.getElementById('ddlRouteName').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "select RouteName";
            opt.value = "select RouteName";
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].routename != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].routename;
                    option.value = msg[i].sno;
                    data.appendChild(option);
                }
            }
        }
        function btn_actaul_kms_rate_details_click() {
            var PlantName = document.getElementById('ddlPlantName').value;
            var RouteName = document.getElementById('ddlRouteName').value;
            var fromdate = document.getElementById('txtfromdate').value;
            var todate = document.getElementById('txttodate').value;
            var actual_kms = document.getElementById('txt_actual_kms').value;
            var rate = document.getElementById('txt_rate').value;
            if (PlantName == "") {
                alert("Please select plant name");
                return false;
            }
            if (RouteName == "") {
                alert("Please select route name");
                return false;
            }
            if (fromdate == "") {
                alert("Please select from date");
                return false;
            }
            if (todate == "") {
                alert("Please select to date");
                return false;
            }
            if (actual_kms == "") {
                alert("Please select actual kms");
                return false;
            }
            if (rate == "") {
                alert("Please select rate");
                return false;
            }
            var data = { 'op': 'btn_actaul_kms_rate_details_click', 'PlantName': PlantName, 'RouteName': RouteName, 'fromdate': fromdate, 'todate': todate, 'actual_kms': actual_kms, 'rate': rate };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        clearall();
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
        function clearall() {
            document.getElementById('ddlPlantName').selectedIndex = 0;
            document.getElementById('ddlRouteName').selectedIndex = 0;
            document.getElementById('txtfromdate').value = "";
            document.getElementById('txttodate').value = "";
            document.getElementById('txt_actual_kms').value = "";
            document.getElementById('txt_rate').value = "";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <br />
    <br />
    <br />
    <section class="content-header">
        <h1>
            Actual Details<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">Actual Details</a></li>
        </ol>
    </section>
    <br />
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Actual Details
                </h3>
            </div>
            <div class="box-body">
                <table align="center">
                    <tr>
                        <td>
                            <label>
                                From Date:</label>
                        </td>
                        <td style="height: 40px;">
                            <input type="date" id="txtfromdate" class="form-control" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                To Date:</label>
                        </td>
                        <td style="height: 40px;">
                            <input type="date" id="txttodate" class="form-control" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Plant Name:</label>
                        </td>
                        <td style="height: 40px;">
                            <select id="ddlPlantName" class="form-control" onchange="ddlPlantName_change()">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Route Name:</label>
                        </td>
                        <td style="height: 40px;">
                            <select id="ddlRouteName" class="form-control">
                            </select>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Actaul kMs</label>
                        </td>
                        <td style="height: 40px;">
                            <input type="text" id="txt_actual_kms" class="form-control" placeholder="Enter Actaul kMs" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Rate Per Km</label>
                        </td>
                        <td style="height: 40px;">
                            <input type="text" id="txt_rate" class="form-control" placeholder="Enter  Rate Per Km" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <input id="btn_save" type="button" class="btn btn-primary" name="submit" value='Update'
                                onclick="btn_actaul_kms_rate_details_click()" />
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <div id="div_billingkms">
                </div>
            </div>
        </div>
    </section>
</asp:Content>
