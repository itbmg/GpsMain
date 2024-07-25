
<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Rpt_Vehicleperdayroutecomparison.aspx.cs" Inherits="Rpt_Vehicleperdayroutecomparison" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .togglediv
        {
            position: absolute;
            width: 300px;
            color: Black; /*z-index: 99900;*/
            border: 2px solid #d5d5d5;
            background-color: #ffffff;
            cursor: pointer;
            top: 69px;
            bottom: 0px;
            left: 0px;
            opacity: 0.9;
            z-index: 99999;
        }
        
        .inner
        {
            width: 339px;
            position: absolute;
            left: 0px;
            bottom: 0px;
            color: Black;
            z-index: 99900;
            height: 100%;
            top: -2px;
            opacity: 0.9;
        }
        
        div#mapcontent
        {
            right: 0;
            bottom: 0;
            left: 0px;
            top: 69px;
            overflow: hidden;
            position: absolute;
        }
        .datebuttonsleft
        {
            -webkit-box-shadow: inset 0px 1px 0px 0px #ffffff;
            box-shadow: inset 0px 1px 0px 0px #ffffff;
            background: -webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #dfdfdf) );
            cursor: pointer;
            margin: 0px;
            border-radius: 3px 0px 0px 0px;
            width: 35px;
            height: 26px;
            border: 0px solid #ffffff;
            background: #d5d5d5 url(Images/Left.png) no-repeat center;
        }
        .datebuttonsright
        {
            -webkit-box-shadow: inset 0px 1px 0px 0px #ffffff;
            box-shadow: inset 0px 1px 0px 0px #ffffff;
            background: -webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #dfdfdf) );
            cursor: pointer;
            margin: 0px;
            border-radius: 0px 3px 0px 0px;
            width: 35px;
            height: 26px;
            border: 0px solid #ffffff;
            background: #d5d5d5 url(Images/Right.png) no-repeat center;
        }
        .datebuttonsleft:hover
        {
            background: -webkit-gradient( linear, left top, left bottom, color-stop(0.05, #dfdfdf), color-stop(1, #ededed) );
            background: -moz-linear-gradient( center top, #dfdfdf 5%, #ededed 100% );
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf', endColorstr='#ededed');
            background: #f5f5f5 url(Images/Left.png) no-repeat center;
            background-color: #dfdfdf;
        }
        .datebuttonsright:hover
        {
            background: -webkit-gradient( linear, left top, left bottom, color-stop(0.05, #dfdfdf), color-stop(1, #ededed) );
            background: -moz-linear-gradient( center top, #dfdfdf 5%, #ededed 100% );
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf', endColorstr='#ededed');
            background: #f5f5f5 url(Images/Right.png) no-repeat center;
            background-color: #dfdfdf;
        }
    </style>
    <script src="js/jquery.blockUI.js" type="text/javascript"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCNJQwYwI1XH2nQzqszGuv5WKpkjNzY-Z8&v=3.exp&libraries=geometry&sensor=false"></script>
    <%--<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyDGYPgYpwZ4ZQCLCAujetDwArlVBC_S9TI&sensor=false"></script>--%>
    <script src="Newjs/infobox.js" type="text/javascript"></script>
    <script type="text/javascript">
        var map;
        function initialize() {
            var mapOptions = {
                zoom: 12,
                center: new google.maps.LatLng(12.008477318659862, 79.65307331968529),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById('googleMap'), mapOptions);

            var homeControlDiv = document.createElement('div');
            var homeControl = new HomeControl(homeControlDiv, map);
            map.controls[google.maps.ControlPosition.TOP_RIGHT].push(homeControlDiv);
        }

        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
    <script type="text/javascript">

        // Add a Home control that returns the user to London
        function HomeControl(controlDiv, map) {
            controlDiv.style.padding = '5px 1px 0px 0px';
            var controlUI = document.createElement('div');
            controlUI.style.backgroundColor = 'rgb(255, 255, 255)';
            controlUI.style.border = '1px solid rgb(113, 123, 135)';
            controlUI.style.cursor = 'pointer';
            controlUI.style.textAlign = 'center';
            controlUI.style.width = '250px';
            controlUI.title = 'Update Time';
            controlUI.style.boxShadow = "rgba(0, 0, 0, 0.4) 0px 2px 4px";
            controlDiv.appendChild(controlUI);
            var controlText = document.createElement('div');
            controlText.style.fontFamily = 'Arial,sans-serif';
            controlText.style.fontSize = '20px';
            controlText.style.color = 'Green';
            controlText.style.paddingLeft = '4px';
            controlText.style.paddingRight = '4px';
            controlText.style.paddingTop = '4px';
            controlText.style.height = '20px';
            controlText.style.paddingTop = '15px';
            controlText.innerHTML = 'Update Time';
            controlText.id = 'lbl_logtime';
            controlUI.appendChild(controlText);
        }

        $(function () {
            get_Vehicledetails();

            var hidden = false;
            $("#btnClose").click(function () {
                if (hidden) {
                    $(".togglediv").stop().animate({ left: 0 }, 500);
                    hidden = false;
                    $("#btnClose").attr('title', "Hide");
                    $("#btnClose").attr('src', "Images/bigleft.png");
                }
                else {
                    $(".togglediv").css('margin-left', 0);
                    $(".togglediv").css('margin-right', 0);
                    $(".togglediv").animate({ left: '-305px' }, 500);
                    $("#btnClose").attr('title', "Show");
                    $("#btnClose").attr('src', "Images/bigright.png");
                    hidden = true;
                }
            });
        });

        function Load_vehicle() {
            get_Vehicledetails();
        }


        function get_Vehicledetails() {
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            var vehicleType = document.getElementById('ddlType').value;
            var data = { 'op': 'get_Vehicledetails', 'vehicleType': vehicleType };
            var s = function (msg) {
                if (msg) {
                    firstvehicles(msg);
                    fsecondvehicles(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            callHandler(data, s, e);
        }


        function firstvehicles(msg) {
            var firstvehicles = document.getElementById('ddl_firstvehicles');
            var length = firstvehicles.options.length;
            document.getElementById('ddl_firstvehicles').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Vehicle No";
            opt.value = "Select Vehicle No";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            firstvehicles.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                var Id = msg[i].VehicleID;
                if (Id.length > 7) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].VehicleID;
                    option.value = msg[i].VehicleID; //msg[i].sno;
                    firstvehicles.appendChild(option);
                }
            }
        }

        function fsecondvehicles(msg) {

            var secondvehicles = document.getElementById('ddl_secondvehicles');
            var length = secondvehicles.options.length;
            document.getElementById('ddl_secondvehicles').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "Select Vehicle No";
            opt.value = "Select Vehicle No";
            opt.setAttribute("selected", "selected");
            opt.setAttribute("disabled", "disabled");
            opt.setAttribute("class", "dispalynone");
            secondvehicles.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                var Id = msg[i].VehicleID;
                if (Id.length > 7) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].VehicleID;
                    option.value = msg[i].VehicleID; // msg[i].sno;
                    secondvehicles.appendChild(option);
                }
            }
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
    <script type="text/javascript">
        function btn_generate_Click() {
            initialize();
            var Username = '<%= Session["field1"] %>';
            var firstNo = document.getElementById('ddl_firstvehicles');
            firstNo = firstNo.value;

            var SecondNo = document.getElementById('ddl_secondvehicles');
            SecondNo = SecondNo.value;
            var drawdtae = document.getElementById('txt_ReportDate').value;

            var data = { 'op': 'get_VeicleRouteperdaycomparisondata', 'Username': Username, 'firstNo': firstNo, 'SecondNo': SecondNo, 'drawdtae': drawdtae };
            var s = function (msg) {
                if (msg) {
                    polyroute(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            callHandler(data, s, e);
        }

        var triproutedata;
        var interval;
        var flightPath = null;
        var colors = new Array();
        var polilinepath = [];
        var allflightPlanCoordinates = [];
        var globellooper;
        var maxcount = 0;
        var vehiclesarray = [];
        var markersArray = [];
        var vehlogscount = [];
        var vehcolors = [];
        var panstatus = true;

        function polyroute(msg) {
            logcount = 0;
            remcount = 0;
            $("#speedval").val("speed");
            polilinepath = [];
            allflightPlanCoordinates = [];
            if (flightPath) {
                flightPath.setMap(null);
            }
            colors = new Array("red", "blue", "black", "gray", "maroon", "Alabama Crimson", "Amber", "Bangladesh green", "Heart Gold", "Camouflage green", "Cadmium red", "Burgundy", "Bright green");
            triproutedata = msg;
            globellooper = triproutedata.GlobelLooper;
            maxcount = triproutedata.GlobelLooper.length;

            for (var cnt = 0; cnt < triproutedata.vehicleslist.length; cnt++) {
                var flightPlanCoordinates = [];
                var ks = [];
                vehiclesarray[triproutedata.vehicleslist[cnt].vehicleno] = ks;
                //vehlogscount[triproutedata.vehicleslist[cnt].vehicleno] = 0;
                vehcolors[triproutedata.vehicleslist[cnt].vehicleno] = colors[cnt % colors.length];
               // allflightPlanCoordinates.push(ks);
            }

            //Load POIPoints
            odostatusv1 = true;
            odostatusv2 = true;
            document.getElementById("Lbl_firstvehiclekmans").innerHTML = "0";
            document.getElementById("Lbl_secondvehiclekmans").innerHTML = "0";
            document.getElementById("Lbl_firstvehiclekm").innerHTML = "";
            document.getElementById("Lbl_secondvehiclekm").innerHTML = "";
            clearInterval(interval);
            interval = setInterval(function () { timerlogs() }, 100);
        }

        var logcount = 0;
        var remcount = 0;
        var startodov1;
        var startodov2;
        var endodov1;
        var endodov2;
        var odostatusv1;
        var odostatusv2;        

        function timerlogs() {
            
            if (logcount < maxcount) {
                var searchlbl = globellooper[logcount];
                for (var cnt = 0; cnt < triproutedata.vehicleslist.length; cnt++) {

                    var getinfo = triproutedata.vehicleslist[cnt].logslist[searchlbl];
                    document.getElementById('lbl_logtime').innerHTML = searchlbl;
                    //odo
                    var v1 = triproutedata.vehicleslist[0].vehicleno;
                    var v2 = triproutedata.vehicleslist[1].vehicleno;
                    document.getElementById("Lbl_firstvehiclekm").innerHTML = v1.toString() + "  Today KM Traveled  :";
                    document.getElementById("Lbl_secondvehiclekm").innerHTML = v2.toString() + "  Today KM Traveled  :";
                    if (typeof getinfo !== "undefined") {
                        //odo
                        if (v1 == triproutedata.vehicleslist[cnt]) {
                            if (odostatusv1 && v1 == triproutedata.vehicleslist[cnt].vehicleno) {
                                                             
                                startodov1 = getinfo.odometer;
                                odostatusv1 = false;
                            }
                            else {
                                endodov1 = getinfo.odometer;
                            }
                        }
                        if (v2 == triproutedata.vehicleslist[cnt]) {
                            if (odostatusv2 && v2 == triproutedata.vehicleslist[cnt].vehicleno) {
                                
                                startodov2 = getinfo.odometer;
                                odostatusv2 = false;
                            }
                            else {
                                endodov2 = getinfo.odometer;
                            }
                        }
                        var flightPlanCoordinates1 = [];
                        flightPlanCoordinates1 = vehiclesarray[triproutedata.vehicleslist[cnt].vehicleno];
                        var Latitude = getinfo.latitude;
                        var Longitude = getinfo.longitude;
                        var point = new google.maps.LatLng(
              parseFloat(Latitude),
              parseFloat(Longitude));
                        var angle = getinfo.direction;
                        var iconsrc;
                        var VehicleType = "Car";
                        var imgangle;
                        VehicleType = "green" + VehicleType;
                        if (angle >= 0 && angle < 22.5) {
                            imgangle = 0;
                            iconsrc = "VehicleTypes/" + VehicleType + "4.png";
                        }
                        else if (angle >= 22.5 && angle < 45) {
                            imgangle = 22.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "5.png";
                        }
                        else if (angle >= 45 && angle < 67.5) {
                            imgangle = 45.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "6.png";
                        }
                        else if (angle >= 67.5 && angle < 90) {
                            imgangle = 67.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "7.png";
                        }
                        else if (angle >= 90 && angle < 112.5) {
                            imgangle = 90.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "8.png";
                        }
                        else if (angle >= 112.5 && angle < 135) {
                            imgangle = 112.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "9.png";
                        }
                        else if (angle >= 135 && angle < 157.5) {
                            imgangle = 135.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "10.png";
                        }
                        else if (angle >= 157.5 && angle < 180) {
                            imgangle = 157.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "11.png";
                        }
                        else if (angle >= 180 && angle < 202.5) {
                            imgangle = 180.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "12.png";
                        }
                        else if (angle >= 202.5 && angle < 225) {
                            imgangle = 202.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "13.png";
                        }
                        else if (angle >= 225 && angle < 247.5) {
                            imgangle = 225.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "14.png";
                        }
                        else if (angle >= 247.5 && angle < 270) {
                            imgangle = 247.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "15.png";
                        }
                        else if (angle >= 270 && angle < 292.5) {
                            imgangle = 270.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "17.png";
                        }
                        else if (angle >= 292.5 && angle < 315) {
                            imgangle = 292.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "1.png";
                        }
                        else if (angle >= 315 && angle < 337.5) {
                            imgangle = 315.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "2.png";
                        }
                        else if (angle >= 337.5 && angle < 360) {
                            imgangle = 337.5;
                            iconsrc = "VehicleTypes/" + VehicleType + "3.png";
                        }
                        else if (angle >= 360) {
                            imgangle = 360;
                            iconsrc = "VehicleTypes/" + VehicleType + "3.png";
                        }

                        for (var i = 0; i < markersArray.length; i++) {
                            var vehmarker = markersArray[i];
                            if (markersArray[i].id == triproutedata.vehicleslist[cnt].vehicleno) {
                                markersArray[i].setMap(null);
                                markersArray.splice(i, 1);
                            }
                        }

                        var image = new google.maps.MarkerImage(iconsrc, null, new google.maps.Point(0, 0), new google.maps.Point(20, 20));
                        var marker = new google.maps.Marker({
                            position: point,
                            map: map,
                            center: location,
                            zoom: 12,
                            icon: image,
                            id: triproutedata.vehicleslist[cnt].vehicleno
                        });
                        if (panstatus) {
                            map.panTo(point);
                            panstatus = false;
                        }

                        markersArray.push(marker);
                        //attachInfowindow
                        attachInfowindow(marker, location, "VehicleID : " + triproutedata.vehicleslist[cnt].vehicleno + "<br/>" + "Route : " + triproutedata.vehicleslist[cnt].routename);

                        var point = new google.maps.LatLng(
                          parseFloat(Latitude),
                          parseFloat(Longitude));
                       // remcount = vehlogscount[triproutedata.vehicleslist[cnt].vehicleno];
                        flightPlanCoordinates1[getinfo.sno - remcount] = new google.maps.LatLng(Latitude, Longitude);
                        var clr = vehcolors[triproutedata.vehicleslist[cnt].vehicleno];
                        var polyOptions = {
                            path: flightPlanCoordinates1,
                            strokeColor: clr,
                            strokeOpacity: 1.0,
                            strokeWeight: 2
                        }
                        flightPath = new google.maps.Polyline(polyOptions);
                        flightPath.setMap(map);
                      //  polilinepath.push(flightPath);

                    }
                }
                logcount++;
            }
            else {
                clearInterval(interval);
                startodov1 = endodov1 - startodov1;
                startodov2 = endodov2 - startodov2;
                
                document.getElementById("Lbl_firstvehiclekmans").innerHTML = Math.round(startodov1).toString();
                document.getElementById("Lbl_secondvehiclekmans").innerHTML = Math.round(startodov2).toString();
            }
            
        }


        function attachInfowindow(marker, latlng, country) {
            var location = latlng;
            var boxText = document.createElement("div");
            boxText.style.cssText = "border: 1px solid black; margin-top: 8px; background: white; padding: 5px;";
            boxText.innerHTML = '<b>' + country + '</b><br />';

            var myOptions = {
                content: boxText
				, disableAutoPan: false
				, maxWidth: 0
				, pixelOffset: new google.maps.Size(-140, 0)
				, zIndex: null
				, boxStyle: {
				    background: "url('Images/tipbox.gif') no-repeat"
				  , opacity: 0.9
				  , width: "350px"
				}
				, closeBoxMargin: "10px 5px 0px 2px"
                , closeBoxURL: ""
				, infoBoxClearance: new google.maps.Size(1, 1)
				, isHidden: false
				, pane: "floatPane"
				, enableEventPropagation: false
            };


            var ib = new InfoBox(myOptions);
            //var infowindow = new google.maps.InfoWindow({ content: '<b>' + description + '</b><br />' + location });
            google.maps.event.addListener(marker, 'mouseover', function () {
                //infowindow.open(map,marker);
                ib.open(map, marker);
            });
            google.maps.event.addListener(marker, 'mouseout', function () {
                //infowindow.close();
                ib.close();
            });
        }





        function PrevValidating() {
            var speed = $("#speedval").val();
            if (speed == "speed") {
                speed = 3;
            }
            if (speed > 1) {
                speed--;
            }
            $("#speedval").val(speed);
            //            var btnshow = document.getElementById('btnShow').innerHTML;
            //            if (btnshow == 'Pause') {

            if (speed == 1) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 2000);
            }
            else if (speed == 2) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 1500);
            }
            else if (speed == 3) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 1000);
            }
            else if (speed == 4) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 500);
            }
            else if (speed == 5) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 300);
            }
            else if (speed == 6) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 100);
            }
            //            }
            return false;
        }

        function NextValidating() {
            var speed = $("#speedval").val();
            if (speed == "speed") {
                speed = 3;
            }
            if (speed < 6) {
                speed++;
            }
            $("#speedval").val(speed);
            //  var btnshow = document.getElementById('btnShow').innerHTML;
            // if (btnshow == 'Pause') {
            if (speed == 1) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 2000);
            }
            else if (speed == 2) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 1500);
            }
            else if (speed == 3) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 1000);
            }
            else if (speed == 4) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 500);
            }
            else if (speed == 5) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 300);
            }
            else if (speed == 6) {
                clearInterval(interval);
                interval = setInterval(function () { timerlogs() }, 100);
            }
            //            }
            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width: 100%; height: 100%;">
        <div class="togglediv" id="divid_comparison">
            <div class="inner">
                <img id="btnClose" alt="" src="Images/bigleft.png" title="Hide" style="float: right;
                    border: 1px solid #d5d5d5; width: 35px; height: 35px; background-color: #ffffff;" />
                <table>
                    <tr>
                        <td>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <label id="lbl_vehicleType">
                                            VehicleType</label>
                                    </td>
                                    <td>
                                        <select id="ddlType" class="form-control" onchange="Load_vehicle()" style="width: 200px;">
                                            <option>Select Vehicle Type</option>
                                            <option>ALL</option>
                                            <option>Puff</option>
                                            <option>Tanker</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label id="lbl_firstvehicles">
                                            First Vehicle</label>
                                    </td>
                                    <td>
                                        <select id="ddl_firstvehicles" style="width: 200px;">
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label id="Label1">
                                            First Vehicle</label>
                                    </td>
                                    <td>
                                        <select id="ddl_secondvehicles" style="width: 200px;">
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label id="lbl_ReportDate">
                                            ReplayDate
                                        </label>
                                    </td>
                                    <td>
                                        <input id="txt_ReportDate" type="date" style="width: 185px; height: 22px; font-size: 13px;
                                            padding: .2em .4em; border: 1px solid gray; border-radius: 4px 4px 4px 4px;" />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <input type="button" id="btn_generate" class="ContinueButton" value="Get Data" style="height: 25px;
                                            width: 100px;" onclick="btn_generate_Click();" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Label ID="lbl_informationDisplay" runat="server" ForeColor="Red" Text=""></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <table cellpadding="0" cellspacing="0" style="border: 1px solid #d5d5d5; width: 55px;
                                            height: 22px; border-radius: 3px 3px 3px 3px;">
                                            <tr>
                                                <td>
                                                    <button id="precday" class="datebuttonsleft" onclick="return PrevValidating();">
                                                    </button>
                                                </td>
                                                <td>
                                                    <input type="text" style="width: 40px; padding: .2em .0em; height: 21px; border-top: 0px solid #ffffff;
                                                        text-align: center; border-bottom: 0px solid #ffffff; border-left: 1px solid #d5d5d5;
                                                        border-right: 1px solid #d5d5d5; font-size: 13px;" readonly="readonly" id="speedval"
                                                        value="speed" />
                                                </td>
                                                <td>
                                                    <button id="nextday" class="datebuttonsright" onclick="return NextValidating();">
                                                    </button>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <br />
                                    </td>
                                </tr>
                    <tr>
                        <td colspan="2">
                            <label id="Lbl_firstvehiclekm" style="color:Green;"></label> 
                             <label id="Lbl_firstvehiclekmans" style="color:Red; "></label>                               
                        </td>
                        
                    </tr>
                    <tr>
                        <td colspan="2">
                            <label id="Lbl_secondvehiclekm" style="color:Green;"></label>
                             <label id="Lbl_secondvehiclekmans" style="color:Red;"></label>
                                
                        </td>
                        
                    </tr>
                    </table> </td> </tr>
                </table>
            </div>
        </div>
        <div id="mapcontent">
            <div id="googleMap" style="width: 100%; height: 100%; position: absolute; background-color: rgb(229,227,223);">
            </div>
        </div>
    </div>
</asp:Content>
