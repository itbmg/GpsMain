<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BulkSmsLocationSettings.aspx.cs" Inherits="BulkSmsLocationSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<%--<script src="js/jquery.blockUI.js" type="text/javascript"></script>--%>
    <script src="js/jquery.json-2.4.js" type="text/javascript"></script>
      <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDbt9z3InHbzrV66t1eSZB5TnlJ2HQ-Uc8&v=3.exp&sensor=false&libraries=geometry"></script>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" type="text/css" href="dist/css/AdminLTE.css" />
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <style>
    .h1, .h2, .h3, h1, h2, h3
        {
            margin-top: 5px;
            margin-bottom: 10px;
        }
        
        .divselectedclass
        {
            border: 1px solid gray;
            padding-top: 2px;
            padding-bottom: 2px;
        }
       
        
        .unitline
        {
            font: inherit;
            width: 120px;
        }
        .iconminus
        {
            float: right;
            width: 20px;
            height: 20px;
            margin: 2px 0 0 0;
            background: url("Images/minus.png") no-repeat;
            border-radius: 2px 2px 2px 2px;
        }
        .titledivcls
        {
            height: 30px;
        }
        .divcategory
        {
            border-bottom-style: dashed;
            border-bottom-color: #D6D6D6;
            border-bottom-width: 1px;
        }
        
        
        
        .activeanchor
        {
            text-decoration: none;
            color: #000000;
        }
         .back-red
        {
            background-color: #ffffcc;
        }
        .back-white
        {
            background-color: #ffffff;
        }
        .menuclass
        {
            height: 59px !important;
        }
    </style>
     <script type="text/javascript">
         var map;
         function initialize() {
             var mapOptions = {
                 zoom: 3,
                 center: new google.maps.LatLng(17.445974, 80.150965),
                 mapTypeId: google.maps.MapTypeId.ROADMAP
             };
             map = new google.maps.Map(document.getElementById('googleMap'),
      mapOptions);
         }

         google.maps.event.addDomListener(window, 'load', initialize);
    </script>

    <script type="text/javascript">
    //1
        $(function () {
            FillBranches();
            bindmanageroutes();
        });

        function FillBranches() {
            var data = { 'op': 'get_Routes' };
            var s = function (msg) {
                if (msg) {
                    fillroutes_divchklist(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

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
        var allbranchesdata;
        function fillroutes_divchklist(msg) {
            allbranchesdata = msg;
            var plants = [];
            var sel = document.getElementById('ddlselectplant');
            var opt = document.createElement('option');
            opt.innerHTML = "Select Plant";
            opt.value = "Select Plant";
            sel.appendChild(opt);
            for (var i = 0; i < allbranchesdata.length; i++) {
                if (typeof allbranchesdata[i] === "undefined" || allbranchesdata[i].PlantName == "" || allbranchesdata[i].PlantName == null) {
                }
                else {
                    if (plants.indexOf(allbranchesdata[i].PlantName) == -1) {
                        var plantname = allbranchesdata[i].PlantName;
                        var PlantSno = allbranchesdata[i].PlantSno;
                        plants.push(plantname);
                        var opt = document.createElement('option');
                        opt.innerHTML = plantname;
                        opt.value = PlantSno;
                        sel.appendChild(opt);
                    }
                }
            }
            var opt = document.createElement('option');
            opt.innerHTML = "Select All";
            opt.value = "Select All";
            sel.appendChild(opt);
        }

        function bindmanageroutes() {
            var data = { 'op': 'updateroutesAssigntogrid' };
            var s = function (msg) {
                if (msg) {
                    bindingmanageroutes(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

            callHandler(data, s, e);
        }
        var refno = "";
        var allroutesdata;

        function bindingmanageroutes(databind) {
            RefreshClick();
            allroutesdata = databind;
        }
        function RefreshClick() {
            $('.chkclass').each(function () {
                $(this).attr("checked", false);
            });
            document.getElementById('divselected').innerHTML = "";
            document.getElementById('txtRouteName').value = "";
            document.getElementById('ddlselectplant').selectedIndex = 0;
            document.getElementById('ddlstatus').selectedIndex = 0;
            document.getElementById('btnSave').value = "Save";
            ClearPolylines();
        }
        //1

        //1.1
        function ddlselectplant_selectionchanged() {
            var selectedplant = document.getElementById('ddlselectplant').value;

            if (selectedplant == "") {
                selectedplant = "Select All";
            }
            document.getElementById('divchblroutes').innerHTML = "";
            var plants = [];

            for (var i = 0; i < allbranchesdata.length; i++) {
                if (typeof allbranchesdata[i] === "undefined" || allbranchesdata[i].PlantName == "" || allbranchesdata[i].PlantName == null) {
                }
                else {
                    var tplantname = allbranchesdata[i].PlantName;
                    var tplantsno = allbranchesdata[i].PlantSno;

                    if (selectedplant != "Select All") {
                        if (tplantsno == selectedplant) {
                            tplantname = tplantname.replace(/[^a-zA-Z0-9]/g, '');
                            var exists = plants.indexOf(tplantname);
                            if (exists == -1) {
                                var plantname = allbranchesdata[i].PlantName;
                                plantname = plantname.replace(/[^a-zA-Z0-9]/g, '');
                                plants.push(plantname);
                                $("#divchblroutes").append("<div id='div" + plantname + "' class='divcategory'>");
                            }
                        }
                    }
                    else {
                        tplantname = tplantname.replace(/[^a-zA-Z0-9]/g, '');
                        var exists = plants.indexOf(tplantname);
                        if (exists == -1) {
                            var plantname = allbranchesdata[i].PlantName;
                            plantname = plantname.replace(/[^a-zA-Z0-9]/g, '');
                            plants.push(plantname);
                            $("#divchblroutes").append("<div id='div" + plantname + "' class='divcategory'>");
                        }
                    }
                }
            }
            for (var p = 0; p < plants.length; p++) {
                $("#div" + plants[p] + "").append("<div class='titledivcls'><table style='width:100%;'><tr><td style='width: 120px;'><h2 class='unitline'>" + plants[p] + "</h2></td><td></td><td style='padding-right: 20px;vertical-align: middle;'><span class='iconminus' title='Hide' onclick='minusclick(this);'></span></td></tr></table></div>");
                $("#div" + plants[p] + "").append("<ul id='ul" + plants[p] + "' class='ulclass'>");
                for (var i = 0; i < allbranchesdata.length; i++) {
                    var tplantname = allbranchesdata[i].PlantName;
                    tplantname = tplantname.replace(/[^a-zA-Z0-9]/g, '');
                    if (typeof allbranchesdata[i] === "undefined" || allbranchesdata[i].Name == "" || allbranchesdata[i].Name == null) {
                    }
                    else {
                        if (plants[p] == tplantname) {
                            var label = document.createElement("span");
                            var hidden = document.createElement("input");
                            hidden.type = "hidden";
                            hidden.name = "hidden";
                            hidden.value = allbranchesdata[i].id;
                            var checkbox = document.createElement("input");
                            checkbox.type = "checkbox";
                            checkbox.name = "checkbox";
                            checkbox.value = "checkbox";
                            checkbox.id = "checkbox";
                            checkbox.className = 'chkclass';
                            checkbox.onclick = 'checkclick();';
                            document.getElementById('ul' + plants[p]).appendChild(checkbox);
                            label.innerHTML = allbranchesdata[i].Name;
                            document.getElementById('ul' + plants[p]).appendChild(label);
                            document.getElementById('ul' + plants[p]).appendChild(hidden);
                            document.getElementById('ul' + plants[p]).appendChild(document.createElement("br"));
                        }
                    }
                }
            }
            TabclassClick();

            $("#grd_routesmangelist").jqGrid("clearGridData");
            var newarray = [];
            var Headarray = [];
            var headdatacol = allroutesdata[1];
            var datacol = allroutesdata;
            var selectedplant = document.getElementById('ddlselectplant').value
            for (var Booking in allroutesdata) {
                if (selectedplant != "Select All") {
                    if (selectedplant == allroutesdata[Booking].PlantSno) {
                        newarray.push({ 'Sno': newarray.length + 1, 'RouteName': allroutesdata[Booking].RouteName, 'RefNo': allroutesdata[Booking].SNo, 'status': allroutesdata[Booking].status, 'PlantName': allroutesdata[Booking].PlantName, 'PlantRefNo': allroutesdata[Booking].PlantSno });
                    }
                }
                else {
                    newarray.push({ 'Sno': newarray.length + 1, 'RouteName': allroutesdata[Booking].RouteName, 'RefNo': allroutesdata[Booking].SNo, 'status': allroutesdata[Booking].status, 'PlantName': allroutesdata[Booking].PlantName, 'PlantRefNo': allroutesdata[Booking].PlantSno });
                }
            }
            var results = '<div class="divcontainer" style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
            results += '<thead><tr><th scope="col"></th><th scope="col">Route Name</th><th scope="col">Ref No</th><th scope="col">Plant Name</th><th scope="col">Status</th><th scope="col">Plant Ref No</th></tr></thead></tbody>';
            for (var i = 0; i < newarray.length; i++) {
                var status = "Active";
                if (newarray[i].status == "1") {
                    status = "Active";
                }
                if (newarray[i].status == "0") {
                    status = "InActive";
                }
                results += '<tr><td><input id="btn_poplate" type="button"  onclick="getme(this)" name="submit" class="btn btn-success" value="Edit" /></td>';
                results += '<th scope="row" class="1">' + newarray[i].RouteName + '</th>';
                results += '<td data-title="Code" class="2">' + newarray[i].RefNo + '</td>';
                results += '<td  data-title="Code" class="3">' + newarray[i].PlantName + '</td>';
                results += '<td  data-title="Code" class="5">' + status + '</td>';
                results += '<td  class="4">' + newarray[i].PlantRefNo + '</td></tr>';
            }
            results += '</table></div>';
            $("#div_Branchdata").html(results);
        }
        function getme(thisid) {
            document.getElementById('divselected').innerHTML = "";
            var RouteName = $(thisid).parent().parent().children('.1').html();
            var PlantRefNo = $(thisid).parent().parent().children('.4').html();
            var status = $(thisid).parent().parent().children('.5').html();
            var newstatus = "1";
            if (status == "Active") {
                newstatus = "1";
            }
            if (status == "InActive") {
                newstatus = "0";
            }
            document.getElementById('txtRouteName').value = RouteName;
            document.getElementById('ddlselectplant').value = PlantRefNo;
            document.getElementById('ddlstatus').value = newstatus;
            document.getElementById('btnSave').value = "MODIFY";
            refno = $(thisid).parent().parent().children('.2').html();
            var data = { 'op': 'updatedivselected', 'refno': refno };
            var s = function (msg) {
                if (msg) {
                    gridselctionchanged(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            callHandler(data, s, e);
        }
        //1.1

        //2


        function divonclick(selected) {
            selectedindex = selected;
            var elem = document.getElementById(selectedindex);
            if (elem.style.backgroundColor == "" || elem.style.backgroundColor == 'rgb(255, 255, 255)' || elem.style.backgroundColor == 'rgba(0, 0, 0, 0)') {
                $('.divselectedclass').each(function () {
                    $(this).css('background-color', '#ffffff');
                });
                elem.style.backgroundColor = '#ffffcc';
            }
            else {
                $('.divselectedclass').each(function () {
                    $(this).css('background-color', '#ffffff');
                });
            }
        }


        function btnUpClick() {
            var elem = document.getElementById(selectedindex);
            $(elem).insertBefore($(elem).prev());
            GetPoly();
        }
        function btnDownClick() {
            var elem = document.getElementById(selectedindex);
            $(elem).insertAfter($(elem).next());
            GetPoly();
        }

        function minusclick(thisid) {
            var prntdiv = $(thisid).parents(".titledivcls");
            ul = prntdiv.next("ul");
            if (thisid.title == "Hide") {
                ul.slideUp("slow");
                $(thisid).attr('title', "Show");
                $(thisid).css("background", "url('Images/plus.png') no-repeat");
            }
            else {
                ul.slideDown("slow");
                $(thisid).attr('title', "Hide");
                $(thisid).css("background", "url('Images/minus.png') no-repeat");
            }
        }

        function GetPoly() {
            var ArrayPath = [];
            var j = 1;
            BrachNames = "";
            Ranks = "";
            map = new google.maps.Map(document.getElementById('googleMap'), {
                zoom: 10,
                center: new google.maps.LatLng(17.445974, 80.150965),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            });
            $('.divselectedclass').each(function () {
                var Selected = $(this);
                var Selectedid = Selected[0].id;
                for (var cnt = 0; cnt < allbranchesdata.length; cnt++) {
                    if (Selectedid == allbranchesdata[cnt].id) {
                        ArrayPath.push(new google.maps.LatLng(allbranchesdata[cnt].latitude, allbranchesdata[cnt].longitude));

                        BrachNames += allbranchesdata[cnt].Name + "-";
                        Ranks += j + "-";
                        var content = "Branch Name : " + allbranchesdata[cnt].Name + "\n" + "Rank : " + j;
                        marker = new google.maps.Marker({
                            position: new google.maps.LatLng(allbranchesdata[cnt].latitude, allbranchesdata[cnt].longitude),
                            map: map,
                            title: content
                        });
                        j++;
                        var myCenter = new google.maps.LatLng(allbranchesdata[cnt].latitude, allbranchesdata[cnt].longitude);
                        map.panTo(myCenter);
                    }
                }
            });
            var line = new google.maps.Polyline({
                path: ArrayPath,
                strokeColor: '#ff0000',
                strokeOpacity: 2.0,
                strokeWeight: 3
            });
            line.setMap(map);
        }


        function TabclassClick() {
            $("input[type='checkbox']").click(function () {
                if ($(this).is(":checked")) {
                    var Selected = $(this).next().text();
                    var Selectedid = $(this).next().next().val();

                    var label = document.createElement("div");
                    var Crosslabel = document.createElement("img");
                    Crosslabel.style.float = "right";
                    Crosslabel.src = "Images/Cross.png";
                    Crosslabel.onclick = function () { RemoveClick(Selectedid); };
                    label.id = Selectedid;
                    label.innerHTML = Selected;
                    label.className = 'divselectedclass';
                    label.onclick = function () { divonclick(Selectedid); };
                    document.getElementById('divselected').appendChild(label);
                    label.appendChild(Crosslabel);
                    GetPoly();
                }
                else {
                    var Selected = $(this).next().next().val();
                    var elem = document.getElementById(Selected);
                    var p = elem.parentNode;
                    p.removeChild(elem);
                    GetPoly();
                }
            });
        }


        function RemoveClick(Selected) {
            var elem = document.getElementById(Selected);
            var p = elem.parentNode;
            p.removeChild(elem);
            $('.chkclass').each(function () {
                if ($(this).next().next().val() == Selected) {
                    $(this).attr("checked", false);
                }
            });
            GetPoly();
        }

        function gridselctionchanged(msg) {
            var j = 1;
            BrachNames = "";
            Ranks = "";
            var ArrayPath = [];
            map = new google.maps.Map(document.getElementById('googleMap'), {
                zoom: 10,
                center: new google.maps.LatLng(17.445974, 80.150965),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            });
            for (var cnt = 0; cnt < msg.length; cnt++) {
                $('.chkclass').each(function () {
                    if ($(this).next().next().val() == msg[cnt].id) {
                        $(this).attr("checked", true);
                    }
                });
                var Selected = msg[cnt].Name;
                var Selectedid = msg[cnt].id;
                var label = document.createElement("div");
                var Crosslabel = document.createElement("img");
                Crosslabel.style.float = "right";
                Crosslabel.id = Selectedid;
                Crosslabel.src = "Images/Cross.png";
                Crosslabel.onclick = function () { RemoveClick(this.id); };
                label.id = Selectedid;
                label.innerHTML = Selected;
                label.className = 'divselectedclass';
                Locations = Selected + ",";
                label.onclick = function () { divonclick(this.id); };
                document.getElementById('divselected').appendChild(label);
                label.appendChild(Crosslabel);

                for (var i = 0; i < msg.length; i++) {
                    ArrayPath.push(new google.maps.LatLng(msg[cnt].latitude, msg[cnt].longitude));
                }

                BrachNames += msg[cnt].Name + "-";
                Ranks += j + "-";
                var content = "Branch Name : " + msg[cnt].Name + "\n" + "Rank : " + j;
                var marker = new google.maps.Marker({
                    position: new google.maps.LatLng(msg[cnt].latitude, msg[cnt].longitude),
                    map: map,
                    title: content
                });
                var myCenter = new google.maps.LatLng(msg[cnt].latitude, msg[cnt].longitude);
                map.panTo(myCenter);
                j++;
            }
            var line = new google.maps.Polyline({
                path: ArrayPath,
                strokeColor: '#ff0000',
                strokeOpacity: 2.0,
                strokeWeight: 3

            });
            line.setMap(map);
        }



        //2


        function CallHandlerUsingJson(d, s, e) {
            $.ajax({
                type: "GET",
                url: "Bus.axd?json=",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(d),
                async: true,
                cache: true,
                success: s,
                error: e
            });
        }


     
    </script>

    <script type="text/javascript">

            var BrachNames = "";
            var Ranks = "";
            var Sno = "";
            function ChangeButtonText() {
                $('#btnRouteSave').val("Edit");
                Addtomap();
            }

            function ClearPolylines() {
                var map = new google.maps.Map(document.getElementById('googleMap'), {
                    zoom: 3,
                    center: new google.maps.LatLng(17.445974, 80.150965),
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                });
                var ArrayPath = [];
                var path = ArrayPath;
                var line = new google.maps.Polyline({
                    path: path,
                    strokeColor: '#ff0000',
                    strokeOpacity: 2.0,
                    zoom: 3,
                    strokeWeight: 3
                });
                line.setMap(map);
            }
            
    </script>

       <script>

           function btnRouteAssignSaveclick() {
               var routename = document.getElementById('txtRouteName').value;
               if (routename == "") {
                   alert("Enter Route Name");
                   return false;
               }
               var ddlstatus = document.getElementById('ddlstatus').value;
               if (ddlstatus == "") {
                   alert("Select Status");
                   return false;
               }

               var selectedplant = document.getElementById('ddlselectplant');
               var plantsno = selectedplant.value;
               if (plantsno == "Select Plant") {
                   alert("Please select Plant Name");
                   return false;
               }
               var div = document.getElementById('divselected');
               var divs = div.getElementsByTagName('div');
               var divArray = [];
               for (var i = 0; i < divs.length; i += 1) {
                   divArray.push(divs[i].id);
               }
               if (divArray.length == 0) {
                   alert("Please select Branches");
                   return false;
               }
               var btnsave = document.getElementById('btnSave').value;
               var Data = { 'op': 'btnRoutesSaveClick', 'routename': routename, 'plantsno': plantsno, 'status': ddlstatus, 'data': divArray, 'btnsave': btnsave, 'refno': refno };
               var s = function (msg) {
                   if (msg) {
                       alert(msg);
                       bindmanageroutes();
                       RefreshClick();
                       ddlselectplant_selectionchanged();
                   }
                   else {
                   }
               };
               var e = function (x, h, e) {
               };
               CallHandlerUsingJson(Data, s, e);

           }

           function btnRouteAssignDeleteclick() {
               var routename = document.getElementById('txtRouteName').value;
               if (routename == "") {
                   alert("Enter Route Name");
                   return false;
               }
               var Data = { 'op': 'btnRoutesDeleteClick', 'refno': refno };
               var s = function (msg) {
                   if (msg) {
                       alert(msg);
                       bindmanageroutes();
                       RefreshClick();
                   }
                   else {
                   }
               };
               var e = function (x, h, e) {
               };
               $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

               callHandler(Data, s, e);
           }


           function btnRouteAssignRefreshclick() {
               RefreshClick();
           }
     </script>





 <br />
    <br />
    <br />
    <section class="content-header">
        <h1>
            Route Assign<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Operations</a></li>
            <li><a href="#">Route Assign</a></li>
        </ol>
    </section>
    <br />
     <section class="content">
      <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Route Assign Details
                </h3>
            </div>
             <div class="box-body">
                <div style="width: 100%; height: 550px; background-color: #fff">
                 <table>
                        <tr>
                            <td style="padding-left: 300px">
                                <label>
                                    Plant Name</label>
                            </td>
                            <td>
                                <select id="ddlselectplant" class="form-control" onchange="ddlselectplant_selectionchanged();">
                                </select>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <div style="width: 100%; height: 100%;">
                        <div style="width: 24%; float: left; height: 100%;">
                            <div class="box box-info" style="float: left; width: 240px; height: 330px; overflow: auto;">
                                <div class="box-header with-border">
                                    <h3 class="box-title">
                                        <i style="padding-right: 5px;" class="fa fa-cog"></i>Location Details
                                    </h3>
                                </div>
                                <div class="box-body">
                                    <div id="divchblroutes">
                                    </div>
                                </div>
                            </div>
                        </div>
                         <div style="width: 70%; float: left;">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <div class="box box-info" style="float: left; width: 240px; height: 330px; overflow: auto;">
                                            <div class="box-header with-border">
                                                <h3 class="box-title">
                                                    <i style="padding-right: 5px;" class="fa fa-cog"></i>Selected Location(s)
                                                </h3>
                                            </div>
                                            <div class="box-body">
                                                <div id="divselected">
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <input type="button" class="btnUp" onclick="btnUpClick();" /><br />
                                        <input type="button" class="btnDown" onclick="btnDownClick();" />
                                    </td>
                                    <td style="vertical-align: top; width: 600px; height: 350px;">
                                        <div>
                                            <div id="googleMap" style="width: 600px; height: 350px; position: relative; background-color: rgb(229, 227, 223);">
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div style="padding-left: 0%;">
                                <table>
                                    <tr>
                                        <td>
                                            <label>
                                                Route Name</label>
                                        </td>
                                        <td style="height: 40px;">
                                            <input type="text" id="txtRouteName" class="form-control" placeholder="Enter Route Name" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label>
                                                Status</label>
                                        </td>
                                        <td style="height: 40px;">
                                            <select id="ddlstatus" class="form-control">
                                                <option value="1">Active</option>
                                                <option value="0">InActive</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <input type="button" id="btnSave" value="Save" class="btn btn-success" onclick="btnRouteAssignSaveclick();" />
                                            <input type="button" id="btnDelete" value="Delete" class="btn btn-danger" onclick="btnRouteAssignDeleteclick();" />
                                            <input type="button" id="btnRefresh" value="Refresh" class="btn btn-warning" onclick="btnRouteAssignRefreshclick();" />
                                        </td>
                                    </tr>
                                </table>
                                <div>
                                    <br />
                                </div>
                                <div id="div_Branchdata" style="width: 90%;">
                                </div>
                            </div>

                           </div>
                </div>
                </div>
             </div>
       </div>

      </section>
</asp:Content>

