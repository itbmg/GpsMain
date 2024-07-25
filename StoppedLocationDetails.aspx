<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="StoppedLocationDetails.aspx.cs" Inherits="StoppedLocationDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
 <script src="js/jquery-1.4.4.min.js" type="text/javascript"></script>    
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCNJQwYwI1XH2nQzqszGuv5WKpkjNzY-Z8&v=3.exp&libraries=geometry&sensor=false"></script>
      <%-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDbt9z3InHbzrV66t1eSZB5TnlJ2HQ-Uc8&v=3.exp&sensor=false&libraries=geometry"></script>--%>
      <style>
        html, body, #map-canvas
        {
            height: 100%;
            margin: 0px;
            padding: 0px;
        }
        #control
        {
            background: #fff;
            padding: 5px;
            font-size: 14px;
            font-family: Arial;
            border: 1px solid #ccc;
            box-shadow: 0 2px 2px rgba(33, 33, 33, 0.4);
            display: none;
        }
           div#mapcontent
        {
            right: 0;
            bottom: 0;
            left: 0px;
            top: 55px;
            overflow: hidden;
            position: absolute;
        }
    </style>

      <script type="text/javascript">

          //
          $(function () {
              $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);              
          });
      //

          var rendererOptions = {
              draggable: true
          };
          var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions); ;
          var directionsService = new google.maps.DirectionsService();
          var map;
          var australia = new google.maps.LatLng(-25.274398, 133.775136);
            function initialize() {              

          var mapOptions = {
                  zoom: 7,
                  mapTypeId: google.maps.MapTypeId.ROADMAP,
                  center: australia
              };
              map = new google.maps.Map(document.getElementById('googleMap'), mapOptions);
              directionsDisplay.setMap(map);
              directionsDisplay.setPanel(document.getElementById('directionsPanel'));

              google.maps.event.addListener(directionsDisplay, 'directions_changed', function () {
                  computeTotalDistance(directionsDisplay.directions);
              });
//              var control = document.getElementById('control');
//              control.style.display = 'block';
              //              map.controls[google.maps.ControlPosition.TOP_CENTER].push(control);
            
              calcRoute();
          }

          function calcRoute() {

              var lat = 13.794345;
              var lng = 79.799331;
              // var lat1 = 13.794345;
              // var lng1 = 79.799331;

//              var latstr = getParameterByName("lat");
              //              var lngstr = getParameterByName("long");
              var latstr = getParameterByName("lat");
              var lngstr = getParameterByName("long");
              var latstr1 = getParameterByName("lat1");
              var lngstr1 = getParameterByName("long1");

              if (latstr != "" && lngstr != "" && latstr1 != "" && lngstr1!="") {
                  lat = latstr;
                  lng = lngstr;
                  lat1 = latstr1;
                  lng1 = lngstr1;
                  
              }
              var start = lat + "," + lng;
              var end = lat1 + "," + lng1;
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

          function computeTotalDistance(result) {
              var total = 0;
              var myroute = result.routes[0];
              for (var i = 0; i < myroute.legs.length; i++) {
                  total += myroute.legs[i].distance.value;
              }
              total = total / 1000.
              document.getElementById('total').innerHTML = total + ' km';
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div style="width: 100%;">
            <div id="mapcontent">
                <div id="googleMap" style="width: 70%; height: 100%; position: relative; background-color: rgb(229, 227, 223);">
                </div>
            </div>
        </div>
         <div id="directionsPanel" style="float: right; width: 30%; height: 100%; overflow-x: auto;">
        <p>
            Total Distance: <span id="total"></span>
        </p>
    </div>
</asp:Content>

