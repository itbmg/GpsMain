<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TestD.aspx.cs" Inherits="TestD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="height: 20px; padding-top: 110px;">
    </div>
    <div id="NetSpeed" align="center">
        <table border="1" style="width: 500px; height: 300px;">
            <thead>
                <tr>
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
                        <span style="cursor: pointer;">NetSpeed is :</span>
                    </td>
                    <td>
                        <asp:Label ID="lblSpeed" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="color: #00FFFF; font-size: 18px; font-weight: bold; text-align: center;">
                    <td>
                        <span style="cursor: pointer;">PacketReceivedSpeed is :</span>
                    </td>
                    <td>
                        <asp:Label ID="lblPacketReceived" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="color: #FF0000; font-size: 18px; font-weight: bold; text-align: center;">
                    <td>
                        <span style="cursor: pointer;">PacketSendSpeed is :</span>
                    </td>
                    <td>
                        <asp:Label ID="lblPacketSend" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="color: #0000FF; font-size: 18px; font-weight: bold; text-align: center;">
                    <td>
                        <span style="cursor: pointer;">UploadSpeed is :</span>
                    </td>
                    <td>
                        <asp:Label ID="lblUpload" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr style="color: #FF00FF; font-size: 18px; font-weight: bold; text-align: center;">
                    <td>
                        <span style="cursor: pointer;">DownLoadSpeed is :</span>
                    </td>
                    <td>
                       <asp:Label ID="lblDownLoad" runat="server" Text=""></asp:Label>
                    </td>
                </tr>               
                <tr>
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="btn_Speed" runat="server" Text="Check Speed" CssClass="ContinueButton" Style="height: 25px; width: 100px; font-size:15px; font-weight:bold;" OnClick="btn_Speed_Click" />
                    </td>
                </tr>
            </tbody>
        </table>
        <asp:Timer ID="timer1" runat="server" Interval="6000" OnTick="timer1_Tick">
        </asp:Timer>
    </div>
</asp:Content>
