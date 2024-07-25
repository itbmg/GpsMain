<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Headingto.aspx.cs" Inherits="Headingto" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
    <script type="text/javascript">
        $(function () {
            getVehicledetails();
        });
        function CallHandlerUsingJson(d, s, e) {
            $.ajax({
                type: "GET",
                url: "Bus.axd?json=",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(d),
                async: true,
                cache: true,
                success: s,
                error: e
            });
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
        function getVehicledetails() {
            var data = { 'op': 'get_Vehicledetails' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillVehicledetails(msg);
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function fillVehicledetails(vehtypemsg) {
            var insurancecompany = document.getElementById('slct_vehicle_no');
            var length = insurancecompany.options.length;
            document.getElementById('slct_vehicle_no').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Vehicle No";
            opt.value = "Select Vehicle No";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            insurancecompany.appendChild(opt);
            for (var i = 0; i < vehtypemsg.length; i++) {
                if (vehtypemsg[i].VehicleID != null) {
                    var option = document.createElement('option');
                    option.innerHTML = vehtypemsg[i].VehicleID;
                    option.value = vehtypemsg[i].sno
                    insurancecompany.appendChild(option);
                }
            }
        }
        function Vehicle_destinationSaveClick() {
            var slct_vehicle_no = document.getElementById('slct_vehicle_no').value;
            var txt_Destination = document.getElementById('txt_Destination').value;
            var txt_Odometer = document.getElementById('txt_Odometer').value;
            if (slct_vehicle_no == "" || slct_vehicle_no == "Select Vehicle No") {
                alert("Please Select Vehicle No");
                return false;
            }
            if (txt_Destination == "") {
                alert("Please Enetr Destination");
                document.getElementById('txt_Destination').focus();
                return false;
            }
            if (txt_Odometer == "") {
                alert("Please Enetr Odometer");
                document.getElementById('txt_Odometer').focus();
                return false;
            }
            var data = { 'op': 'Vehicle_destinationSaveClick', 'vehicle_no': slct_vehicle_no, 'Destination': txt_Destination, 'Odometer': txt_Odometer };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert("Destination updated Successfully");
                        forclearall();
                    }
                }
                else {
                }
            };
            var e = function (x, h, e) {
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function forclearall() {
            document.getElementById('slct_vehicle_no').selectedIndex = 0;
            document.getElementById('txt_Destination').value = "";
        }
    </script>
    <br />
    <br />
    <br />
    <section class="content-header">
        <h1>
            Destination Master<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Tools</a></li>
            <li><a href="#">Destination Master</a></li>
        </ol>
    </section>
    <br />
    <br />
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Destination Details
                </h3>
            </div>
            <div class="box-body">
                <table align="center">
                    <tr>
                        <td>
                            Vehicle No
                        </td>
                        <td style="height: 40px;">
                            <select id="slct_vehicle_no" class="form-control">
                                <option selected disabled value="Select Vehicle No">Select Vehicle No</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Destination
                        </td>
                        <td style="height: 40px;">
                            <input id="txt_Destination" class="form-control" type="text" placeholder="Enter Destination" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Present Odometer
                        </td>
                        <td style="height: 40px;">
                            <input id="txt_Odometer" class="form-control" type="text" placeholder="Enter Odometer" />
                        </td>
                    </tr>
                    <tr hidden>
                        <td>
                            <label id="lbl_sno">
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="button" class="btn btn-success" name="submit" class="btn btn-primary"
                                id="btn_save" value='Save' onclick="Vehicle_destinationSaveClick()" />
                            <input id='btn_close' type="button" class="btn btn-danger" name="Close" value='Close' />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </section>
</asp:Content>
