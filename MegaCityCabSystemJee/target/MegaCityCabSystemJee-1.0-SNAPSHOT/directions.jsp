<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Route & Distance</title>

    <!-- Google Maps API (Replace YOUR_API_KEY) -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyChZ9kwkQLHYbpyhtayYtq3H4PEjtf5Uv4"></script>
 <script>
        function initMap() {
            var defaultLocation = { lat: 6.9271, lng: 79.8612 }; // Default location (Colombo)
            var map = new google.maps.Map(document.getElementById('map'), {
                center: defaultLocation,
                zoom: 14
            });

            var marker = new google.maps.Marker({
                position: defaultLocation,
                map: map,
                draggable: true
            });

            // Get User's Current Location
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    var currentLatLng = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };

                    // Move map to current location
                    map.setCenter(currentLatLng);
                    marker.setPosition(currentLatLng);

                    // Reverse Geocoding to Get Address
                    var geocoder = new google.maps.Geocoder();
                    geocoder.geocode({ location: currentLatLng }, function (results, status) {
                        if (status === "OK") {
                            if (results[0]) {
                                document.getElementById("current_location").value = results[0].formatted_address;
                            } else {
                                alert("No address found!");
                            }
                        } else {
                            alert("Geocoder failed: " + status);
                        }
                    });
                }, function () {
                    alert("Geolocation failed. Please enter your location manually.");
                });
            } else {
                alert("Your browser does not support Geolocation.");
            }

            // Update Address on Marker Drag
            google.maps.event.addListener(marker, 'dragend', function () {
                var newLatLng = marker.getPosition();
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({ location: newLatLng }, function (results, status) {
                    if (status === "OK") {
                        if (results[0]) {
                            document.getElementById("current_location").value = results[0].formatted_address;
                        }
                    }
                });
            });
        }
    </script>
    <script>
        var map, directionsService, directionsRenderer, userLatLng;

        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: 6.9271, lng: 79.8612 }, // Default: Colombo
                zoom: 12
            });

            directionsService = new google.maps.DirectionsService();
            directionsRenderer = new google.maps.DirectionsRenderer();
            directionsRenderer.setMap(map);

            var dropoffInput = document.getElementById("dropoff");
            var autocompleteDropoff = new google.maps.places.Autocomplete(dropoffInput);

            // Get User's Current Location as Pickup
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    userLatLng = {
                        lat: position.coords.latitude,
                        lng: position.coords.longitude
                    };

                    var geocoder = new google.maps.Geocoder();
                    geocoder.geocode({ location: userLatLng }, function (results, status) {
                        if (status === "OK" && results[0]) {
                            document.getElementById("pickup").value = results[0].formatted_address;
                        } else {
                            alert("Unable to fetch address for current location.");
                        }
                    });

                    map.setCenter(userLatLng);
                }, function () {
                    alert("Geolocation failed. Please enter your location manually.");
                });
            } else {
                alert("Your browser does not support Geolocation.");
            }

            document.getElementById("calculateRoute").addEventListener("click", function () {
                calculateRoute();
            });
        }

        function calculateRoute() {
            var dropoffLocation = document.getElementById("dropoff").value;

            if (!userLatLng || dropoffLocation === "") {
                alert("Ensure current location is detected and enter a destination.");
                return;
            }

            var request = {
                origin: userLatLng,
                destination: dropoffLocation,
                travelMode: google.maps.TravelMode.DRIVING
            };

            directionsService.route(request, function (result, status) {
                if (status == google.maps.DirectionsStatus.OK) {
                    directionsRenderer.setDirections(result);

                    var distance = result.routes[0].legs[0].distance.text;
                    var duration = result.routes[0].legs[0].duration.text;

                    document.getElementById("distance").value = distance;
                    document.getElementById("duration").value = duration;
                } else {
                    alert("Could not calculate route: " + status);
                }
            });
        }
    </script>
</head>

<body onload="initMap()">
    <h2>Find Route & Distance</h2>

    <label>Pickup Location (Auto-Detected):</label>
    <input type="text" id="pickup" readonly><br>

    <label>Dropoff Location:</label>
    <input type="text" id="dropoff" placeholder="Enter destination" required><br>

    <button id="calculateRoute">Calculate Route</button><br><br>

    <label>Distance:</label>
    <input type="text" id="distance" readonly><br>

    <label>Estimated Duration:</label>
    <input type="text" id="duration" readonly><br>

    <div id="map" style="height: 400px; width: 100%;"></div>
    
     <label>Current Location:</label>
    <input type="text" id="current_location" name="current_location" required readonly><br>

    <div id="map" style="height: 400px; width: 100%;"></div>
</body>
</html>
