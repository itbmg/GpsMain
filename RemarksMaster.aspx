<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="RemarksMaster.aspx.cs" Inherits="RemarksMaster" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%-- <link href="css/formstable.css" rel="stylesheet" type="text/css" />
    <link href="css/custom.css" rel="stylesheet" type="text/css" />--%>
    <link href="bootstrap/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="bootstrap/bootstrap.min.js" type="text/javascript"></script>
    <link href="bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/fleetStyles.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/formcss.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/custom.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="bootstrap/font-awesome.min.css" />
    <link href="bootstrap/formstable.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {

            $('#btn_addvendor').click(function () {
                $('#fillform').css('display', 'block');
                $('#showlogs').css('display', 'none');
                $('#div_vendordata').hide();
                forclearall();
            });

            $('#btn_close').click(function () {
                $('#fillform').css('display', 'none');
                $('#showlogs').css('display', 'block');
                $('#div_vendordata').show();
                forclearall();
            });
            get_RemarksMaster_details();
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
                error: e
            });
        }
        function CallHandlerUsingJson(d, s, e) {
            d = JSON.stringify(d);
            d = d.replace(/&/g, '\uFF06');
            d = d.replace(/#/g, '\uFF03');
            d = d.replace(/\+/g, '\uFF0B');
            d = d.replace(/\=/g, '\uFF1D');
            $.ajax({
                type: "GET",
                url: "Bus.axd?json=",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: d,
                async: true,
                cache: true,
                success: s,
                error: e
            });
        }


        //Function for only no
        $(document).ready(function () {
            $("#txt_phoneno,#txt_servtax").keydown(function (event) {
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
        });

        //------------>Prevent Backspace<--------------------//
        $(document).unbind('keydown').bind('keydown', function (event) {
            var doPrevent = false;
            if (event.keyCode === 8) {
                var d = event.srcElement || event.target;
                if ((d.tagName.toUpperCase() === 'INPUT' && (d.type.toUpperCase() === 'TEXT' || d.type.toUpperCase() === 'PASSWORD'))
            || d.tagName.toUpperCase() === 'TEXTAREA') {
                    doPrevent = d.readOnly || d.disabled;
                } else {
                    doPrevent = true;
                }
            }

            if (doPrevent) {
                event.preventDefault();
            }
        });

        function validateEmail(email) {
            var reg = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
            if (reg.test(email)) {
                return true;
            }
            else {
                return false;
            }
        }

        function RemarksMasterSaveClick() {
            var btnval = document.getElementById('btn_save').value;
            var sno = document.getElementById('lbl_sno').innerHTML;
            var txtRemarks = document.getElementById('txtRemarks').value;
            if (txtRemarks == "") {
                alert("Please Enter Remarks");
                return false;
            }
            var data = { 'op': 'RemarksMasterSaveClick', 'txtRemarks': txtRemarks, 'btnval': btnval, 'sno': sno };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        if (msg == "OK") {
                            alert("New Vendor Successfully Created");
                            forclearall();
                            get_RemarksMaster_details();
                            $('#div_vendordata').show();
                            $('#fillform').css('display', 'none');
                            $('#showlogs').css('display', 'block');
                        }
                        else if (msg == "UPDATE") {
                            alert(vendorname + "  Vendor Successfully Modified");
                            forclearall();
                            get_RemarksMaster_details();
                            $('#div_vendordata').show();
                            $('#fillform').css('display', 'none');
                            $('#showlogs').css('display', 'block');
                        }
                        else {
                            alert(msg);
                        }
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
            document.getElementById('txtRemarks').value = "";
            document.getElementById('btn_save').value = "Save";
            $("#lbl_vencode_error_msg").hide();
            $("#lbl_vennme_error_msg").hide();
            $("#lbl_email_error_msg").hide();
        }

        function get_RemarksMaster_details() {
            var data = { 'op': 'get_RemarksMaster_details' };
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
            }; $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            callHandler(data, s, e);
        }
        function filldetails(msg) {
            var results = '<div class="divcontainer" style="overflow:auto;"><table class="responsive-table"><caption></casption>';
            results += '<thead><tr><th scope="col"></th><th scope="col">Remarks</th><th>Sno</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr><td><input id="btn_poplate" type="button"  onclick="getme(this)" name="submit" class="btn btn-primary" value="Choose" /></td>';
                results += '<th scope="row" class="1">' + msg[i].Remarks + '</th>';
                results += '<td scope="row"  class="sno">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#div_vendordata").html(results);
        }
        function getme(thisid) {
            var sno = $(thisid).parent().parent().children('.sno').html();
            var txtRemarks = $(thisid).parent().parent().children('.1').html();
            txtRemarks = replaceHtmlEntites(txtRemarks);

            document.getElementById('txtRemarks').value = txtRemarks;
            document.getElementById('lbl_sno').innerHTML = sno;
            document.getElementById('btn_save').value = "Modify";
            $("#div_vendordata").hide();
            $("#fillform").show();
            $('#showlogs').hide();
        }
        var replaceHtmlEntites = (function () {
            var translate_re = /&(nbsp|amp|quot|lt|gt);/g;
            var translate = {
                "nbsp": " ",
                "amp": "&",
                "quot": "\"",
                "lt": "<",
                "gt": ">"
            };
            return function (s) {
                return (s.replace(translate_re, function (match, entity) {
                    return translate[entity];
                }));
            }
        })();

    </script>
    <div id="showlogs" align="center">
        <input id="btn_addvendor" type="button" name="submit" value='Add Remarks' class="btn btn-primary" />
    </div>
    <div id="div_vendordata" style="background: #ffffff">
    </div>
    <div id='fillform' style="display: none;">
        <div align="center">
            <h3>
                Add Remarks</h3>
        </div>
        <table cellpadding="1px" align="center" style="width: 60%;">
            <tr>
                <th colspan="2" align="center">
                </th>
            </tr>
            <tr>
                <td>
                    Remarks
                </td>
                <td>
                    <textarea rows="5" cols="45" id="txtRemarks" class="form-control" maxlength="2000"
                        placeholder="Enter Remarks"></textarea>
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
                    <input type="button" class="btn btn-primary" name="submit" class="btn btn-primary"
                        id="btn_save" value='Save' onclick="RemarksMasterSaveClick()" /><input id='btn_close'
                            type="button" class="btn btn-primary" name="Close" value='Close' />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
