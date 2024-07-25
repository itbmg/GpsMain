<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ViewShiftChange.aspx.cs" Inherits="ViewShiftChange" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        function CallPrint(strid) {
            var divToPrint = document.getElementById(strid);
            var newWin = window.open('', 'Print-Window', 'width=400,height=400,top=100,left=100');
            newWin.document.open();
            newWin.document.write('<html><body   onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
            newWin.document.close();
        }
        
    </script>
    <div id="second_div" style="background: #ffffff; padding: 20px;">
        <div class="tab-content">
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
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table id="tbltrip">
                        <tr>
                            <td>
                                <asp:Label ID="lbl_tripid" runat="server">Emp No:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmpID" runat="server" CssClass="txtsize"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="Label1" runat="server">Date:</asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label5" runat="server" Text="Label">To Date</asp:Label>&nbsp;
                                <asp:TextBox ID="dtp_Todate" runat="server" CssClass="txtClass">
                                </asp:TextBox>
                                <asp:CalendarExtender ID="enddate_CalendarExtender2" runat="server" Enabled="True"
                                    TargetControlID="dtp_Todate" Format="dd-MM-yyyy HH:mm">
                                </asp:CalendarExtender>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnGenerate" runat="server" CssClass="ContinueButton" OnClick="btnGenerate_Click"
                                    Text="Generate" Style="height: 25px;
                    width: 120px;font-size:12px;"/>
                            </td>
                            <td>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/exporttoxl.aspx">Export to XL</asp:HyperLink>
                            </td>
                        </tr>
                    </table>
                    <div id="divPrint">
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
                                <div style="width: 100%;">
                                    <span style="font-size: 18px; font-weight: bold; color: #0252aa;">Shift Change Report</span><br />
                                    <div>
                                    </div>
                                </div>
                            </div>
                            <div>
                            </div>
                        </div>
                        <table style="width: 80%">
                            <tr>
                                <td>
                                    Date
                                </td>
                                <td>
                                    <asp:Label ID="lblDate" runat="server" Text="" ForeColor="Red"></asp:Label>
                                </td>
                                <td>
                                    Operated By
                                </td>
                                <td>
                                    <asp:Label ID="lblName" runat="server" Text="" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <asp:GridView ID="grdReports" runat="server" CellPadding="5" CellSpacing="5" CssClass="gridcls"
                            ForeColor="White" GridLines="Both"  Font-Size="Small">
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="Gray" Font-Bold="False" ForeColor="White" />
                            <HeaderStyle BackColor="#f4f4f4" Font-Bold="true" Font-Italic="False" Font-Names="Raavi"
                                Font-Size="13px" ForeColor="Black" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#ffffff" ForeColor="#333333" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        </asp:GridView>
                        <br />
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 25%;">
                                    <span style="font-weight: bold; font-size: 12px;">PREPARED BY</span>
                                </td>
                                <td style="width: 25%;">
                                    <span style="font-weight: bold; font-size: 12px;">INCHARGE SIGNATURE</span>
                                </td>
                                <td style="width: 25%;">
                                    <span style="font-weight: bold; font-size: 12px;">MANAGER SIGNATURE</span>
                                </td>
                                <td style="width: 25%;">
                                    <span style="font-weight: bold; font-size: 12px;">AUTHORISED SIGNATURE</span>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <asp:Label ID="lblmsg" runat="server" Text="" ForeColor="Red" Font-Size="20px"></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <br />
            <asp:Button ID="btnPrint" runat="Server" CssClass="ContinueButton" Style="height: 25px;
                    width: 120px;font-size:12px;"  OnClientClick="javascript:CallPrint('divPrint');"
                Text="Print" />
        </div>
    </div>
</asp:Content>
