<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReportGallery.aspx.cs" Inherits="ReportGallery" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
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
        .mystyle
        {
            padding-left: 20px;
            line-height: 1.5;
            font-size: 16px;
            color: Gray;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">
        <div class="row" style="height: 500px;">
            <div class="col-md-6" style="width: 30% !important; padding-top: 20px; padding-left: 180px;">
                <table>
                    <tr valign="top">
                        <td style="padding-left: 50px; width: 500px;">
                            <div class="box" style="width: 250px; height: auto;">
                                <div class="box-header with-border " style="text-align: center; background-color: #0f74a2;
                                    color: #f4f4f4;">
                                    <h3 class="box-title">
                                        Manage Details</h3>
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body mystyle">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    1.
                                                </td>
                                                <td>
                                                    <a href="Mylocation.aspx"><i class="fa fa-sign-out">My location</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    2.
                                                </td>
                                                <td>
                                                    <a href="TripAssignedVehicleList.aspx"><i class="fa fa-sign-out">TripAssignedVehicle</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    3.
                                                </td>
                                                <td>
                                                    <a href="POI_Management.aspx"><i class="fa fa-sign-out">POI Management</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    4.
                                                </td>
                                                <td>
                                                    <a href="VehicleMaster.aspx"><i class="fa fa-sign-out">Vehicle Master</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    5.
                                                </td>
                                                <td>
                                                    <a href="ManageVehicleMaster.aspx"><i class="fa fa-sign-out">Vehicle Manage</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    6.
                                                </td>
                                                <td>
                                                    <a href="ManageLogins.aspx"><i class="fa fa-sign-out">Login Master</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    7.
                                                </td>
                                                <td>
                                                    <a href="RouteAssign.aspx"><i class="fa fa-sign-out">Route Management</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    8.
                                                </td>
                                                <td>
                                                    <a href="RouteScheduler.aspx"><i class="fa fa-sign-out">Time Scheduler</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    9.
                                                </td>
                                                <td>
                                                    <a href="EmailUser.aspx"><i class="fa fa-sign-out">User Emails</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    10.
                                                </td>
                                                <td>
                                                    <a href="TestD.aspx"><i class="fa fa-sign-out">NetSpeed</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    11.
                                                </td>
                                                <td>
                                                    <a href="GpsDeviceMasterInfo.aspx"><i class="fa fa-sign-out">Device Master</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    12.
                                                </td>
                                                <td>
                                                    <a href="Alerts.aspx"><i class="fa fa-sign-out">SMS</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    13.
                                                </td>
                                                <td>
                                                    <a href="TripAssignMent.aspx"><i class="fa fa-sign-out">Trip Assignment</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    14.
                                                </td>
                                                <td>
                                                    <a href="Edit_billingKms.aspx"><i class="fa fa-sign-out">Billing Kms</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    15.
                                                </td>
                                                <td>
                                                    <a href="Edit_actual_rate.aspx"><i class="fa fa-sign-out">Actual Kms</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    16.
                                                </td>
                                                <td>
                                                    <a href="HeadOfAccounts.aspx"><i class="fa fa-sign-out">Head Of Accounts</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    17.
                                                </td>
                                                <td>
                                                    <a href="Journel_entry.aspx"><i class="fa fa-sign-out">Journel Entry</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    18.
                                                </td>
                                                <td>
                                                    <a href="Tally_jv_report.aspx"><i class="fa fa-sign-out">Tally JV Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    19.
                                                </td>
                                                <td>
                                                    <a href="Logininfo.aspx"><i class="fa fa-sign-out">Login History Report</i></a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!-- /.box -->
                        </td>
                        <td style="padding-left: 50px; width: 500px;">
                            <div class="box" style="width: 250px; height: auto;">
                                <div class="box-header with-border" style="text-align: center; background-color: #0f74a2;
                                    color: #f4f4f4;">
                                    <h3 class="box-title">
                                        Report Details</h3>
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body mystyle">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    1.
                                                </td>
                                                <td>
                                                    <a href="LiveTracking.aspx"><i class="fa fa-sign-out">LiveTracking</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    2.
                                                </td>
                                                <td>
                                                    <a href="Flt_TripDetails.aspx"><i class="fa fa-sign-out">Fleet TripDetails</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    3.
                                                </td>
                                                <td>
                                                    <a href="ReportGallery.aspx"><i class="fa fa-sign-out">ReportGallery</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    4.
                                                </td>
                                                <td>
                                                    <a href="Reports.aspx?Report=General Report"><i class="fa fa-sign-out">General Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    5.
                                                </td>
                                                <td>
                                                    <a href="Reports.aspx?Report=OverSpeed Report"><i class="fa fa-sign-out">OverSpeed Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    6.
                                                </td>
                                                <td>
                                                    <a href="Reports.aspx?Report=Daily Report"><i class="fa fa-sign-out">Daily Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    7.
                                                </td>
                                                <td>
                                                    <a href="Reports.aspx?Report=Stopage Report"><i class="fa fa-sign-out">Stopage Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    8.
                                                </td>
                                                <td>
                                                    <a href="Rpt_Vehicleperdayroutecomparison.aspx"><i class="fa fa-sign-out">Vehicleperdayroutecomparison</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    9.
                                                </td>
                                                <td>
                                                    <a href="Reports.aspx?Report=UnAuthorized Report"><i class="fa fa-sign-out">UnAuthorized Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    10.
                                                </td>
                                                <td>
                                                    <a href="Reports.aspx?Report=Location HaltingHours Report"><i class="fa fa-sign-out">Location HaltingHours Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    11.
                                                </td>
                                                <td>
                                                    <a href="Reports.aspx?Report=Vehicle Master Report"><i class="fa fa-sign-out">Vehicle Master Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    12.
                                                </td>
                                                <td>
                                                    <a href="Reports.aspx?Report=Vehicle Manage Report"><i class="fa fa-sign-out">Vehicle Manage Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    13.
                                                </td>
                                                <td>
                                                    <a href="Reports.aspx?Report=Location To Location Report"><i class="fa fa-sign-out">Location to Location Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    14.
                                                </td>
                                                <td>
                                                    <a href="TripReport.aspx"><i class="fa fa-sign-out">Trips Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    15.
                                                </td>
                                                <td>
                                                    <a href="StatusReport.aspx"><i class="fa fa-sign-out">Status Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    16.
                                                </td>
                                                <td>
                                                    <a href="Reports.aspx?Report=Vehicle Remarks Report"><i class="fa fa-sign-out">Vehicle Remarks Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    17.
                                                </td>
                                                <td>
                                                    <a href="GenerateBills.aspx"><i class="fa fa-sign-out">Generate Bills</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    18.
                                                </td>
                                                <td>
                                                    <a href="BillingReport.aspx"><i class="fa fa-sign-out">Billing Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    19.
                                                </td>
                                                <td>
                                                    <a href="ReplayRoutes.aspx"><i class="fa fa-sign-out">Replay Routes</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    20.
                                                </td>
                                                <td>
                                                    <a href="EmptyKMSReport.aspx"><i class="fa fa-sign-out">EmptyKMS Report</i></a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!-- /.box -->
                        </td>
                        <td style="padding-left: 50px; width: 500px;">
                            <div class="box" style="width: 250px; height: auto;">
                                <div class="box-header with-border" style="text-align: center; background-color: #0f74a2;
                                    color: #f4f4f4;">
                                    <h3 class="box-title">
                                        Tools Details</h3>
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body mystyle">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    1.
                                                </td>
                                                <td>
                                                    <a href="TempratureReport.aspx"><i class="fa fa-sign-out">Temp Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    2.
                                                </td>
                                                <td>
                                                    <a href="Temp_graphical_report.aspx"><i class="fa fa-sign-out">Temp Graphical Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    3.
                                                </td>
                                                <td>
                                                    <a href="Fuelreport.aspx"><i class="fa fa-sign-out">Fuel Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    4.
                                                </td>
                                                <td>
                                                    <a href="GraphicalFuel_report.aspx"><i class="fa fa-sign-out">Fuel Graphical Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    5.
                                                </td>
                                                <td>
                                                    <a href="ShiftChange.aspx"><i class="fa fa-sign-out">Shift Change</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    6.
                                                </td>
                                                <td>
                                                    <a href="ShiftChangeReport.aspx"><i class="fa fa-sign-out">Shift Change Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    7.
                                                </td>
                                                <td>
                                                    <a href="Tools.aspx"><i class="fa fa-sign-out">Get Nearest Vehicle</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    8.
                                                </td>
                                                <td>
                                                    <a href="Notifications.aspx"><i class="fa fa-sign-out">Notifications</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    9.
                                                </td>
                                                <td>
                                                    <a href="Remindervehicle.aspx"><i class="fa fa-sign-out">Vehicle Odometer</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    10.
                                                </td>
                                                <td>
                                                    <a href="Headingto.aspx"><i class="fa fa-sign-out">Vehicles Destination</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    11.
                                                </td>
                                                <td>
                                                    <a href="Routewise_locations.aspx"><i class="fa fa-sign-out">Routewise Locations</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    12.
                                                </td>
                                                <td>
                                                    <a href="GetDirections.aspx"><i class="fa fa-sign-out">Get Direction</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    13.
                                                </td>
                                                <td>
                                                    <a href="Gpsdata_Report.aspx"><i class="fa fa-sign-out">GPS data Report</i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    14.
                                                </td>
                                                <td>
                                                    <a href="ChangePassWord.aspx"><i class="fa fa-sign-out">Change Password</i></a>
                                                </td>
                                            </tr>
                                           
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!-- /.box -->
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </section>
</asp:Content>
