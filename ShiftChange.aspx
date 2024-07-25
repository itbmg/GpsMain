<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ShiftChange.aspx.cs" Inherits="ShiftChange" %>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="bootstrap/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="bootstrap/bootstrap.min.js" type="text/javascript"></script>
    <link href="bootstrap/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/fleetStyles.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/formcss.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/custom.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="bootstrap/font-awesome.min.css" />
    <link href="bootstrap/formstable.css" rel="stylesheet" type="text/css" />
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
        .chkclass
        {
            color: #080A89;
            font-size: 12px;
            float: left;
        }
        .lblclass
        {
            font-size: 13px;
            float: left;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var date = new Date();
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            if (month < 10) month = "0" + month;
            if (day < 10) day = "0" + day;
            today = year + "-" + month + "-" + day;
            $('#txtDespTime').val(today);
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
        function btnShiftChangeSaveclick() {
            var btnsave = document.getElementById('btnSave').value;
            var Data = { 'op': 'btnShiftChangeSaveclick', 'gridBinding': gridBinding, 'btnsave': btnsave };
            var s = function (msg) {
                if (msg) {
                    alert(msg);
                    RefreshClick();
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            CallHandlerUsingJson(Data, s, e);
        }
        function RefreshClick() {
            document.getElementById('txtDespTime').value = "";
            document.getElementById('txtVehicleNo').value = "";
            document.getElementById('txtDescription').value = "";
            document.getElementById('txtDriverName').value = "";
            document.getElementById('txtPhoneNo').value = "";
            document.getElementById('txtRouteName').value = "";
            document.getElementById('txtPowerOn').value = "";
            document.getElementById('txtProblems').value = "";
            document.getElementById('txtSolutions').value = "";
            document.getElementById('txtWork').value = "";
            document.getElementById('btnSave').value = "Save";
            gridBinding = [];
            var results = '<div class="divcontainer" style="overflow:auto;"><table class="responsive-table"><caption></casption>';
            results += '<thead><tr><th scope="col">DespTime</th><th scope="col">VehicleNo</th><th scope="col">Description</th><th scope="col">DriverName</th><th scope="col">PhoneNo</th><th scope="col">PowerOn</th><th scope="col">Type</th><th scope="col">Type</th><th>Problem</th><th>Solution</th><th>Work To Be Done</th></tr></thead></tbody>';
            for (var i = 0; i < gridBinding.length; i++) {
                results += '<th scope="row" class="1">' + gridBinding[i].DespTime + '</th>';
                results += '<th scope="row" class="1">' + gridBinding[i].VehicleNo + '</th>';
                results += '<th scope="row" class="1">' + gridBinding[i].Description + '</th>';
                results += '<th scope="row" class="1">' + gridBinding[i].DriverName + '</th>';
                results += '<th scope="row" class="1">' + gridBinding[i].PhoneNo + '</th>';
                results += '<th scope="row" class="1">' + gridBinding[i].RouteName + '</th>';
                results += '<th scope="row" class="1">' + gridBinding[i].PowerOn + '</th>';
                results += '<th scope="row" class="1">' + gridBinding[i].Type + '</th>';
                results += '<th scope="row" class="1">' + gridBinding[i].Problems + '</th>';
                results += '<th scope="row" class="1">' + gridBinding[i].Solutions + '</th>';
                results += '<td scope="row"  class="sno">' + gridBinding[i].Work + '</td></tr>';
            }
            results += '</table></div>';
            $("#div_vendordata").html(results);
        }
        var gridBinding = [];
        function AddTogridClick() {
            var DespTime = document.getElementById('txtDespTime').value;
            if (DespTime == "") {
                alert("Please Select Despatch Time");
                return false;
            }
            var VehicleNo = document.getElementById('txtVehicleNo').value;
            if (VehicleNo == "") {
                alert("Please Enter VehicleNo");
                return false;
            }
            var Description = document.getElementById('txtDescription').value;
            if (Description == "") {
                alert("Please Enter Description");
                return false;
            }
            var DriverName = document.getElementById('txtDriverName').value;
            if (DriverName == "") {
                alert("Please Enter DriverName");
                return false;
            }
            var PhoneNo = document.getElementById('txtPhoneNo').value;
            if (PhoneNo == "") {
                alert("Please Enter PhoneNo");
                return false;
            }
            var RouteName = document.getElementById('txtRouteName').value;
            if (RouteName == "") {
                alert("Please Enter RouteName");
                return false;
            }
            var PowerOn = document.getElementById('txtPowerOn').value;
            if (PowerOn == "") {
                alert("Please Enter PowerOn");
                return false;
            }
            var Problems = document.getElementById('txtProblems').value;
            if (Problems == "") {
                alert("Please Enter Problems");
                return false;
            }
            var Solutions = document.getElementById('txtSolutions').value;
            if (Solutions == "") {
                alert("Please Enter Solutions");
                return false;
            }
            var Work = document.getElementById('txtWork').value;
            if (Work == "") {
                alert("Please Enter Work To Be Done");
                return false;
            }
            var Checkexist = false;
            $('.VehicleNo').each(function (i, obj) {
                var IName = $(this).text();
                if (IName == VehicleNo) {
                    alert("Vehicle No Already Added");
                    Checkexist = true;
                }
            });
            if (Checkexist == true) {
                return;
            }
            gridBinding.push({ 'DespTime': DespTime, 'VehicleNo': VehicleNo, 'Description': Description, 'DriverName': DriverName, 'PhoneNo': PhoneNo, 'RouteName': RouteName, 'PowerOn': PowerOn, 'Problems': Problems, 'Solutions': Solutions, 'Work': Work });
            var results = '<div class="divcontainer" style="overflow:auto;"><table class="responsive-table"><caption></casption>';
            results += '<thead><tr><th scope="col">DespTime</th><th scope="col">VehicleNo</th><th scope="col">Description</th><th scope="col">DriverName</th><th scope="col">PhoneNo</th><th scope="col">PowerOn</th><th scope="col">Type</th><th>Problem</th><th>Solution</th><th>Work To Be Done</th></tr></thead></tbody>';
            for (var i = 0; i < gridBinding.length; i++) {
                results += '<th scope="row" class="DespTime">' + gridBinding[i].DespTime + '</th>';
                results += '<th scope="row" class="VehicleNo">' + gridBinding[i].VehicleNo + '</th>';
                results += '<th scope="row" class="Description">' + gridBinding[i].Description + '</th>';
                results += '<th scope="row" class="DriverName">' + gridBinding[i].DriverName + '</th>';
                results += '<th scope="row" class="PhoneNo">' + gridBinding[i].PhoneNo + '</th>';
                results += '<th scope="row" class="RouteName">' + gridBinding[i].RouteName + '</th>';
                results += '<th scope="row" class="PowerOn">' + gridBinding[i].PowerOn + '</th>';
                results += '<th scope="row" class="Problems">' + gridBinding[i].Problems + '</th>';
                results += '<th scope="row" class="Solutions">' + gridBinding[i].Solutions + '</th>';
                results += '<td scope="row"  class="Work">' + gridBinding[i].Work + '</td></tr>';
            }
            results += '</table></div>';
            $("#div_vendordata").html(results);
        }
    </script>
    <div align="center">
        <table>
            <tr>
                <td>
                    <label class="headers">
                        SHIFT CHANGE MANAGEMENT</label>
                </td>
            </tr>
        </table>
        <div style="width: 100%;">
            <table>
            <tr>
                    <td>
                        Despatch Time
                    </td>
                    <td>
                        <input type="datetime-local" id="txtDespTime" class="form-control" placeholder="Enter DespTime" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Vehicle No
                    </td>
                    <td>
                        <input type="text" id="txtVehicleNo" class="form-control" placeholder="Enter Vehicle No" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Description
                    </td>
                    <td>
                        <input type="text" id="txtDescription" class="form-control" placeholder="Enter Description" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Driver Name
                    </td>
                    <td>
                        <input type="text" id="txtDriverName" class="form-control" placeholder="Enter  Driver Name" />
                    </td>
                </tr>
                 <tr>
                    <td>
                       Phone No
                    </td>
                    <td>
                        <input type="text" id="txtPhoneNo" class="form-control" placeholder="Enter Phone No" />
                    </td>
                </tr>
                <tr>
                    <td>
                     Route Name
                    </td>
                    <td>
                        <input type="text" id="txtRouteName" class="form-control" placeholder="Enter Route Name" />
                    </td>
                </tr>
                <tr>
                    <td>
                    Power On
                    </td>
                    <td>
                        <input type="text" id="txtPowerOn" class="form-control" placeholder="Enter Power On" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Problems
                    </td>
                    <td>
                        <textarea rows="3" cols="45" id="txtProblems" class="form-control" maxlength="2000"
                            placeholder="Enter Problems Max(2000 Characters)"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        Solutions
                    </td>
                    <td>
                        <textarea rows="3" cols="45" id="txtSolutions" class="form-control" maxlength="2000"
                            placeholder="Enter Solutions Max(2000 Characters)"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        Work to be done
                    </td>
                    <td>
                        <textarea rows="3" cols="45" id="txtWork" class="form-control" maxlength="2000" placeholder="Enter  Work to be done Max(2000 Characters)"></textarea>
                    </td>
                </tr>
            </table>
            <br />
            <input type="button" class="btn btn-primary" name="submit" class="btn btn-primary"
                id="btn_save" value='ADD' onclick="AddTogridClick()" />
            <div id="div_vendordata" style="background: #ffffff">
            </div>
            <br />
            <input type="button" id="btnSave" value="Save" onclick="btnShiftChangeSaveclick();"
                class="ContinueButton" style="width: 120px; font-size: 20px;" />
        </div>
    </div>
</asp:Content>
