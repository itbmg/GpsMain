<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ShiftChangeReport.aspx.cs" Inherits="ShiftChangeReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<style type="text/css">
</style>
<asp:UpdateProgress ID="updateProgress1" runat="server">
                <ProgressTemplate>
                    <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0;
                        right: 0; left: 0; z-index: 9999999; background-color: #FFFFFF; opacity: 0.7;">
                        <br />
                        <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="thumbnails/loading.gif" AlternateText="Loading ..."
                            ToolTip="Loading ..." Style="padding: 10px; position: absolute; top: 35%; left: 40%;" />
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
                            <asp:TextBox ID="dtp_FromDate" runat="server" CssClass="txtClass"></asp:TextBox>
                            <asp:CalendarExtender ID="enddate_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="dtp_FromDate" Format="dd-MM-yyyy HH:mm">
                            </asp:CalendarExtender>
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
                            <asp:Button ID="Button2" runat="server" Text="GENERATE" CssClass="ContinueButton" OnClick="btn_Generate_Click" /><br />
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
                    <div style="width: 100%;padding-left:18%;">
                            <span style="font-size: 18px; font-weight: bold; color: #0252aa;">
                            Shift Change Report</span><br />
                            <div>
                            </div>
                        </div>
                <div>
                    <asp:GridView ID="dataGridView1" runat="server" ForeColor="White" Width="100%" CssClass="EU_DataTable"
                        GridLines="Both" Font-Bold="true" OnRowCommand="grdReports_RowCommand">
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="Gray" Font-Bold="False" ForeColor="White" />
                        <HeaderStyle BackColor="#f4f4f4" Font-Bold="False" ForeColor="Black" Font-Italic="False"
                            Font-Names="Raavi" Font-Size="Small" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#ffffff" ForeColor="#333333" HorizontalAlign="Center" />
                        <AlternatingRowStyle HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="Button1" runat="server" Text="Print" CssClass="ContinueButton"
                                        CommandArgument='<%#Container.DataItemIndex%>' Style="height: 25px; width: 120px;
                                        font-size: 16px;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <asp:Label ID="lblmsg" runat="server" Text="" ForeColor="Red" Font-Size="20px"></asp:Label>
            </div>
           </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

