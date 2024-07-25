<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="HeadOfAccounts.aspx.cs" Inherits="HeadOfAccounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
 <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" type="text/css" href="dist/css/AdminLTE.css" />
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <script src="js/jquery.blockUI.js" type="text/javascript"></script>
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
            get_headofaccount_details();

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
        function saveheadofaccountsDetails() {
            var AccountName = document.getElementById('txt_acc').value;
            if (AccountName == "") {
                alert("Enter AccountNumber ");
                return false;

            }
            var Limit = document.getElementById('txt_Limit').value;
            if (Limit == "") {
                alert("Enter Limit ");
                return false;
            }
            var btnval = document.getElementById('btn_save').value;
            var sno = document.getElementById('lbl_sno').value;
            var data = { 'op': 'saveheadofaccountsDetails', 'AccountName': AccountName, 'Limit': Limit, 'btnVal': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        forclearall();
                        get_headofaccount_details();
                        $('#fillform').css('display', 'none');
                        $('#showlogs').css('display', 'block');
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

        function get_headofaccount_details() {
            var data = { 'op': 'get_headofaccount_details' };
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
            var results = '<div  style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer">';
            results += '<thead><tr><th scope="col"></th><th scope="col">AccountName</th><th scope="col">Limit</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr><td><input id="btn_poplate" type="button"  onclick="getme(this)" name="submit" class="btn btn-primary" value="Edit" /></td>';
                results += '<th scope="row" class="1" style="text-align:center;">' + msg[i].AccountName + '</th>';
                results += '<td data-title="code" class="2">' + msg[i].Limit + '</td>';
                results += '<td style="display:none" class="4">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#divHeadAcount").html(results);
        }
        function getme(thisid) {
            var AccountName = $(thisid).parent().parent().children('.1').html();
            var Limit = $(thisid).parent().parent().children('.2').html();
            var sno = $(thisid).parent().parent().children('.4').html();
            document.getElementById('txt_acc').value = AccountName;
            document.getElementById('txt_Limit').value = Limit;
            document.getElementById('btn_save').value = "Modify";
            document.getElementById('lbl_sno').value = sno;
        }
        function forclearall() {

            document.getElementById('txt_acc').value = "";
            document.getElementById('txt_Limit').value = "";
            document.getElementById('lbl_sno').innerHTML = 0;
            document.getElementById('btn_save').value = "SAVE";
            //get_headofaccount_details();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<br />
<br />
<br />
  <section class="content-header">
        <h1>
            Head Of Accounts Master<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">Head Of Accounts Master</a></li>
        </ol>
    </section>
    <br />
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Head Of Accounts Details
                </h3>
            </div>
            <div class="box-body">
                <table align="center">
                    <tr >
                        <td>
                          <label>AccountName</label>
                        </td>
                        <td style="height: 40px;">
                            <input type="text" id="txt_acc" class="form-control" placeholder="Enter AccountName" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>   Limit</label>
                        </td>
                        <td style="height: 40px;">
                            <input type="text" id="txt_Limit" class="form-control" placeholder="Enter Limit" />
                        </td>
                    </tr>
                      <tr style="display:none;"><td>
                            <label id="lbl_sno"></label>
                            </td>
                            </tr>
                    <tr>
                        <td>
                        </td>
                        <td style="height: 40px;">
                            <input type="button" id="btn_save" value="SAVE" " class="btn btn-success" Onclick="saveheadofaccountsDetails()"/>
                             <input id='btn_close' type="button" class="btn btn-danger" name="Close" value='Close'
                                        onclick="forclearall()" />
                        </td>
                    </tr>
                </table>
                <div id="divHeadAcount" style="height:500px;overflow:auto;">
                </div>
            </div>
        </div>
    </section>
</asp:Content>

