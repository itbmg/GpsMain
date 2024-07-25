<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Flt_TripDetails.aspx.cs" Inherits="Flt_TripDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
 <link rel="stylesheet" type="text/css" href="dist/css/AdminLTE.css" />
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">   
       

    <style type="text/css">
        .siz
        {
          font-size: 17px; 
          font-family: 'Trebuchet MS', arial, sans-serif;
          width:200px;
        }
    </style>
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


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width: 100%; height: 100%; font-size: 13px;">
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
        <div style="width: 100p%;">
            <table style="width: 100p%;">
             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <tr>
                    <td id="cell1" valign="top" style="border: 1px solid #d5d5d5; background-color: #f4f4f4;
                        height: 650px;">
                        <table>
                            <tr>
                                <td>                                   
                                            <table>
                                                <tr style="height: 20px;">
                                                    <td colspan="2">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 80px;">
                                                        <asp:Label ID="lblFromDate" runat="server" Text="From Date "></asp:Label>
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
                                                <tr align="right">
                                                <td colspan="2">
                                                <asp:Button ID="btn_Generate" runat="server" CssClass="ContinueButton" Style="height: 25px;
                                                width: 100px; font-size:15px; font-weight:bold;" Text="Load" OnClick="btn_Generate_Click" />
                                                </td>
                                                </tr>
                                                <tr>
                                                <td colspan="2"></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Lbl_VehicleType" runat="server">VehicleType</asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddl_VehicleType" runat="server" CssClass="siz" AutoPostBack="true" OnSelectedIndexChanged="ddl_VehicleType_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Lbl_VehicleNo" runat="server">VehicleNo</asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddl_VehicleNo" runat="server" CssClass="siz" AutoPostBack="true" OnSelectedIndexChanged="ddl_VehicleNo_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Lbl_Tripid" runat="server">TripId</asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddl_Tripid" runat="server" CssClass="siz" AutoPostBack="true" OnSelectedIndexChanged="ddl_Tripid_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>                                             
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:Label ID="Lbl_MsgInfo" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        Startdate :
                                                        <asp:Label ID="lbl_Startdate" runat="server" Text="_________" ForeColor="Red" Font-Bold="true"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        Enddate :
                                                        <asp:Label ID="lbl_Enddate" runat="server" Text="_________" ForeColor="Red" Font-Bold="true"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        Gpskms :
                                                        <asp:Label ID="lbl_Gpskms" runat="server" Text="_________" ForeColor="Red" Font-Bold="true"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        TotQty :
                                                        <asp:Label ID="lbl_Qty" runat="server" Text="_________" ForeColor="Red" Font-Bold="true"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        Route :
                                                        <asp:Label ID="lbl_RouteName" runat="server" Text="_________" ForeColor="Red" Font-Bold="true"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        Endfuel :
                                                        <asp:Label ID="lbl_Endfuelvalue" runat="server" Text="_________" ForeColor="Red"
                                                            Font-Bold="true"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        Mileage :
                                                        <asp:Label ID="lbl_mileage" runat="server" Text="_________" ForeColor="Red" Font-Bold="true"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>                                        
                                </td>
                            </tr>                            
                        </table>
                    </td>
                    <td valign="top" >
                    <table style="width:100%;">
                    <tr>
                    <td>                    
                       <div id="divPrint" style="width: 100%; float: right; padding-top:50px;">
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
                                    <div style="width: 100%; text-align:center;">
                                        <span style="font-size: 22px; font-weight: bold; color: #0252aa;">Trip Completed History of </span>
                                         <asp:Label ID="lbl_vehicleNos" runat="server" Text="" ForeColor="Red" Font-Bold="true" Font-Size="22px" ></asp:Label>
                                        <br />
                                        <br />                                        
                                    </div>
                                    <br />
                                    <div style="padding-left:300px;">
                                        <table border="1" style="width: 400px; height: 300px;">
                            <thead>
                                <tr style="color: #2f3293; font-size: 22px; font-weight: bold; text-align: center;">
                                    <th>
                                        Head
                                    </th>
                                    <th>
                                        Result
                                    </th>
                                </tr>
                            </thead>
                            <tbody>                               
                                <tr style="color: #FF00FF; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" ">TotalDistanceTravelled(Kms)</span>
                                    </td>
                                    <td>
                                         <asp:Label ID="lbl_TotalDistance" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="color: #00FFFF; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" >WorkingHours</span>
                                    </td>
                                    <td>
                                          <asp:Label ID="lbl_WorkingHours" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="color: #322B2B; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" >StationaryHours</span>
                                    </td>
                                    <td>
                                         <asp:Label ID="lbl_StationaryHours" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="color: #0000FF; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" >MaxSpeed</span>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbl_MaxSpeed" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="color: #00FF00; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" >AvgSpeed</span>
                                    </td>
                                    <td>
                                         <asp:Label ID="lbl_AvgSpeed" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="color: #FF0000; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" >IdleTime</span>
                                    </td>
                                    <td>
                                      <asp:Label ID="lbl_IdleTime" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="color: #C0C0C0; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" >No Of Stops</span>
                                    </td>
                                    <td>
                                      <asp:Label ID="lbl_NoOfStops" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="color: #FF00FF; font-size: 18px; font-weight: bold; text-align: center;">
                                    <td>
                                        <span style="cursor: pointer;" >A/C ON Time</span>
                                    </td>
                                    <td>
                                      <asp:Label ID="lbl_ACONTime" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>                                
                            </tbody>
                        </table>   
                                    </div>                     
                        </div>            
                    </td>
                    </tr> 
                    <tr>
                    <td>
                     <div style="text-align:left; padding-left:300px; display:none;"> <button type="button" class="btn btn-primary" style="margin-right: 5px;" onclick="javascript:CallPrint('divPrint');"><i class="fa fa-print"></i> Print </button></div>                  
                    </td>
                    </tr>                    
                    </table>                  
                         
                    </td>
                </tr>
                </ContentTemplate>
             </asp:UpdatePanel>
            </table>
        </div>
    </div>
</asp:Content>
