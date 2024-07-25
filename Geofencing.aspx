<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Geofencing.aspx.cs" Inherits="Geofencing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server" >       
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDbt9z3InHbzrV66t1eSZB5TnlJ2HQ-Uc8&v=3.exp&sensor=false"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  
  <style type="text/css">
      
  #mymap 
  {
      width:100%;
      height:600px;
  }
  </style>
  <style>
  #panel 
  {   
    position: absolute;
    top: 25%;
    left: 90%;
    margin-left: -280px;
    z-index: 5;
    background-color: #fff;
    padding: 5px;
    border: 1px solid #999;
   
  }
  </style>

 <%--  <script type="text/javascript">//Rectangle
      function init() {
          var mapDiv = document.getElementById("mymap");
          var mapOptions = {
              center: new google.maps.LatLng(37.09024, -119.4179324),
              Zoom: 5,
              mapTypeId: google.maps.MapTypeId.ROADMAP
          };
          var map = new google.maps.Map(mapDiv, mapOptions);
          var rectangle = new google.maps.Rectangle({
              map: map,
              bounds: new google.maps.LatLngBounds(
              new google.maps.LatLng(37.778261, -119.4179324),
              new google.maps.LatLng(36.255123, -115.2383485)
              ),
              fillColor:"#00FF00",
              strokeColor:"red",
              editable:true,
              draggable:true
          });
      }
  window.onload = init;
  </script>--%>
    
  <script type="text/javascript">      //circle
      $(function () {
//          $('#spn_Vid').css('display', 'none');
//          $('#ddlselectvehicle').css('display', 'none');
//          $('#Lbl_LocationName').css('display', 'block');
//          $('#address').css('display', 'block');
          $('#btn_GetLocation').css('display', 'none');


          $('#divinfoclose').click(function () {
              $('#panel').css('display', 'none');
          });
      });


      var geocoder;
      var map;
      var circle;
      var mapDiv;
      var mapOptions;
      var marker;
      var Latp;
      var Longp;
      var Radiousp;

      function init() {
          Latp=parseFloat(12.008477318659862);
          Longp=parseFloat(79.65307331968529);
          geocoder = new google.maps.Geocoder();
           mapDiv = document.getElementById("mymap");
           mapOptions = {
               center: new google.maps.LatLng(12.008477318659862, 79.65307331968529),
               Zoom: 8,
               mapTypeId: google.maps.MapTypeId.ROADMAP
           };
          map = new google.maps.Map(mapDiv, mapOptions);
          circle = new google.maps.Circle({
              map: map,
              center: new google.maps.LatLng(12.008477318659862, 79.65307331968529),
              radius: 50000,
              fillColor: "red",
              strokeColor: "#00ff00",
              editable: true,
              draagable: false
          });
          google.maps.event.addListener(circle, "radius_changed", function () {
              document.getElementById("radius_info").innerHTML = circle.getRadius();
          });
          google.maps.event.addListener(circle, "center_changed", function () {
              document.getElementById("center_info").innerHTML = circle.getCenter();
          });
          
          Getloginvehicles();
      }

      //
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

      function ddlVehicle_Change() {
          var info;
          var vehicleid = document.getElementById('ddlselectvehicle').value;
          var rd = document.getElementById('txt_Radious').value;
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
                  info = msg;
                  for (var i = 0; i < info.length; i++) {
                      var Lat = msg[i].Lat;
                      var Long = msg[i].Long;
                      var address = msg[i].address;
                      document.getElementById('address').value=address;
                      Latp=parseFloat(Lat);
                      Longp=parseFloat(Long);
                      Radiousp=rd;
                              
                      mapOptions = {
                          center: new google.maps.LatLng(Lat, Long),
                          Zoom: 10,
                          mapTypeId: google.maps.MapTypeId.ROADMAP
                      };
                      map = new google.maps.Map(mapDiv, mapOptions);

                      var myLatLng = new google.maps.LatLng(
              parseFloat(Lat),
              parseFloat(Long));

                      var marker = new google.maps.Marker({
                          map: map,
                          position: myLatLng
                      });                     

                      circle.setMap(null);
                      circle = new google.maps.Circle({
                          map: map,
                          center: new google.maps.LatLng(Lat, Long),
                          radius: rd,
                          fillColor: "red",
                          strokeColor: "#00ff00"                         
                        
                      });
                      google.maps.event.addListener(circle, "radius_changed", function () {
                          document.getElementById("radius_info").innerHTML = circle.getRadius();
                      });
                      google.maps.event.addListener(circle, "center_changed", function () {
                          document.getElementById("center_info").innerHTML = circle.getCenter();
                      });
                  }
              }
              else {
                  alert('Please,Check the Vehicle Details');
              }
          };
          var e = function (x, h, e) {
          };
          $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

          callHandler(data, s, e);
      }


      var currentValue = 0;
      function handleClick(myRadio) {     

          if (myRadio.value == "Vehicle") {
//              $('#spn_Vid').css('display', 'block');
//              $('#ddlselectvehicle').css('display', 'block');
//              $('#Lbl_LocationName').css('display', 'none');
//              $('#address').css('display', 'none');
              $('#btn_GetLocation').css('display', 'none');              
          }
          else {
//              $('#spn_Vid').css('display', 'none');
//              $('#ddlselectvehicle').css('display', 'none');
//              $('#Lbl_LocationName').css('display', 'block');
//              $('#address').css('display', 'block');
              $('#btn_GetLocation').css('display', 'none');
          }
          currentValue = myRadio.value;
      }

     // 16.55158,80.628466,16.534111,80.605948, 'k'    
      function distance(lat1=16.06967111,lon1=80.15316444,lat2=16.534111,lon2=80.605948, unit='k') {
	  var radlat1 = Math.PI * lat1/180
	  var radlat2 = Math.PI * lat2/180
	  var theta = lon1-lon2
	  var radtheta = Math.PI * theta/180
	  var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
	  dist = Math.acos(dist)
	  dist = dist * 180/Math.PI
	  dist = dist * 60 * 1.1515
	  if (unit=="K") { dist = dist * 1.609344 }
	  if (unit=="N") { dist = dist * 0.8684 }
     alert(dist);
	  //return dist
}
      //
      function codeAddress() {

         // init();
         // document.getElementById("dis").setAttribute('style', 'visibility:visible;');
       

          var address = document.getElementById('address').value;
          var rd = document.getElementById('txt_Radious').value;
          rd = parseInt(rd);

            mapOptions = {
                          center: new google.maps.LatLng(Latp, Longp),
                          Zoom: 10,
                          mapTypeId: google.maps.MapTypeId.ROADMAP
                      };
                      map = new google.maps.Map(mapDiv, mapOptions);

          geocoder.geocode({ 'address': address }, function (results, status) {
              if (status == google.maps.GeocoderStatus.OK) {
                  var latitude = results[0].geometry.location.lat();
                  var longitude = results[0].geometry.location.lng();
                   Latp=parseFloat(latitude);
                   Longp=parseFloat(longitude);
                   Radiousp=rd;
                 // alert(latitude);
                 
                 //

                  map.setCenter(results[0].geometry.location);
                 
                  var marker = new google.maps.Marker({
                      map: map,
                      position: results[0].geometry.location
                  });

                
                   circle.setMap(null);
                   circle = new google.maps.Circle({
                      map: map,
                      center: new google.maps.LatLng(latitude, longitude),
                      radius: rd,
                      fillColor: "red",
                      strokeColor: "#00ff00",
                      editable: true,
                      draagable: false
                  });
                    google.maps.event.addListener(circle, "radius_changed", function () {
                          document.getElementById("radius_info").innerHTML = circle.getRadius();
                      });
                      google.maps.event.addListener(circle, "center_changed", function () {
                          document.getElementById("center_info").innerHTML = circle.getCenter();
                      });   

              } else {
                  alert('Geocode was not successful for the following reason: ' + status);
              }
          });
      }

      function  Clear() {
           document.getElementById('address').value="";  
      }
      function  ClearAll() {
            document.getElementById('address').value="";  
            document.getElementById('txt_Radious').value="";  
            document.getElementById('txt_phoneno').value=""; 
            document.getElementById('txt_Descriptions').value=""; 
      }

       function  SavegeovehiclemovingAlert() {

       var btnval=document.getElementById('save').value;
       var rdl=$('input[name=ctype]:checked').val();
       if(rdl=="Location")
       {
       }
       else{
       }
     
       var vehicleid=document.getElementById('ddlselectvehicle').value;   
       var phoneno=document.getElementById('txt_phoneno').value;
       var location=document.getElementById('address').value;
       var radious=document.getElementById('txt_Radious').value;     
       var Des=document.getElementById('txt_Descriptions').value;
         

          var data = { 'op': 'SavegeovehiclemovingAlert','btnval':btnval,'vehicleid':vehicleid,'phoneno':phoneno,'location':location,'radious':radious,'Lat':Latp,'Long':Longp,'Des':Des };
          var s = function (msg) {
              if (msg) {
                  ClearAll();
                  alert(msg);

              }
              else {
              }
          };
          var e = function (x, h, e) {
          };
          $(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

          callHandler(data, s, e);
      
      }
      

      google.maps.event.addDomListener(window, 'load', init);
  //window.onload = init;
  </script>

<%--<script type="text/javascript">
    function init() {
        var mapDiv = document.getElementById("mymap");
        var mapOptions = {
            center: new google.maps.LatLng(37.09024, -119.4179324),
            Zoom: 4,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(mapDiv, mapOptions);
        var designations = new google.maps.MVCArray();
        designations.push(new google.maps.LatLng(36.778261, -119.4179324));
        designations.push(new google.maps.LatLng(40.7143528, -74.00597309999));
        designations.push(new google.maps.LatLng(23.634501, -102.552784));


        var polylineOptions = { path: designations,
            strokeColor: "#ff0000", strokeWeight: 10
        };
        var polyline = new google.maps.polyline(polylineOptions);
        polyline.setMap(map);
    }
    window.onload = init;
</script>
 --%>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="panel">
        <table style="width:100%">
            <tr>
                <td>
                </td>
                <td>
                  <%--<input type="radio" name="ctype"   value="Location" onclick="handleClick(this); "/>Location--%>
                    <input type="radio" name="ctype" value="Vehicle" onclick="handleClick(this);"  checked="checked" />Vehicle                  
                </td>
                <td>
                </td>
            </tr>    
            <tr>
            <td> <span id="spn_Vid">VehicleID</span></td>
             <td><select id="ddlselectvehicle" class="form-control" onchange="ddlVehicle_Change()"></select></td>
             <td></td>

            </tr>              
            <tr>
                <td>    
                 <label id="Lbl_phoneno">Phone No</label>         
                </td>
                <td>                 
                    <input id="txt_phoneno" type="textbox" placeholder="Enter PhoneNo" style="height: 15px; border: 1px solid #999" />   
                </td>
                <td>
                    <input type="button" id="btn_GetLocation"  value="GetGeoLocation" style="font-size: 15px" onclick="codeAddress()" />
                </td>
            </tr>
            <tr>
                <td>
                    <label id="Label1">
                        Radious</label>
                </td>
                <td>
                    <input id="txt_Radious" type="textbox" placeholder="Enter Radious" style="height: 15px; border: 1px solid #999" />
                </td>
                <td>
                </td>
            </tr>
             <tr>
                <td>                
                 <label id="Lbl_LocationName">Location Name</label>
                </td>
                <td>                 
                <textarea id=address name="comment" placeholder="Location Name" style= "height:40px; border: 1px solid #999" ></textarea>       
                </td>
                <td>
                  
                </td>
            </tr>     
            <tr>
            <td><span id="spn_Descriptions">Descriptions</span></td>
            <td><textarea id=txt_Descriptions name="comment" placeholder="Enter the Message Content" style=" height:40px; border: 1px solid #999" ></textarea></td>
            <td></td>
            </tr>
            <tr>
                <td>
                    <label id="Label2">
                        Info</label>
                </td>
                <td>
                    <div id="radius_info">
                    </div>
                    <div id="center_info">
                    </div>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <input id="save" type="button" value="save" onclick="SavegeovehiclemovingAlert()" style="font-size: 15px" />
                    <input id="cancel" type="button" value="cancel" onclick="distance()" style="font-size: 15px" />
                </td>
                <td>
                </td>
            </tr>
        </table>
        <div id="divinfoclose" style="width: 5px; top: 0px; right: 0px; position: absolute;
            z-index: 99999; cursor: pointer; display: none">
            <img src="Images/Close.png" alt="close">
        </div>
    </div>

<div id="mymap"></div>
    
</asp:Content>

