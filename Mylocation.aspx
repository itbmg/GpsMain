<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Mylocation.aspx.cs" Inherits="Mylocation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" type="text/css" href="dist/css/AdminLTE.css" />
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">     
     <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDbt9z3InHbzrV66t1eSZB5TnlJ2HQ-Uc8&v=3.exp&sensor=false"></script>
    <!-- iCheck -->
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
        .googleMapcls
        {
            width: 100%;
            height: 450px;
            position: relative;
            overflow: hidden;
        }
        th
        {
            text-align: center;
        }
        td
        {
            text-align: center;
        }
        .form-group
        {
            margin-bottom: 1px;
        }
        *
        {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }
    </style>
    <script src="js/jquery.blockUI.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);
            getgridlocations();
        });


        var map;
        var Maptype;
        var zoomLevel = 15;
        function initialize() {

            var lat = 17.497535;
            var lng = 78.408622;

            var latstr = getParameterByName("lat");
            var lngstr = getParameterByName("long");

            if (latstr != "" && lngstr != "") {
                lat = latstr;
                lng = lngstr;
                document.getElementById('txt_Latitude').value = lat;
                document.getElementById('txt_Longitude').value = lng;

            }
            var myLatlng = new google.maps.LatLng(lat, lng);
            Maptype = google.maps.MapTypeId.ROADMAP;
            var myOptions = {
                zoom: 15,
                center: myLatlng,
                mapTypeId: Maptype
            }
            map = new google.maps.Map(document.getElementById("googleMap"), myOptions);

            var marker = new google.maps.Marker({
                draggable: true,
                position: myLatlng,
                map: map,
                title: "Your location"
            });
            markersArray.push(marker);

            google.maps.event.addListener(marker, "dragend", function (event) {

                var lat = event.latLng.lat();
                var lng = event.latLng.lng();
                document.getElementById('txt_Latitude').value = lat;
                document.getElementById('txt_Longitude').value = lng;

            });

            google.maps.event.addListener(map, 'maptypeid_changed', function () {
                Maptype = map.getMapTypeId();
            });

            google.maps.event.addListener(map, 'zoom_changed', function () {
                zoomLevel = map.getZoom();
            });
            //            google.maps.event.addListener(marker, 'click', function (event) {

            //            });
            //            var circle = new google.maps.Circle({
            //                map: map,
            //                radius: 16093    // 10 miles in metres fillColor: '#AA0000'
            //               
            //            });
            //            circle.bindTo('center', marker, 'position');

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
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
    <script type="text/javascript">
        function saveclick() {
            var txtlocacationname = document.getElementById('txt_LocationName').value;
            var txtDescription = document.getElementById('txt_Description').value;
            var txtlatitude = document.getElementById('txt_Latitude').value;
            var txtlongitude = document.getElementById('txt_Longitude').value;
            var txtphonenum = document.getElementById('txt_PhoneNumber').value;
            var txtMyLocationRadious = document.getElementById('txt_Mylocation_Radious').value;
            var txtplantname = document.getElementById('ddlPlantName').value;
            var ckplnt = document.getElementById("ckb_isplant").checked;
            if (ckplnt == true) {
                ckbisplant = "1";
            }
            else {
                ckbisplant = "0";
            }
            if (txtlocacationname == "") {
                alert("Please Enter locacation Name");
                return false;
            }
            if (txtDescription == "") {
                alert("Please Enter Description");
                return false;
            }
            if (txtlatitude == "") {
                alert("Please Enter latitude");
                return false;
            }
            if (txtlongitude == "") {
                alert("Please Enter longitude");
                return false;
            }
            if (txtMyLocationRadious == 0) {
                alert("Please Enter Radious");
                return false;
            }
            var Imagepath = document.getElementById('txt_Image').value;
            var btnval = document.getElementById('btn_Mylocation_save').value;
            var Data = { 'op': 'MylocationSaveClick', 'txtlocacationname': txtlocacationname, 'txtDescription': txtDescription, 'txtlatitude': txtlatitude, 'txtlongitude': txtlongitude, 'txtMyLocationRadious': txtMyLocationRadious, 'txtplantname': txtplantname, 'txtphonenum': txtphonenum, 'ckbisplant': ckbisplant, 'btnval': btnval, 'refno': refno, 'Imagepath': Imagepath };
            var s = function (msg) {
                if (msg) {
                    alert(msg);
                    getgridlocations();
                    BtnMyLocatoinRefresh_Click();
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            callHandler(Data, s, e);
        }
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
        var marker;
        var markersArray = [];
        function PointsAdd() {
            var lat = document.getElementById('txt_Latitude').value;
            var log = document.getElementById('txt_Longitude').value;

            var myLatlng = new google.maps.LatLng(lat, log);

            var myOptions = {
                zoom: zoomLevel,
                center: myLatlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }
            deleteOverlays();

            //map = new google.maps.Map(document.getElementById("googleMap"), myOptions);
            marker = new google.maps.Marker({
                draggable: true,
                position: myLatlng,
                map: map,
                title: "Your location"
            });
            markersArray.push(marker);

            //            var circle = new google.maps.Circle({
            //                map: map,
            //                radius: rad    // 10 miles in metres fillColor: '#AA0000'

            //            });
            //            circle.bindTo('center', marker, 'position');
            rad = document.getElementById('txt_Mylocation_Radious').value;
            var rrr = parseInt(rad, rrr);
            var circle = new google.maps.Circle({
                map: map,
                zoom: 16,
                radius: rrr,    // 10 miles in metres
                strokeColor: "#FFffff",
                fillColor: "#FF0000",
                fillOpacity: 0.35,
                strokeWeight: 1,
                strokeOpacity: 0
            });
            circle.bindTo('center', marker, 'position');
            markersArray.push(circle);
            map.panTo(myLatlng);

            google.maps.event.addListener(marker, "dragend", function (event) {

                var lat = event.latLng.lat();
                var lng = event.latLng.lng();
                document.getElementById('txt_Latitude').value = lat;
                document.getElementById('txt_Longitude').value = lng;
            });
        }
        var rad = 0;
        function Setradious() {
            deleteOverlays();
            var lat = document.getElementById('txt_Latitude').value;
            var log = document.getElementById('txt_Longitude').value;

            var myLatlng = new google.maps.LatLng(lat, log);
            marker = new google.maps.Marker({
                draggable: true,
                position: myLatlng,
                map: map,
                zoom: zoomLevel,
                title: "Your location"
            });
            map.panTo(myLatlng);
            markersArray.push(marker);
            google.maps.event.addListener(marker, "dragend", function (event) {

                var lat = event.latLng.lat();
                var lng = event.latLng.lng();
                document.getElementById('txt_Latitude').value = lat;
                document.getElementById('txt_Longitude').value = lng;
            });
            rad = document.getElementById('txt_Mylocation_Radious').value;
            var rrr = parseInt(rad, rrr);
            var circle = new google.maps.Circle({
                map: map,
                zoom: 16,
                radius: rrr,    // 10 miles in metres
                strokeColor: "#FFffff",
                fillColor: "#FF0000",
                fillOpacity: 0.35,
                strokeWeight: 1,
                strokeOpacity: 0
            });
            circle.bindTo('center', marker, 'position');
            markersArray.push(circle);
        }

        function deleteOverlays() {
            clearOverlays();
            markersArray = [];
        }

        // Sets the map on all markers in the array.
        function setAllMap(map) {
            for (var i = 0; i < markersArray.length; i++) {
                markersArray[i].setMap(map);
            }
        }

        // Removes the overlays from the map, but keeps them in the array.
        function clearOverlays() {
            setAllMap(null);
        }

        function BtnMyLocatoinRefresh() {
            deleteOverlays();
            var lat = 17.497535;
            var lng = 78.408622;
            var myLatlng = new google.maps.LatLng(lat, lng);
            var marker = new google.maps.Marker({
                draggable: true,
                position: myLatlng,
                map: map,
                title: "Your location"
            });

            google.maps.event.addListener(marker, "dragend", function (event) {

                var lat = event.latLng.lat();
                var lng = event.latLng.lng();
                document.getElementById('txt_Latitude').value = lat;
                document.getElementById('txt_Longitude').value = lng;

            });

            markersArray.push(marker);
            map.panTo(myLatlng);
        }
        var locationdata = [];
        function getgridlocations() {
            var data = { 'op': 'getgridlocations' };
            var s = function (msg) {
                if (msg) {
                    BindGrid(msg);
                    filldata(msg);
                    locationdata = msg;
                }
                else {
                }
            };
            var e = function (x, h, e) {
            };
            $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

            callHandler(data, s, e);
        }
        var compiledList = [];
        function filldata(msg) {
            //var compiledList = [];
            for (var i = 0; i < msg.length; i++) {
                var BranchID = msg[i].BranchID;
                compiledList.push(BranchID);
            }

//            $('#txt_locations').autocomplete({
//                source: compiledList,
//                change: locationchange,
//                autoFocus: true
//            });
        }

        function locationchange() {
            var location = document.getElementById('txt_locations').value;
            if (location == "") {
                var msg = locationdata;
                var results = '<div class="divcontainer" style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
                results += '<thead><tr><th scope="col"></th><th scope="col">Branch Name</th><th scope="col">Description</th><th scope="col">Latitude</th><th scope="col">Longitude</th><th scope="col">Phone Number</th><th scope="col">Radious</th><th scope="col">Plant Name</th><th scope="col">Is Plant</th></tr></thead></tbody>';
                for (var i = 0; i < msg.length; i++) {
                    results += '<tr><td><input id="btn_poplate" type="button"  onclick="getme(this)" name="submit" class="btn btn-success" value="Edit" /></td>';
                    results += '<td scope="row" class="1">' + msg[i].BranchID + '</td>';
                    results += '<td data-title="Code" class="2">' + msg[i].Description + '</td>';
                    results += '<td  data-title="Code" class="3">' + msg[i].Latitude + '</td>';
                    results += '<td class="4">' + msg[i].Longitude + '</td>';
                    results += '<td class="5">' + msg[i].PhoneNumber + '</td>';
                    results += '<td class="6">' + msg[i].Radious + '</td>';
                    results += '<td data-title="Code" class="7">' + msg[i].PlantName + '</td>';
                    results += '<td data-title="Code" class="8">' + msg[i].IsPlant + '</td>';
                    results += '<td style="display:none"  data-title="Code" class="10">' + msg[i].Imagepath + '</td>';
                    results += '<td style="display:none" class="9">' + msg[i].Sno + '</td></tr>';
                }
                results += '</table></div>';
                $("#div_Branchdata").html(results);
            }
            else {
                var msg = locationdata;
                var results = '<div class="divcontainer" style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
                results += '<thead><tr><th scope="col"></th><th scope="col">Branch Name</th><th scope="col">Description</th><th scope="col">Latitude</th><th scope="col">Longitude</th><th scope="col">Phone Number</th><th scope="col">Radious</th><th scope="col">Plant Name</th><th scope="col">Is Plant</th></tr></thead></tbody>';
                for (var i = 0; i < msg.length; i++) {
                    if (location == msg[i].BranchID) {
                        results += '<tr><td><input id="btn_poplate" type="button"  onclick="getme(this)" name="submit" class="btn btn-success" value="Edit" /></td>';
                        results += '<td scope="row" class="1">' + msg[i].BranchID + '</td>';
                        results += '<td data-title="Code" class="2">' + msg[i].Description + '</td>';
                        results += '<td  data-title="Code" class="3">' + msg[i].Latitude + '</td>';
                        results += '<td class="4">' + msg[i].Longitude + '</td>';
                        results += '<td class="5">' + msg[i].PhoneNumber + '</td>';
                        results += '<td class="6">' + msg[i].Radious + '</td>';
                        results += '<td data-title="Code" class="7">' + msg[i].PlantName + '</td>';
                        results += '<td data-title="Code" class="8">' + msg[i].IsPlant + '</td>';
                        results += '<td style="display:none"  data-title="Code" class="10">' + msg[i].Imagepath + '</td>';
                        results += '<td style="display:none" class="9">' + msg[i].Sno + '</td></tr>';
                    }
                }
                results += '</table></div>';
                $("#div_Branchdata").html(results);
            }
        }
        var BranchList = [];
        function BindGrid(msg) {
            var newarray = [];
            var Headarray = [];
            var headdatacol = msg[1];
            var datacol = msg;
            var plants = [];
            for (var i = 0; i < msg.length; i++) {
                var BranchID = msg[i].BranchID;
                BranchList.push(BranchID);
            }           

//            $('#txt_LocationName').autocomplete({
//                source: BranchList,
//                autoFocus: true
//            });
            var sel = document.getElementById('ddlPlantName');
            var opt = document.createElement('option');
            opt.innerHTML = "Select Plant";
            opt.value = "Select Plant";
            sel.appendChild(opt);
            for (var i = 0; i < msg.length; i++) {
                if (typeof msg[i] === "undefined" || msg[i].BranchID == "" || msg[i].BranchID == null) {
                }
                else {
                    if (plants.indexOf(msg[i].BranchID) == -1 && msg[i].IsPlant == "True") {
                        var plantname = msg[i].BranchID;
                        var PlantSno = msg[i].Sno;
                        plants.push(plantname);
                        var opt = document.createElement('option');
                        opt.innerHTML = plantname;
                        opt.value = PlantSno;
                        sel.appendChild(opt);
                    }
                }
                //                newarray.push({ 'BranchID': allroutesdata[i].BranchID, 'Description': allroutesdata[i].Description, 'Latitude': allroutesdata[i].Latitude, 'Longitude': allroutesdata[i].Longitude, 'PhoneNumber': allroutesdata[i].PhoneNumber, 'Radious': allroutesdata[i].Radious, 'Sno': allroutesdata[i].Sno, 'PlantName': allroutesdata[i].PlantName, 'IsPlant': allroutesdata[i].IsPlant });
            }
            var results = '<div class="divcontainer" style="overflow:auto;"><table class="table table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="example2_info">';
            results += '<thead><tr><th scope="col"></th><th scope="col">Branch Name</th><th scope="col">Description</th><th scope="col">Latitude</th><th scope="col">Longitude</th><th scope="col">Phone Number</th><th scope="col">Radious</th><th scope="col">Plant Name</th><th scope="col">Is Plant</th></tr></thead></tbody>';
            for (var i = 0; i < msg.length; i++) {
                results += '<tr><td><input id="btn_poplate" type="button"  onclick="getme(this)" name="submit" class="btn btn-success" value="Edit" /></td>';
                results += '<td scope="row" class="1">' + msg[i].BranchID + '</td>';
                results += '<td data-title="Code" class="2">' + msg[i].Description + '</td>';
                results += '<td  data-title="Code" class="3">' + msg[i].Latitude + '</td>';
                results += '<td class="4">' + msg[i].Longitude + '</td>';
                results += '<td class="5">' + msg[i].PhoneNumber + '</td>';
                results += '<td class="6">' + msg[i].Radious + '</td>';
                results += '<td data-title="Code" class="7">' + msg[i].PlantName + '</td>';
                results += '<td data-title="Code" class="8">' + msg[i].IsPlant + '</td>';
                results += '<td style="display:none"  data-title="Code" class="10">' + msg[i].Imagepath + '</td>';
                results += '<td style="display:none" class="9">' + msg[i].Sno + '</td></tr>';
            }
            results += '</table></div>';
            $("#div_Branchdata").html(results);
        }
        var refno = 0;
        function getme(thisid) {
            var BranchID = $(thisid).parent().parent().children('.1').html();
            var Description = $(thisid).parent().parent().children('.2').html();
            var Latitude = $(thisid).parent().parent().children('.3').html();
            var Longitude = $(thisid).parent().parent().children('.4').html();
            var PhoneNumber = $(thisid).parent().parent().children('.5').html();
            var Radious = $(thisid).parent().parent().children('.6').html();
            var PlantName = $(thisid).parent().parent().children('.7').html();
            var Sno = $(thisid).parent().parent().children('.9').html();
            var Imagepath = $(thisid).parent().parent().children('.10').html();
            var IsPlant = $(thisid).parent().parent().children('.8').html();
            document.getElementById('txt_LocationName').value = BranchID;
            document.getElementById('txt_Description').value = Description;
            document.getElementById('txt_Latitude').value = Latitude;
            document.getElementById('txt_Longitude').value = Longitude;
            document.getElementById('txt_PhoneNumber').value = PhoneNumber;
            document.getElementById('txt_Mylocation_Radious').value = Radious;
            document.getElementById('txt_Image').value = Imagepath;
            document.getElementById('ddlPlantName').value = PlantName;
            document.getElementById('btn_Mylocation_save').value = "Modify";
            refno = Sno;
            if (IsPlant == "True")
                document.getElementById("ckb_isplant").checked = true;
            else
                document.getElementById("ckb_isplant").checked = false;
            document.getElementById('btn_Mylocation_save').value = "Edit";
            Setradious();
        }
        function BtnMyLocatoinRefresh_Click() {
            refno = "";
            document.getElementById('txt_LocationName').value = "";
            document.getElementById('txt_Description').value = "";
            document.getElementById('txt_Latitude').value = "";
            document.getElementById('txt_Longitude').value = "";
            document.getElementById('txt_PhoneNumber').value = "";
            document.getElementById('txt_Mylocation_Radious').value = "";
            document.getElementById('ddlPlantName').selectedIndex = 0;
            document.getElementById("ckb_isplant").checked = false;
            document.getElementById('btn_Mylocation_save').value = "Add";
            document.getElementById('txt_Image').value = "";
        }
        function imageclick(thisid) {
            $('#txt_Image').val(thisid.title);
        }
        function deleteclick() {
            if (refno != "") {
                confirm("Do you want to delete this location?");
                {
                    var data = { 'op': 'deletelocation', 'refno': refno };
                    var s = function (msg) {
                        if (msg) {
                            alert(msg);
                            getgridlocations();
                        }
                        else {
                        }
                    };
                    var e = function (x, h, e) {
                    };
                    $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

                    callHandler(data, s, e);
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <br />
    <br />
    <br />
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="txt_LocationName">
                                    Location Name</label>
                                <input type="text" class="form-control" id="txt_LocationName" placeholder="Location Name">
                                <input type="checkbox" id="ckb_isplant" />
                                <span>Isplant</span>
                            </div>
                            <div class="form-group">
                                <label for="txt_Description">
                                    Description</label>
                                <input type="text" class="form-control" id="txt_Description" placeholder="Description">
                            </div>
                            <div class="form-group">
                                <label for="txt_Latitude">
                                    Latitude</label>
                                <input type="number" class="form-control" id="txt_Latitude" placeholder="Latitude">
                            </div>
                            <div class="form-group">
                                <label for="txt_Longitude">
                                    Longitude</label>
                                <input type="number" class="form-control" id="txt_Longitude" placeholder="Longitude">
                            </div>
                            <div class="form-group">
                                <label for="txt_Mylocation_Radious">
                                    Radius</label>
                                <input type="number" class="form-control" id="txt_Mylocation_Radious" placeholder="Radius"
                                    onkeyup="Setradious();">
                            </div>
                            <div class="form-group">
                                <label for="txt_PhoneNumber">
                                    Phone Number</label>
                                <input type="number" class="form-control" id="txt_PhoneNumber" placeholder="Phone Number">
                            </div>
                            <div class="form-group">
                                <label for="txt_Image">
                                    Image</label>
                                <input type="text" class="form-control" id="txt_Image" placeholder="Image">
                            </div>
                            <div class="form-group">
                                <label for="txt_Image">
                                    Plant Name</label>
                                <select id="ddlPlantName" class="form-control">
                                </select>
                            </div>
                            <div class="form-group" style="margin-bottom: 5px; cursor: pointer;">
                                <label for="txt_Image">
                                    Click on below icons to select image</label><br />
                                <img src="UserImgs/build10.png" title="build10" onclick="imageclick(this);" />
                                <img src="UserImgs/build11.png" title="build11" onclick="imageclick(this);" />
                                <img src="UserImgs/build12.png" title="build12" onclick="imageclick(this);" />
                                <img src="UserImgs/build13.png" title="build13" onclick="imageclick(this);" />
                                <img src="UserImgs/build14.png" title="build14" onclick="imageclick(this);" />
                                <img src="UserImgs/build15.png" title="build15" onclick="imageclick(this);" />
                                <img src="UserImgs/build16.png" title="build16" onclick="imageclick(this);" />
                                <img src="UserImgs/build17.png" title="build17" onclick="imageclick(this);" />
                                <img src="UserImgs/build18.png" title="build18" onclick="imageclick(this);" />
                            </div>
                            <input type="button" class="btn btn-success" id="btn_Mylocation_save" value="Save"
                                onclick="saveclick();" />
                            <input type="button" class="btn btn-danger" id="btn_MyLocation_Del" value="Delete"
                                onclick="deleteclick();" />
                            <input type="button" class="btn btn-warning" id="btn_MyLocation_refresh" onclick="BtnMyLocatoinRefresh();"
                                value="Refresh" />
                        </div>
                        <div class="col-md-9">
                            <div id="googleMap" class="googleMapcls">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">
                            <i style="padding-right: 5px;" class="fa fa-list"></i>Select Location(s)
                        </h3>
                    </div>
                    <div class="box-body">
                        <table align="center">
                            <tr>
                                <td>
                                    <input id="txt_locations" type="text" class="form-control" name="vendorcode" placeholder="Search Location" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <div id="div_Branchdata" align="center" style="width: 100%; height: 400px; overflow: auto;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
