<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Tools.aspx.cs" Inherits="Tools" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" type="text/css" href="dist/css/AdminLTE.css" />
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
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
            height: 420px;
            position: relative;
            overflow: hidden;</style>
   
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCNJQwYwI1XH2nQzqszGuv5WKpkjNzY-Z8&v=3.exp&libraries=geometry&sensor=false"></script>
    <script src="js/JTemplate.js?v=1001" type="text/javascript"></script>
    <script src="DropDownCheckList.js?v=1001" type="text/javascript"></script>
    <script type="text/javascript">
        var rendererOptions = {
            draggable: true
        };
        var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions); ;
        var directionsService = new google.maps.DirectionsService();
        var australia = new google.maps.LatLng(-25.274398, 133.775136);

        var map;
        var geocoder;
        var marker;
        function initialize() {
            var myLatlng = new google.maps.LatLng(17.497535, 78.408622);
            geocoder = new google.maps.Geocoder();
            var myOptions = {
                zoom: 10,
                center: myLatlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }
            map = new google.maps.Map(document.getElementById("googleMap"), myOptions);
            directionsDisplay.setMap(map);

            marker = new google.maps.Marker({
                draggable: true,
                position: myLatlng,
                map: map,
                title: "Your location"
            });
            google.maps.event.addListener(marker, "dragend", function (event) {
                var lat = event.latLng.lat();
                var lng = event.latLng.lng();
                document.getElementById('txtLatitude').value = lat;
                document.getElementById('txtLongitude').value = lng;
                var location = new google.maps.LatLng(lat, lng);
                getAddress(location);
            });
            function getAddress(latLng) {
                geocoder.geocode({ 'latLng': latLng },
      function (results, status) {
          if (status == google.maps.GeocoderStatus.OK) {
              if (results[0]) {
                  document.getElementById('txtLocation').value = results[0].formatted_address;
              }
              else {
                  document.getElementById('txtLocation').value = "No results";
              }
          }
          else {
              document.getElementById('txtLocation').value = status;
          }
      });
            }
        }
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
    <script type="text/javascript">
        function getCookie(cname) {
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1);
                if (c.indexOf(name) == 0) {
                    return c.substring(name.length, c.length);
                }
            }
            return "";
        }
        $(function () {
            var Username = getCookie("Username");
            $('#lbl_username').html(Username);
            $('#btnFix').click(function (e) {
                deleteOverlays();
                var myLatlng = new google.maps.LatLng(17.497535, 78.408622);

                var myOptions = {
                    zoom: 8,
                    center: myLatlng,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                }
                map = new google.maps.Map(document.getElementById("googleMap"), myOptions);
                var txtLocation = document.getElementById('txtLocation').value;
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({ 'address': txtLocation }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        var latitude = results[0].geometry.location.lat();
                        var longitude = results[0].geometry.location.lng();
                        document.getElementById('txtLatitude').value = latitude;
                        document.getElementById('txtLongitude').value = longitude;
                        var locatipon = new google.maps.LatLng(latitude, longitude);
                        marker = new google.maps.Marker({
                            draggable: true,
                            position: locatipon,
                            map: map,
                            title: "Your location"
                        });
                        map.panTo(locatipon);
                        google.maps.event.addListener(marker, "dragend", function (event) {
                            var lat = event.latLng.lat();
                            var lng = event.latLng.lng();
                            document.getElementById('txtLatitude').value = lat;
                            document.getElementById('txtLongitude').value = lng;
                            var location = new google.maps.LatLng(lat, lng);
                            getAddress(location);
                        });
                        function getAddress(latLng) {
                            geocoder.geocode({ 'latLng': latLng },
      function (results, status) {
          if (status == google.maps.GeocoderStatus.OK) {
              if (results[0]) {
                  document.getElementById('txtLocation').value = results[0].formatted_address;
              }
              else {
                  document.getElementById('txtLocation').value = "No results";
              }
          }
          else {
              document.getElementById('txtLocation').value = status;
          }
      });
                        }
                    } else {
                    }
                });
            });
            $('#btnClear').click(function (e) {
                vehcount = 0;
                $('#lbl_vehcount').html(vehcount + ' Vehicles Found');
                latlng_pos = [];
                document.getElementById('txtLocation').value = "";
                document.getElementById('txtLatitude').value = "";
                document.getElementById('txtLongitude').value = "";
                document.getElementById('txtKMs').value = "";
                deleteOverlays();
                directionsDisplay.setDirections({ routes: [] });
            });
            $('#Button1').click(function (e) {
                vehcount = 0;
                $('#lbl_vehcount').html(vehcount + ' Vehicles Found');
                latlng_pos = [];
                deleteOverlays();
                var txtLocation = document.getElementById('txtLocation').value;
                var txtKMs = document.getElementById('txtKMs').value;
                if (txtLocation == "" || txtKMs == "") {
                    alert("Please Enter Location and Distance(KMs)");
                    return false;
                }

                var latt = document.getElementById('txtLatitude').value;
                var long = document.getElementById('txtLongitude').value;
                var locatipon = new google.maps.LatLng(latt, long);
                latlng_pos.push(locatipon);
                var Nokm = document.getElementById('txtKMs').value;
                var data = { 'op': 'getNearestVehicle', 'latt': latt, 'long': long, 'Nokm': Nokm };
                var s = function (msg) {
                    if (msg) {
                        BindVehicles(msg);
                    }
                    else {
                    }
                };
                var e = function (x, h, e) {
                    // $('#BookingDetails').html(x);
                };
                callHandler(data, s, e);
            });
            function deleteOverlays() {
                clearOverlays();
                LocationsArray = [];
            }
            function clearOverlays() {
                setAllMap(null);
            }
            function setAllMap(map) {
                for (var i = 0; i < LocationsArray.length; i++) {
                    LocationsArray[i].setMap(map);
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
            var vehlat;
            var vehlong;
            var vehicleno;
            function calcRoute(Lat1, Long1, VehicleID) {
                vehlat = Lat1;
                vehlong = Long1;
                vehicleno = VehicleID;
                var origin1 = new google.maps.LatLng(Lat1, Long1);
                var latitude = document.getElementById('txtLatitude').value;
                var longitude = document.getElementById('txtLongitude').value;
                var destinationA = new google.maps.LatLng(latitude, longitude);
                var service = new google.maps.DistanceMatrixService();
                service.getDistanceMatrix({
                    origins: [origin1],
                    destinations: [destinationA],
                    travelMode: google.maps.TravelMode.DRIVING,
                    unitSystem: google.maps.UnitSystem.METRIC,
                    avoidHighways: false,
                    avoidTolls: false
                }, callback);
            }
            function callback(response, status) {
                if (status != google.maps.DistanceMatrixStatus.OK) {
                    alert('Error was: ' + status);
                } else {
                    var origins = response.originAddresses;
                    var destinations = response.destinationAddresses;
                    if (response.rows[0].elements[0].status == 'OK') {
                        vehdistance = response.rows[0].elements[0].distance.text;
                        duration = response.rows[0].elements[0].duration.text;
                        var Nokm = document.getElementById('txtKMs').value;
                        var distance = vehdistance.split(' ')[0];
                        if (distance <= Nokm) {
                            var location = new google.maps.LatLng(vehlat, vehlong);
                            placeMarker(location, vehicleno, vehdistance, duration);
                        }
                    }
                }
            }
            var interval;
            function BindVehicles(data) {
                interval = setInterval(function () { vehupdate(data) }, 200);
            }
            var vehicledata = 0;
            function vehupdate(data) {
                if (vehicledata < data.length) {
                    //                for (var vehicledata in data) {
                    var vehicleno = data[vehicledata].Vehicleno;
                    var latitude = data[vehicledata].latitude;
                    var longitude = data[vehicledata].longitude;
                    var Distance = data[vehicledata].Distance;
                    var ExpectedTime = data[vehicledata].ExpectedTime;
                    calcRoute(latitude, longitude, vehicleno);
                    vehicledata++;
                }
                else {
                    vehicledata = 0;
                    clearInterval(interval);
                }
            }
            var vehcount = 0;
            var latlng_pos = [];
            var LocationsArray = new Array();
            function placeMarker(location, vehicleno, Distance, ExpectedTime) {
                var marker = new google.maps.Marker({
                    position: location,
                    map: map,
                    center: location,
                    zoom: 10,
                    icon: 'Vehicletypes/greenCar7.png',
                    title: 'Vehicle Number : ' + vehicleno + "\n" + 'Distance : ' + Distance + "\n" + 'ExpectedTime : ' + ExpectedTime
                });
                LocationsArray.push(marker);
                var content = 'Vehicle Number : ' + vehicleno + "<br/>" + 'Distance : ' + Distance + "<br/>" + 'ExpectedTime : ' + ExpectedTime;
                var infowindow = new google.maps.InfoWindow({
                    content: content
                });

                google.maps.event.addListener(marker, 'click', function () {
                    infowindow.open(map, marker);
                    drawRoute(location);
                });
                vehcount++;
                $('#lbl_vehcount').html(vehcount + ' Vehicles Found');
                latlng_pos.push(location);
                var latlngbounds = new google.maps.LatLngBounds();
                if (latlng_pos.length > 1) {
                    for (var i = 0; i < latlng_pos.length; i++) {
                        latlngbounds.extend(latlng_pos[i]);
                    }
                    map.fitBounds(latlngbounds);
                }
                else if (latlng_pos.length == 1) {
                    for (var i = 0; i < latlng_pos.length; i++) {
                        latlngbounds.extend(latlng_pos[i]);
                    }
                    map.fitBounds(latlngbounds);
                    map.setZoom(12);
                }
                else {
                    map.setCenter(new google.maps.LatLng(17.497535, 78.408622));
                    map.setZoom(10);
                }
            }
        });
        function drawRoute(end) {
            var start = document.getElementById('txtLatitude').value + ',' + document.getElementById('txtLongitude').value;
            var request = {
                origin: start,
                destination: end,
                travelMode: google.maps.DirectionsTravelMode.DRIVING
            };
            directionsService.route(request, function (response, status) {
                if (status == google.maps.DirectionsStatus.OK) {
                    directionsDisplay.setDirections(response);
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
<br />
    <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <!--<div class="box-header">
                        <h3 class="box-title">Finding Nearest Vehicle</h3>
                    </div>-->
                    <div class="box-body">
                        <div class="col-md-3">
                            <div class="form-group" style="margin-bottom: 5px;">
                                <label for="txtLocation">
                                    Location Name</label>
                                <input type="text" class="form-control" id="txtLocation" placeholder="Location Name">
                            </div>
                        </div>
                        <div class="col-md-3" style="height: 58px;">
                            <input type="button" style="bottom: 0px; position: absolute; width: 100px;" class="btn btn-info"
                                id="btnFix" value="Fix" />
                        </div>
                        <div class="col-md-3">
                            <div class="form-group" style="margin-bottom: 5px;">
                                <label for="txtLatitude">
                                    Latitude</label>
                                <input type="text" class="form-control" id="txtLatitude" placeholder="Latitude" disabled>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group" style="margin-bottom: 5px;">
                                <label for="txtLongitude">
                                    Longitude</label>
                                <input type="text" class="form-control" id="txtLongitude" placeholder="Longitude"
                                    disabled>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group" style="margin-bottom: 5px;">
                                <label for="txtKMs">
                                    No Of KMs</label>
                                <input type="number" class="form-control" id="txtKMs" placeholder="No Of KMs">
                            </div>
                        </div>
                        <div class="col-md-3" style="height: 58px; width: 110px;">
                            <input type="button" class="btn btn-success" style="bottom: 0px; position: absolute;
                                width: 100px;" id="Button1" value="Find" />
                        </div>
                        <div class="col-md-3" style="height: 58px;">
                            <input type="button" class="btn btn-default" style="bottom: 0px; position: absolute;
                                width: 100px;" id="btnClear" value="Clear" />
                        </div>
                        <div class="col-md-3" style="height: 58px;">
                            <span class="label label-danger" id="lbl_vehcount" style="bottom: 0px; position: absolute;
                                font-size: 20px;">0 Vehicles Found</span>
                        </div>
                        <div class="col-md-12">
                            <div id="googleMap" class="googleMapcls">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
