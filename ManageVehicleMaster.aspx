<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageVehicleMaster.aspx.cs" Inherits="ManageVehicleMaster" %>
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
    <script type="text/javascript">
        $(function () {
            get_vehicle_manage();
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
         function save_manage_vehicle() {
            var itemtype = document.getElementById('ddlItem').value;
            var itemcode = document.getElementById('txt_itemcode').value;
            var itemname = document.getElementById('txt_itemname').value;
            var btnval = document.getElementById('btn_save').value;
            var sno = document.getElementById('lbl_sno').value;
            var data = { 'op': 'save_manage_vehicle', 'itemtype': itemtype, 'itemcode': itemcode, 'itemname': itemname, 'btnval': btnval ,'sno':sno};
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        alert(msg);
                        get_vehicle_manage();
                        $('#div_managevehicle').show();
                        reset_vehicle();
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
         function get_vehicle_manage() {
            var data = { 'op': 'get_vehicle_manage' };
            var s = function (msg) {
                if (msg) {
                    if (msg.length > 0) {
                        fillmanagedetails(msg);
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

         function fillmanagedetails(msg) {
            var results = '<div  style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer">';
            results += '<thead><tr><th scope="col"></th><th scope="col">ItemType</th><th scope="col">ItemCode</th><th scope="col">ItemName</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr><td><input id="btn_poplate" type="button"  onclick="getme(this)" name="submit" class="btn btn-primary" value="Edit" /></td>';
                results += '<th scope="row" class="1" style="text-align:center;">' + msg[i].itemtype + '</th>';
                results += '<td data-title="code" class="2">' + msg[i].itemcode + '</td>';
                results += '<td data-title="code" class="3">' + msg[i].itemname + '</td>';
                results += '<td style="display:none" class="23">' + msg[i].sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#div_managevehicle").html(results);
        }
        function getme(thisid) {
            var itemtype = $(thisid).parent().parent().children('.1').html();
            var itemcode = $(thisid).parent().parent().children('.2').html();
            var itemname = $(thisid).parent().parent().children('.3').html();
            var sno = $(thisid).parent().parent().children('.23').html();


            document.getElementById('ddlItem').value = itemtype;
            document.getElementById('txt_itemcode').value = itemcode;
            document.getElementById('txt_itemname').value = itemname;
            document.getElementById('btn_save').value = "Modify";
            document.getElementById('lbl_sno').value = sno;
        }
        function reset_vehicle() {
            document.getElementById('ddlItem').selectedIndex = 0;
            document.getElementById('txt_itemcode').value = "";
            document.getElementById('txt_itemname').value = "";
            document.getElementById('lbl_sno').innerHTML = "";
            document.getElementById('btn_save').value = "Add";
        }
        
        

</script>
</br>
</br>
</br>
<section class="content-header">
        <h1>
          Manage  Vehicle Master
        </h1>
    </section>
    <section class="content">
         <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header">
            <table id="tbl_managevehicle" class="inputstable" align="center">
                <tr>
                    <td style="height: 40px;">
                        Item Type
                    </td>
                    <td>
                        <select class="form-control" id="ddlItem" placeholder="select Itemtype">
                        <option>Vehicle Type</option>
                         <option>Vehicle Make</option>
                         <option>Vehicle Model</option>
                          <option>Scheduled Route</option>
                          <option>Expenses</option>
                          <option>Plant Name</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td style="height: 40px;">
                        Item Code <span style="color: red;">*</span>
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txt_itemcode" placeholder="Enter Item Code" />
                    </td>
                    <td>
                        Item Name <span style="color: red;">*</span>
                    </td>
                    <td>
                        <input type="text" class="form-control" id="txt_itemname" placeholder="Enter Item Name" />
                    </td>
                </tr>
                <tr style="display: none;">
                    <td>
                        <label id="lbl_sno">
                        </label>
                    </td>
                </tr>
                <tr style="height: 10px;">
                </tr>
                 <tr>
                    <td>
                    </td>
                    <td style="height: 40px;">
                        <input id="btn_save" type="button" class="btn btn-success" name="submit" value="Add"
                            onclick="save_manage_vehicle();">
                        <input id="btn_reset" type="button" class="btn btn-warning" name="submit" value="Reset"
                            onclick="reset_vehicle();">
                       
                    </td>
                </tr>
                </table>
                <div id="div_managevehicle"  style="width: 100%; height: 400px; overflow: auto;">
            </div>
                </div>
                </div>
                </div></div>
                
</section>

</asp:Content>

