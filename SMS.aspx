<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SMS.aspx.cs" Inherits="SMS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
<script type="text/javascript">
    $(function () {
        only_no_trips();
    });
    function only_no_trips() {
        //$("[name=charge]").keydown(function (event) {
        $("[name=MobNo]").keydown(function (event) {
            // Allow: backspace, delete, tab, escape, and enter
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 || event.keyCode == 190 ||
            // Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) ||
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39)) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                    event.preventDefault();
                }
            }
        });
    }
    function send_sms() {
        var MobNo = document.getElementById('txtMobNo').value;
        if (MobNo == "") {
            alert("Please enter Mobile no");
            return false;
        }
        var txt_post = document.getElementById('txt_post').value;
        if (txt_post == "") {
            alert("Please enter remarks");
            return false;
        }
        var data = { 'op': 'btn_Send_SMS', 'MobNo': MobNo, 'txt_post': txt_post };
        var s = function (msg) {
            if (msg) {
                alert(msg);
                if (msg == "Message sent successfully") {
                    document.getElementById('txt_post').value = "";
                    document.getElementById('txtMobNo').value = "";
                }
            }
            else {
            }
        };
        var e = function (x, h, e) {
        };
        callHandler(data, s, e);
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
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<br /><br /><br /><br />
      <div style="border: 1px solid #d5d5d5; margin-left: 18px; margin-top: 10px; margin-right: 5px;">
        <div style="padding: 8px 10px 5px 10px; background-color: #eee;">
            Send SMS</div>
        <table>
            <tr>
                <td>
                    Mob No
                </td>
                <td>
                    <input type="text" id="txtMobNo" name="MobNo" class="ddldrop" maxlength="10">
                </td>
            </tr>
            <tr>
                <td>
                    Remarks
                </td>
                <td>
                    <textarea id="txt_post" rows="5" cols="65" style=" background-color: #f9f9f9; padding: 10px;
                        border: 1px solid #d5d5d5;" class="nicdark_bg_grey nicdark_radius nicdark_shadow grey small subtitle"
                        placeholder="COMMENTS" ></textarea>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <input id="btn_savefees" type="button"  class="ContinueButton" name="submit" value="Send SMS"
                        onclick="send_sms();" style="width: 120px;height:25px;font-size:14px;">
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
