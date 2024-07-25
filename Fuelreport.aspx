<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Fuelreport.aspx.cs" Inherits="Fuelreport" %>

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
    <br />
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
    <br />
    <br />
    <br />
    <div>
        <section class="content-header">
            <h1>
                Fuel Report<small>Preview</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i>Tools</a></li>
                <li><a href="#">Fuel Report</a></li>
            </ol>
        </section>
        <br />
        <section class="content">
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">
                        <i style="padding-right: 5px;" class="fa fa-cog"></i>Fuel Report Details
                    </h3>
                </div>
                <div class="box-body">
                    <asp:UpdateProgress ID="updateProgress1" runat="server">
                        <ProgressTemplate>
                            <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0;
                                right: 0; left: 0; z-index: 9999999; background-color: #FFFFFF; opacity: 0.7;">
                                <br />
                                <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="thumbnails/loading.gif"
                                    AlternateText="Loading ..." ToolTip="Loading ..." Style="padding: 10px; position: absolute;
                                    top: 35%; left: 40%;" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <asp:UpdatePanel ID="updPanel" runat="server">
                        <ContentTemplate>
                            <div align="center">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" Text="Label">From Date</asp:Label>&nbsp;
                                            <asp:TextBox ID="dtp_FromDate" runat="server" CssClass="form-control"></asp:TextBox>
                                            <asp:CalendarExtender ID="enddate_CalendarExtender" runat="server" Enabled="True"
                                                TargetControlID="dtp_FromDate" Format="dd-MM-yyyy HH:mm">
                                            </asp:CalendarExtender>
                                        </td>
                                        <td style="width: 6px;">
                                        </td>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" Text="Label">To Date</asp:Label>&nbsp;
                                            <asp:TextBox ID="dtp_Todate" runat="server" CssClass="form-control">
                                            </asp:TextBox>
                                            <asp:CalendarExtender ID="enddate_CalendarExtender2" runat="server" Enabled="True"
                                                TargetControlID="dtp_Todate" Format="dd-MM-yyyy HH:mm">
                                            </asp:CalendarExtender>
                                        </td>
                                        <td style="width: 6px;">
                                        </td>
                                        <td>
                                            <asp:Button ID="Button2" runat="server" Text="GENERATE" CssClass="btn btn-success"
                                                OnClick="btn_Generate_Click" /><br />
                                        </td>
                                        <td>
                                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/exporttoxl.aspx">Export to XL</asp:HyperLink>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="hidePanel" runat="server" Visible="false">
                                    <div style="width: 100%;">
                                        <div style="width: 13%; float: left;">
                                            <img src="Images/Vyshnavilogo.png" alt="Vyshnavi" width="120px" height="82px" />
                                        </div>
                                        <div style="width: 86%; float: right; text-align: center;">
                                            <asp:Label ID="lblTitle" runat="server" Font-Bold="true" Font-Size="20px" ForeColor="#0252aa"
                                                Text=""></asp:Label>
                                            <br />
                                            <asp:Label ID="lblAddress" runat="server" Font-Bold="true" Font-Size="12px" ForeColor="#0252aa"
                                                Text=""></asp:Label>
                                            <br />
                                        </div>
                                        <div style="width: 100%; padding-left: 18%;">
                                            <span style="font-size: 18px; font-weight: bold; color: #0252aa;">Fuel Report</span><br />
                                            <div>
                                                <asp:Label ID="Lbl_Totdistance" runat="server" Text=""></asp:Label>
                                                <asp:Label ID="Lbl_TotFuel" runat="server" Text=""></asp:Label>
                                                <asp:Label ID="Lbl_minspeed" runat="server" Text=""></asp:Label>
                                                <asp:Label ID="Lbl_maxspeed" runat="server" Text=""></asp:Label>
                                                <asp:Label ID="Lbl_TripStarttime" runat="server" Text=""></asp:Label>
                                                <asp:Label ID="Lbl_TripEndtime" runat="server" Text=""></asp:Label>
                                                <asp:Label ID="Lbl_TotalTripinfo" runat="server" Text=""></asp:Label>
                                            </div>
                                        </div>
                                        <div>
                                            <asp:GridView ID="dataGridView1" runat="server" ForeColor="White" Width="100%" CssClass="EU_DataTable"
                                                GridLines="Both" Font-Bold="true">
                                                <EditRowStyle BackColor="#999999" />
                                                <FooterStyle BackColor="Gray" Font-Bold="False" ForeColor="White" />
                                                <HeaderStyle BackColor="#f4f4f4" Font-Bold="False" ForeColor="Black" Font-Italic="False"
                                                    Font-Names="Raavi" Font-Size="Small" />
                                                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                <RowStyle BackColor="#ffffff" ForeColor="#333333" HorizontalAlign="Center" />
                                                <AlternatingRowStyle HorizontalAlign="Center" />
                                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                            </asp:GridView>
                                        </div>
                                        <asp:Label ID="lblmsg" runat="server" Text="" ForeColor="Red" Font-Size="20px"></asp:Label>
                                    </div>
                                </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
