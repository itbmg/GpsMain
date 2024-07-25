<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LiveTracking.aspx.cs" Inherits="LiveTracking" %>

 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <script src="Newjs/markerclusterer_GZ.js?v=1502" type="text/javascript"></script>
    <script src="JSF/jquery.min.js" type="text/javascript"></script>    
    <script src="JSF/jquery-ui.js" type="text/javascript"></script>
   <script src="js/jquery-ui-1.10.3.custom.min.js?v=1502" type="text/javascript"></script>
   <script src="js/jquery.json-2.4.js?v=1502" type="text/javascript"></script>
    <link href="css/font-awesome.min.css" rel="stylesheet">    
    <link href="css/custom.css" rel="stylesheet" type="text/css" />    
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCNJQwYwI1XH2nQzqszGuv5WKpkjNzY-Z8&v=3.exp&libraries=geometry&sensor=false"></script>
    <%--<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyDGYPgYpwZ4ZQCLCAujetDwArlVBC_S9TI&sensor=false"></script>--%>
    <script src="Newjs/infobox.js?v=1502" type="text/javascript"></script>
    <style type="text/css">
        #mymap
        {
            width: 100%;
            height: 600px;
        }
         div#mapcontent
        {
            right: 0;
            bottom: 0;
            left: 0px;
            top: 50px;
            overflow: hidden;
            position: absolute;
        }
        
        .bpmouseover
        {
            height: 430px;
            width: 250px;
            display: none;
            position: absolute;
            z-index: 99999;
            padding: 10px 5px 5px 15px;
            background-color: #fffffc;
            border: 1px solid #c0c0c0;
            border-radius: 3px 3px 3px 3px;
            box-shadow: 3px 3px 3px rgba(0,0,0,0.3);
            font-family: Verdana;
            font-size: 12px;
            opacity: 1.0;
        }
    </style>
    <script type="text/javascript">
        var geocoder;
        var map;
        var circle;
        var mapDiv;
        var mapOptions;
        var marker;
        var Latp;
        var Longp;
        var lat;
        var long;
        var Idp;   
        var Id;     
        var Radiousp;
        var myVar;
        var count = 0;
        var infoWindow = new google.maps.InfoWindow();
        var infoWindowall = new google.maps.InfoWindow();
        var attinfoWindow = new google.maps.InfoWindow();
        var flightPlanCoordinates = new Array();
        var ib = new InfoBox();
        var ServerDate;

        function init() {          

            lat = 12.008477318659862;
            long = 79.65307331968529;
            Id = "AP26TB4257";

            Latp = getParameterByName("lat");
            Longp = getParameterByName("long");
            Idp = getParameterByName("Id");

            if (Idp != "") {
                document.getElementById('txt_vehicleno').value = Idp;
                Latp = lat;
                Longp = long;
            }
            else {
                document.getElementById('txt_vehicleno').value = Id;
                Latp = lat;
                Longp = long;
            }
            geocoder = new google.maps.Geocoder();
            mapDiv = document.getElementById("mymap");
            mapOptions = {
                center: new google.maps.LatLng(parseFloat(Latp), parseFloat(Longp)),
                Zoom: 15,
                panControl: true,
                panControlOptions: {
                    position: google.maps.ControlPosition.RIGHT_TOP
                },
                zoomControl: true,
                zoomControlOptions: {
                    style: google.maps.ZoomControlStyle.LARGE,
                    position: google.maps.ControlPosition.RIGHT_TOP
                },
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(mapDiv, mapOptions);
        }

        $(function () {
            document.getElementById("ddlselectvehicle").style.display = "none";
            document.getElementById("txt_vehicleno").style.display = "none";
            Getloginvehicles();
        });


        function Getloginvehicles() {
            var data = { 'op': 'Getloginvehicles' };
            var s = function (msg) {
                if (msg) {
                    bindingloginvehicles(msg);
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            

            callHandler(data, s, e);
            myVar = setInterval(function () { LiveTracking() }, 20000);
        }


        function bindingloginvehicles(msg) {
            var data = document.getElementById('ddlselectvehicle');
            var length = data.options.length;
            document.getElementById('ddlselectvehicle').options.length = null;
            var opt = document.createElement('option');
            opt.innerHTML = "select Plantname";
            opt.value = "select Plantname";
            data.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (msg[i].vehicleid != null) {
                    var option = document.createElement('option');
                    option.innerHTML = msg[i].vehicleid;
                    option.value = msg[i].vehicleid;
                    data.appendChild(option);
                }
            }
        }


        function LiveTracking() {
            var info;
            count += 1;

            var vehicleid = document.getElementById('txt_vehicleno').value;
            
            vehicleid = vehicleid;               
            var rd = "2000";
            if (rd.length > 0) {
                rd = parseInt(rd);
                rd = rd;
            }
            else {
                rd = 20000;
            }
            var data = { 'op': 'GetonlineLatLong', 'vehicleid': vehicleid };
            var s = function (msg) {
                if (msg.length > 0) {
                    //deleteOverlays();
                    onlinelatlng_pos = [];
                    info = msg;
                    for (var i = 0; i < info.length; i++) {
                        var Lat = msg[i].Lat;
                        var Long = msg[i].Long;
                        var address = msg[i].address;
                        var speed = msg[i].speed;
                        var diesel = msg[i].diesel;
                        var odo = msg[i].odo;
                        var updatedata = msg[i].updatetime;
                        var stoppedtime = msg[i].stoppedtime;
                        var direction = msg[i].direction;
                        var drvername = msg[i].drivername;
                        var mobileno = msg[i].mobileno;
                        var capacity = msg[i].capacity;
                        var vehiclemake = msg[i].vehiclemake;
                        var date = msg[i].serverdate.split(" ")[0];
                        var datevalues = new Array();
                        var timevalues = new Array();
                        if (date == "0") {
                        }
                        else {
                            var time = msg[i].serverdate.split(" ")[1];
                            datevalues = date.split('/');
                            timevalues = time.split(':');
                        }
                        ServerDate = new Date(datevalues[2], datevalues[1] - 1, datevalues[0], timevalues[0], timevalues[1], timevalues[2]);
                        var VehicleType = "Car";
                        VehicleType = msg[i].vehicleType;


                        Latp = parseFloat(Lat);
                        Longp = parseFloat(Long);
                        Radiousp = rd;

                        var myLatLng = new google.maps.LatLng(
              parseFloat(Lat),
              parseFloat(Long));

                        //
                        var todaydate;
                        try {
                            var date = updatedata.split(" ")[0];
                            var datevalues = new Array();
                            var timevalues = new Array();
                            if (date == "0") {
                            }
                            else {
                                var time = updatedata.split(" ")[1];
                                datevalues = date.split('/');
                                timevalues = time.split(':');
                            }

                            var updatetime = new Date(datevalues[2], datevalues[1] - 1, datevalues[0], timevalues[0], timevalues[1], timevalues[2]);
                            todaydate = ServerDate;
                            var _MS_PER_DAY = 86400000;
                            var _MS_PER_aaa = 3600000;
                            var _MS_PER_sss = 60000;
                            var _MS_PER_ddd = 1000;
                            var days = Math.floor((todaydate - updatetime) / _MS_PER_DAY);
                            var hours = Math.floor((todaydate - updatetime) / _MS_PER_aaa);
                            if (hours > 24) {
                                hours = hours % 24;
                            }
                            var min = Math.floor((todaydate - updatetime) / _MS_PER_sss);
                            if (min > 60) {
                                min = min % 60;
                            }
                            var sec = Math.floor((todaydate - updatetime) / _MS_PER_ddd);
                            if (sec > 60) {
                                sec = sec % 60;
                            }
                            var timestamp;
                            if (days >= 1) {
                                timestamp = "No Update form " + days + " days " + hours + " Hrs " + min + " Min";
                            }
                            else if (hours > 1) {
                                timestamp = "No Update form " + hours + " Hrs " + min + " Min";
                            }
                            else if (min < 10) {

                                timestamp = min + " Min " + sec + " Sec Back Update";
                            }
                            else if (days < 1) {
                                timestamp = "There is no Update form " + hours + " Hrs " + min + " Min";
                            }

                        }
                        catch (Error) {
                        }

                        var stpdtimestamp = "0 Min";
                        var stoppeddate = stoppedtime;
                        if (speed == 0 && stoppeddate != "") {
                            try {
                                var stpddate = stoppeddate.split(" ")[0];
                                var stpdtime = stoppeddate.split(" ")[1];
                                var stpddatevalues = new Array();
                                var stpdtimevalues = new Array();
                                stpddatevalues = stpddate.split('/');
                                stpdtimevalues = stpdtime.split(':');
                                var stpdupdatetime = new Date(stpddatevalues[2], stpddatevalues[1] - 1, stpddatevalues[0], stpdtimevalues[0], stpdtimevalues[1], stpdtimevalues[2]);
                                var _MS_PER_DAY = 86400000;
                                var _MS_PER_aaa = 3600000;
                                var _MS_PER_sss = 60000;
                                var _MS_PER_ddd = 1000;
                                var days = Math.floor((updatetime - stpdupdatetime) / _MS_PER_DAY);
                                var hours = Math.floor((updatetime - stpdupdatetime) / _MS_PER_aaa);
                                if (hours > 24) {
                                    hours = hours % 24;
                                }
                                var min = Math.floor((updatetime - stpdupdatetime) / _MS_PER_sss);
                                if (min > 60) {
                                    min = min % 60;
                                }
                                var sec = Math.floor((updatetime - stpdupdatetime) / _MS_PER_ddd);
                                if (sec > 60) {
                                    sec = sec % 60;
                                }
                                if (days >= 1) {
                                    stpdtimestamp = days + " days " + hours + " Hrs " + min + " Min";
                                }
                                else if (hours > 1) {
                                    stpdtimestamp = hours + " Hrs " + min + " Min";
                                }
                                else if (min < 10) {
                                    stpdtimestamp = min + " Min " + sec + " Sec";
                                }
                                else if (days < 1) {
                                    stpdtimestamp = hours + " Hrs " + min + " Min";
                                }
                            }
                            catch (Error) {
                            }
                        }
                        //


                        var iconsrc;

                        if (typeof VehicleType === "undefined") {
                            VehicleType = "Car";
                        }
                        if (VehicleType == 'LMV') {
                            VehicleType = "Car";
                        }

                        if (VehicleType == 'Escavator') {
                            iconsrc = "VehicleTypes/" + VehicleType + ".png";
                        }
                        else
                            if (VehicleType == "Roller") {
                                if (speed == 0) {
                                    VehicleType = "red" + VehicleType;
                                    iconsrc = "VehicleTypes/" + VehicleType + ".png";
                                }
                                else {
                                    VehicleType = "green" + VehicleType;
                                    iconsrc = "VehicleTypes/" + VehicleType + ".png";
                                }
                            }
                            else {
                                if (VehicleType == "") {
                                    VehicleType = "Car";
                                }
                                if (speed == 0) {
                                    if (VehicleType == "Truck") {
                                        VehicleType = "Tanker";
                                        VehicleType = "red" + VehicleType;
                                    }
                                    else {
                                        VehicleType = "red" + VehicleType;
                                    }
                                    //                                iconsrc = "VehicleTypes/" + VehicleType + ".png";
                                }
                                else {
                                    if (VehicleType == "Truck") {
                                        VehicleType = "Tanker";
                                        VehicleType = "green" + VehicleType;
                                    }
                                    else {
                                        VehicleType = "green" + VehicleType;
                                    }

                                }
                            }


                        if (direction >= 0 && direction < 22.5) {
                            iconsrc = "VehicleTypes/" + VehicleType + "4.png";
                        }
                        else if (direction >= 22.5 && direction < 45) {
                            iconsrc = "VehicleTypes/" + VehicleType + "5.png";
                        }
                        else if (direction >= 45 && direction < 67.5) {
                            iconsrc = "VehicleTypes/" + VehicleType + "6.png";
                        }
                        else if (direction >= 67.5 && direction < 90) {
                            iconsrc = "VehicleTypes/" + VehicleType + "7.png";
                        }
                        else if (direction >= 90 && direction < 112.5) {
                            iconsrc = "VehicleTypes/" + VehicleType + "8.png";
                        }
                        else if (direction >= 112.5 && direction < 135) {
                            iconsrc = "VehicleTypes/" + VehicleType + "9.png";
                        }
                        else if (direction >= 135 && direction < 157.5) {
                            iconsrc = "VehicleTypes/" + VehicleType + "10.png";
                        }
                        else if (direction >= 157.5 && direction < 180) {
                            iconsrc = "VehicleTypes/" + VehicleType + "11.png";
                        }
                        else if (direction >= 180 && direction < 202.5) {
                            iconsrc = "VehicleTypes/" + VehicleType + "12.png";
                        }
                        else if (direction >= 202.5 && direction < 225) {
                            iconsrc = "VehicleTypes/" + VehicleType + "13.png";
                        }
                        else if (direction >= 225 && direction < 247.5) {
                            iconsrc = "VehicleTypes/" + VehicleType + "14.png";
                        }
                        else if (direction >= 247.5 && direction < 270) {
                            iconsrc = "VehicleTypes/" + VehicleType + "15.png";
                        }
                        else if (direction >= 270 && direction < 292.5) {
                            iconsrc = "VehicleTypes/" + VehicleType + "16.png";
                        }
                        else if (direction >= 292.5 && direction < 315) {
                            iconsrc = "VehicleTypes/" + VehicleType + "1.png";
                        }
                        else if (direction >= 315 && direction < 360) {
                            iconsrc = "VehicleTypes/" + VehicleType + "2.png";
                        }
                        else if (direction >= 360) {
                            iconsrc = "VehicleTypes/" + VehicleType + "3.png";
                        }
                        //

                        var point = new google.maps.LatLng(parseFloat(Lat), parseFloat(Long));
                        flightPlanCoordinates.push(point);

                        var flightPath = new google.maps.Polyline({
                            path: flightPlanCoordinates,
                            geodesic: true,
                            strokeColor: '#FF0000',
                            strokeOpacity: 1.0,
                            strokeWeight: 2
                        });

                        flightPath.setMap(map);
                        //
                        placeMarkerlocations(myLatLng, iconsrc, rd, vehicleid, speed, drvername, mobileno, capacity, vehiclemake, timestamp, stpdtimestamp);
                        onlinelatlng_pos.push(myLatLng);
                    }
                }
                else {
                    // alert('Please,Check the Vehicle Details');
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

        var onlinemarkersArray = [];
        var onlineinfoWindow = new google.maps.InfoWindow();

        function placeMarkerlocations(location, iconsrc, radius,vehicleid,speed,drname,drmobileno,capacity,vehiclemake,updatestatus,stoppedfrom) {

            var image = new google.maps.MarkerImage(iconsrc,
            // This marker is 20 pixels wide by 32 pixels tall.
    null,
            // The origin for this image is 0,0.
    new google.maps.Point(0, 0),
            // The anchor for this image is the base of the flagpole at 0,32.
    new google.maps.Point(20, 20)
);

            for (var i = 0; i < onlinemarkersArray.length; i++) {
                onlinemarkersArray[i].setMap(null);
            }

            var marker = new google.maps.Marker({
                position: location,
                map: map,                
                center: location,
                zoom: 15,
                icon: image,
                title: vehicleid
            });
            map.panTo(location);
            onlinemarkersArray.push(marker);

            // INFO WINDOW ALWAYS

//            var content = "VehicleID : " + vehicleid + "<br/>" + "Speed :" + speed + "<br/>";
//            infoWindowall = new google.maps.InfoWindow({
//                content: content
//            });
//            infoWindowall.open(map, marker);

            //
          

            var address;
            geocoder = new google.maps.Geocoder();
            infoWindow.close();
            address = geocoder.geocode({ 'latLng': location }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results.length > 0) {
                        if (results[0]) {
                            address = results[0].formatted_address;

                            var content = "VehicleID : " + vehicleid + "<br/>" + "Vehicle Make : " + vehiclemake + "<br/>" + "Capacity : " + capacity + "<br/>" + "Address : " + address + "<br/>" + "Destination : " + "Plant" + "<br/>" + "DriverName : " + drname + "<br/>" + "Phone No : " + drmobileno + "<br/>" + "Speed : " + speed + "<br/>" + "Update Status : " + updatestatus + "<br/>" + "Stopped From : " + stoppedfrom + "<br/>";
                            var infowindow = new google.maps.InfoWindow({
                                content: content
                            });

                            google.maps.event.addListener(marker, 'click', function () {
                                infowindow.open(map, marker);
                            });
                            attachInfowindow(marker, location,speed, "VehicleID : " + vehicleid + "<br/>" + "Vehicle Make : " + vehiclemake + "<br/>" + "Capacity : " + capacity + "<br/>" + "Address : " + address + "<br/>" + "Destination : " + "Plant" + "<br/>" + "DriverName : " + drname + "<br/>" + "Phone No : " + drmobileno + "<br/>" + "Speed : " + speed + "<br/>" + "Update Status : " + updatestatus + "<br/>" + "Stopped From : " + stoppedfrom + "<br/>");
                        }
                        else {
                            address = "No results";

                            var content = "VehicleID : " + vehicleid + "<br/>" + "Vehicle Make : " + vehiclemake + "<br/>" + "Capacity : " + capacity + "<br/>" + "Address : " + address + "<br/>" + "Destination : " + "Plant" + "<br/>" + "DriverName : " + drname + "<br/>" + "Phone No : " + drmobileno + "<br/>" + "Speed : " + speed + "<br/>" + "Update Status : " + updatestatus + "<br/>" + "Stopped From : " + stoppedfrom + "<br/>";
                            var infowindow = new google.maps.InfoWindow({
                                content: content
                            });

                            google.maps.event.addListener(marker, 'click', function () {
                                infowindow.open(map, marker);
                            });
                            attachInfowindow(marker, location,speed, "VehicleID : " + vehicleid + "<br/>" + "Vehicle Make : " + vehiclemake + "<br/>" + "Capacity : " + capacity + "<br/>" + "Address : " + address + "<br/>" + "Destination : " + "Plant" + "<br/>" + "DriverName : " + drname + "<br/>" + "Phone No : " + drmobileno + "<br/>" + "Speed : " + speed + "<br/>" + "Update Status : " + updatestatus + "<br/>" + "Stopped From : " + stoppedfrom + "<br/>");
                        }
                    }
                    else {
                        address = "No results";

                        var content = "VehicleID : " + vehicleid + "<br/>" + "Vehicle Make : " + vehiclemake + "<br/>" + "Capacity : " + capacity + "<br/>" + "Address : " + address + "<br/>" + "Destination : " + "Plant" + "<br/>" + "DriverName : " + drname + "<br/>" + "Phone No : " + drmobileno + "<br/>" + "Speed : " + speed + "<br/>" + "Update Status : " + updatestatus + "<br/>" + "Stopped From : " + stoppedfrom + "<br/>";
                        var infowindow = new google.maps.InfoWindow({
                            content: content
                        });

                        google.maps.event.addListener(marker, 'click', function () {
                            infowindow.open(map, marker);
                        });
                        attachInfowindow(marker, location,speed, "VehicleID : " + vehicleid + "<br/>" + "Vehicle Make : " + vehiclemake + "<br/>" + "Capacity : " + capacity + "<br/>" + "Address : " + address + "<br/>" + "Destination : " + "Plant" + "<br/>" + "DriverName : " + drname + "<br/>" + "Phone No : " + drmobileno + "<br/>" + "Speed : " + speed + "<br/>" + "Update Status : " + updatestatus + "<br/>" + "Stopped From : " + stoppedfrom + "<br/>");
                    }
                }
                else {
                    address = "No results";

                    var content = "VehicleID : " + vehicleid + "<br/>" + "Vehicle Make : " + vehiclemake + "<br/>" + "Capacity : " + capacity + "<br/>" + "Address : " + address + "<br/>" + "Destination : " + "Plant" + "<br/>" + "DriverName : " + drname + "<br/>" + "Phone No : " + drmobileno + "<br/>" + "Speed : " + speed + "<br/>" + "Update Status : " + updatestatus + "<br/>" + "Stopped From : " + stoppedfrom + "<br/>";


                    var infowindow = new google.maps.InfoWindow({
                        content: content
                    });

                    google.maps.event.addListener(marker, 'click', function () {
                        infowindow.open(map, marker);
                    });
                    attachInfowindow(marker, location,speed, "VehicleID : " + vehicleid + "<br/>" + "Vehicle Make : " + vehiclemake + "<br/>" + "Capacity : " + capacity + "<br/>" + "Address : " + address + "<br/>" + "Destination : " + "Plant" + "<br/>" + "DriverName : " + drname + "<br/>" + "Phone No : " + drmobileno + "<br/>" + "Speed : " + speed + "<br/>" + "Update Status : " + updatestatus + "<br/>" + "Stopped From : " + stoppedfrom + "<br/>");
                }
            });
          
        }



        function attachInfowindow(marker, latlng, speed, country) {
           
            var place = latlng;
            var boxText = document.createElement("div");
            if (speed > 0) {
                boxText.style.cssText = "border: 2px solid black; margin-top: 10px; background: white; padding: 5px; color: green;";
            }
            else {
                boxText.style.cssText = "border: 2px solid black; margin-top: 10px; background: white; padding: 5px; color: Red;";
            }
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
				  , width: "200px"
				}
				, closeBoxMargin: "10px 5px 0px 2px"
                , closeBoxURL: ""
				, infoBoxClearance: new google.maps.Size(1, 1)
				, isHidden: false
				, pane: "floatPane"
				, enableEventPropagation: false
            };


//            infoWindowall = new google.maps.InfoWindow({
//                content: boxText
//            });
//            infoWindowall.open(map, marker);

            ib.close(map, marker);
            ib = new InfoBox(myOptions);            
            ib.open(map, marker);
            //var infowindow = new google.maps.InfoWindow({ content: '<b>' + description + '</b><br />' + location });
//            attinfoWindow = new google.maps.InfoWindow({
//                content: boxText
//            });

            google.maps.event.addListener(marker, 'mouseover', function () {
                //  attinfoWindow.open(map,marker);
                if (ib.open == true) {
                    ib.close(map, marker);
                }
                else {
                    ib.close();
                    ib.open(map, marker);
                }

            });
            google.maps.event.addListener(marker, 'mouseout', function () {
               // attinfoWindow.close();
                //ib.close();
            });
        }



        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }
        function replaceQueryString(url, param, value) {
            var re = new RegExp("([?|&])" + param + "=.*?(&|$)", "i");
            if (url.match(re))
                return url.replace(re, '$1' + param + "=" + value + '$2');
            else
                return url + '&' + param + "=" + value;
        }


        // Deletes all markers in the array by removing references to them.
        function deleteOverlays() {
            clearOverlays();
            markersArray = [];
        }

        // Removes the overlays from the map, but keeps them in the array.
        function clearOverlays() {
            setAllMap(null);
        }

        // Sets the map on all markers in the array.
        function setAllMap(googlemap) {
            for (var i = 0; i < markersArray.length; i++) {
                markersArray[i].setMap(googlemap);
            }
        }



        google.maps.event.addDomListener(window, 'load', init);
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Button ID="btn" runat="server" Text="Download" onclick="btn_Click" />
    <asp:Label ID="Err_msg" Text="" runat="server"></asp:Label>
    <div style="width: 100%;">
    <input type="text" id="txt_vehicleno" />
    <select id="ddlselectvehicle" class="form-control"  onchange="LiveTracking()"></select>
            <div id="mapcontent">
                <div id="mymap" style="width: 100%; height: 100%; position: relative; background-color: rgb(229, 227, 223);">
                </div>
            </div>
        </div>   
  
    </form>
</body>
</html>
