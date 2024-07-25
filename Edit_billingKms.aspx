<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Edit_billingKms.aspx.cs" Inherits="Edit_billingKms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
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
    </style>
    <script src="js/jquery.blockUI.js" type="text/javascript"></script>
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
        function btn_getbilling_kms_details_click() {
            var PlantName = document.getElementById('ddlPlantName').value;
            var RouteName = document.getElementById('ddlRouteName').value;
            var session = document.getElementById('ddlsession').value;
            var fromdate = document.getElementById('txtfromdate').value;
            var todate = document.getElementById('txttodate').value;
            var data = { 'op': 'get_distancelocations_billingkms', 'PlantName': PlantName, 'RouteName': RouteName, 'session': session, 'fromdate': fromdate, 'todate': todate };
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
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function filldetails(msg) {
            var results = '<div  style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
            results += '<thead><tr><th scope="col"></th><th scope="col">TripTime</th><th scope="col">Tripname</th><th scope="col">ActualKMs</th><th scope="col">GPSKMs</th><th scope="col">BillingKMs</th><th scope="col">ChargePerKM</th><th scope="col">Remarks</th><th scope="col"></th></tr></thead></tbody>';
            var j = 1;
            for (var i = 0; i < msg.length; i++) {
                results += '<tr><td scope="row" class="1" style="text-align:center;" id="txtsno">' + j + '</td>';
                results += '<td ><input id="txtProductname" readonly   class="productcls" style="width:90px;" value="' + msg[i].TripTime + '"/></td>';
                results += '<td  class="route">' + msg[i].RouteName + '</td>';
                results += '<td ><input id="txt_ActualKMs" type="text" class="1"  onkeypress="return isFloat(event)" style="width:90px;border:1px solid gray;" value="' + msg[i].ActualKMs + '"/></td>';
                results += '<td ><input id="txt_GPSKMs" type="text" class="2"  onkeypress="return isFloat(event)" style="width:90px;border:1px solid gray;" value="' + msg[i].GPSKMs + '"/></td>';
                results += '<td ><input id="txt_BillingKMs" type="text"  class="3"  onkeypress="return isFloat(event)" style="width:90px;border:1px solid gray;" value="' + msg[i].BillingKMs + '"/></td>';
                results += '<td ><input id="txt_ChargePerKM" type="text"  class="4"  onkeypress="return isFloat(event)" style="width:90px;border:1px solid gray;" value="' + msg[i].ChargePerKM + '"/></td>';
                results += '<td ><input id="txt_Remarks" type="text"  class="5"  onkeypress="return isFloat(event)" style="width:90px;border:1px solid gray;" value="' + msg[i].Remarks + '"/></td>';
                results += '<td style="display:none;"><input id="txt_refno" type="text"  class="6"  onkeypress="return isFloat(event)" style="width:90px;" value="' + msg[i].refno + '"/></td>';
                results += '<td data-title="Minus"><input id="btn_poplate" type="button"  onclick="getme(this)" name="Edit" class="btn btn-primary" value="Save" /></td></tr>';
                j++;
            }
            results += '</table></div>';
            $("#div_billingkms").html(results);
        }
        function getme(thisid) {
            var ActualKMs = $(thisid).closest("tr").find('#txt_ActualKMs').val();
            var GPSKMs = $(thisid).closest("tr").find('#txt_GPSKMs').val();
            var BillingKMs = $(thisid).closest("tr").find('#txt_BillingKMs').val();
            var ChargePerKM = $(thisid).closest("tr").find('#txt_ChargePerKM').val();
            var Remarks = $(thisid).closest("tr").find('#txt_Remarks').val();
            var refno = $(thisid).closest("tr").find('#txt_refno').val();
            var data = { 'op': 'save_distancelocations_billingkms_click', 'ActualKMs': ActualKMs, 'GPSKMs': GPSKMs, 'BillingKMs': BillingKMs, 'ChargePerKM': ChargePerKM, 'Remarks': Remarks, 'refno': refno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
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
    </script>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <br />
    <br />
    <br />
    <section class="content-header">
        <h1>
            Billing Details<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">Billing Details</a></li>
        </ol>
    </section>
    <br />
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Billing Details
                </h3>
            </div>
            <div class="box-body">
                <table>
                    <tr>
                        <td>
                            <label>
                                From Date:</label>
                        </td>
                        <td>
                            <input type="date" id="txtfromdate" class="form-control" />
                        </td>
                        <td>
                            <label>
                                To Date:</label>
                        </td>
                        <td>
                            <input type="date" id="txttodate" class="form-control" />
                        </td>
                        <td style="width: 5px;">
                        </td>
                        <td>
                            <select id="ddlPlantName" class="form-control" onchange="ddlPlantName_change()">
                            </select>
                        </td>
                        <td style="width: 5px;">
                        </td>
                        <td>
                            <select id="ddlRouteName" class="form-control">
                            </select>
                        </td>
                        <td style="width: 5px;">
                        </td>
                        <td>
                            <select id="ddlsession" class="form-control">
                                <option>All</option>
                                <option>AM</option>
                                <option>PM</option>
                            </select>
                        </td>
                        <td style="width: 5px;">
                        </td>
                        <td>
                            <input id="btn_save" type="button" class="btn btn-primary" name="submit" value='Get Details'
                                onclick="btn_getbilling_kms_details_click()" />
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
