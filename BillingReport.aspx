﻿<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/MasterPage.master" CodeFile="BillingReport.aspx.cs" Inherits="BillingReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link rel="stylesheet" type="text/css" href="dist/css/AdminLTE.css" />
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <style type="text/css">
         div#mapcontent
        {
            right: 0;
            bottom: 0;
            left: 0px;
            top: 0px;
            overflow: hidden;
            position: absolute;
        }
    </style>
     <script src="js/jquery-1.4.4.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function CallPrint(strid) {
            //            var prtContent = document.getElementById(strid);
            var divToPrint = document.getElementById(strid);
            var newWin = window.open('', 'Print-Window', 'width=400,height=400,top=100,left=100');
            newWin.document.open();
            newWin.document.write('<html><body   onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
            newWin.document.close();
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
    <script type="text/javascript">
        $(function () {
            window.history.forward(1);

        });
    </script>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

  <div style="width: 100%; height: 100%;">
        <div>
            <asp:UpdateProgress ID="updateProgress1" runat="server">
                <ProgressTemplate>
                    <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0;
                        right: 0; left: 0; z-index: 9999; background-color: #FFFFFF; opacity: 0.7;">
                        <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="thumbnails/loading.gif"
                            Style="padding: 10px; position: absolute; top: 40%; left: 40%; z-index: 99999;" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </div>
        <div style="width: 100%; height: 46px;">
            <div style="width: 150px; float: left; top: 48px; position: absolute; z-index: 99999;
                left: 15px;">
                <input type="radio" name="radio-choice" id="rblPlant" value="Plants" checked="checked" /><label
                    for="rblPlant" style="color: White;">Plants</label>
                <input type="radio" name="radio-choice" id="rblVendors" value="Vendors" /><label
                    for="rblVendors" style="color: White;">Vendors</label>
            </div>
            <div style="width: 50px; float: left; top: 47px; position: absolute; z-index: 99999;
                left: 175px;">
                <img id="btnClose" alt="" src="LiveIcons/Left01.png" title="Hide" style="height: 23px;
                    width: 25px" />
            </div>
        </div>      
        <div style="width: 100%;">
            <table>
                <tr>
                    <td id="cell" valign="top" style="border: 1px solid #d5d5d5; background-color: #f4f4f4;
                        height: 650px;">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table style="width:300px;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblreportname" runat="server" Font-Bold="true" Font-Size="14px" ForeColor="#a9a9a9"
                                                Text=""></asp:Label>
                                            <table style="width: 98%;">
                                                <tr>
                                                    <td style="width: 80px;">
                                                        <asp:Label ID="lblFromDate" runat="server" Text="Date "></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="startdate" runat="server" Width="205px"></asp:TextBox>
                                                        <asp:CalendarExtender ID="startdate_CalendarExtender" runat="server" Enabled="True"
                                                            TargetControlID="startdate" Format="dd-MM-yyyy HH:mm">
                                                        </asp:CalendarExtender>
                                                    </td>
                                                </tr>
                                                  <tr>
                                                    <td>
                                                        <asp:Label ID="lblToDate" runat="server" Text="   To Date   "></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="enddate" runat="server" Width="205px"></asp:TextBox>
                                                        <asp:CalendarExtender ID="enddate_CalendarExtender" runat="server" Enabled="True"
                                                            TargetControlID="enddate" Format="dd-MM-yyyy HH:mm">
                                                        </asp:CalendarExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>
                                                            Plant Name</label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddl_plant" CssClass="txtClass" runat="server" Width="205px" AutoPostBack="true" OnSelectedIndexChanged="ddl_plant_selectionchanged">
                                                            <asp:ListItem Value="0" Selected="True">Select Plant</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_route" runat="server" Text="Route"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddl_routes" runat="server"  Height="21px"
                                                            Width="205px">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbl_trip" runat="server" Text="Trip"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddl_trip" runat="server" AutoPostBack="True" Height="21px"
                                                            Width="205px">
                                                            <asp:ListItem>ALL</asp:ListItem>
                                                            <asp:ListItem>AM</asp:ListItem>
                                                            <asp:ListItem>PM</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <asp:HiddenField ID="hdnResultValue" Value="0" runat="server" />
                                                    <asp:Button ID="btn_generate" CssClass="ContinueButton" runat="server" Text="Generate"
                                                        Height="25px" Width="100px" OnClick="btn_generate_Click" />
                                                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/exporttoxl_utility.ashx">Export to XL</asp:HyperLink>
                                                    <br />
                                                    <asp:Label ID="lbl_nofifier" runat="server" ForeColor="Red"></asp:Label>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                    <td valign="top" style="width: 100%;">
                        <table>
                            <tr>
                                <td style="width: 100%; vertical-align: top">
                                    <asp:Panel ID="pReports" runat="server">
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <ContentTemplate>
                                                <table id="divExport" style="width: 100%;" valign="top">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lbl_ReportStatus" runat="server" Text=" "></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 100%; height: 100%;" valign="top">
                                                            <div style="top: 100px; bottom: 0px; overflow: auto;">
                                                                <asp:Panel ID="Panel3" Visible="false" runat="server" Width="100%" Height="30%">
                                             <div id="divPrint">
                                                 <table>
                                                     <td>
                                                         From Date:
                                                     </td>
                                                     <td>
                                                         <asp:Label ID="lbl_fromdate" runat="server" Text=" " ForeColor="Red" Font-Size="14px"></asp:Label>
                                                     </td>
                                                     <td style="width:30px;"></td>
                                                     <td>
                                                         To Date:
                                                     </td>
                                                     <td>
                                                         <asp:Label ID="lbl_todate" runat="server" Text=" " ForeColor="Red" Font-Size="14px"></asp:Label>
                                                     </td>
                                                     <td style="width:30px;"></td>
                                                     <td>
                                                         Route Name:
                                                     </td>
                                                     <td>
                                                         <asp:Label ID="lbl_routename" runat="server" Text=" " ForeColor="Red" Font-Size="14px"></asp:Label>
                                                     </td>
                                                 </table>
                                <br />
                                                 <asp:GridView ID="grdReports" runat="server" ForeColor="White" CssClass="gridcls"
                                    GridLines="Both" Font-Bold="true">
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="Gray" Font-Bold="False" ForeColor="White" />
                                    <HeaderStyle BackColor="#f4f4f4" Font-Bold="False" ForeColor="Black" Font-Italic="False"
                                        Font-Names="Raavi" Font-Size="Small" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#ffffff" ForeColor="#333333" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                </asp:GridView>
                                <br />
                                <br />
                                <table style="width: 100%;">
                    <tr>
                       
                        <td style="width: 30%;">
                            <span style="font-weight: bold; font-size: 14px;">Prepared By:</span>
                            <asp:Label ID="lblpreparedby" runat="server" Font-Size="Large" ForeColor="Red" Text=""></asp:Label>
                        </td>
                         <td style="width: 20%;">
                            <span style="font-weight: bold; font-size: 14px;">Authorised Signature</span>
                        </td>
                        <td style="width: 20%;">
                            <span style="font-weight: bold; font-size: 14px;">Approved By</span>
                        </td>
                    </tr>
                </table>

                                                                    </div>
                                                                    <div runat="server" id="div1">
                                                                    </div>
                                                                    <div runat="server" id="divPieChart1">
                                                                    </div>
                                                                    <asp:Label ID="Label1" runat="server" Text="Label" Style="display: none;">
                                                                    </asp:Label>
                                                                    <div runat="server" id="divPieChart">
                                                                    </div>
                                                                    <br />
                                                                      <button type="button" class="btn btn-primary" style="margin-right: 5px;" onclick="javascript:CallPrint('divPrint');"><i class="fa fa-print"></i> Print </button>
                                                                </asp:Panel>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
