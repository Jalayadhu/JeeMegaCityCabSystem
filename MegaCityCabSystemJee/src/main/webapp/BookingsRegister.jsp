<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegacityJee - Location & Fare Calculator</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="{{ url_for('static', filename='css/style.css') }}">
    <script src="{{ url_for('static', filename='js/calculator.js') }}" defer></script>
    <!-- Google Maps API with Places Library -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyChZ9kwkQLHYbpyhtayYtq3H4PEjtf5Uv4&libraries=places" defer></script>
    <script src="{{ url_for('static', filename='js/map.js') }}" defer></script>
<script>  
 // Google Maps initialization and functionality
var map, marker, destinationMarker, directionsRenderer, autocomplete;
var currentLatLng;
var directionsService;
var infoWindow;

function initMap() {
    // Show loading indicator
    var loadingIndicator = document.getElementById('loading-indicator');
    if (loadingIndicator) {
        loadingIndicator.classList.add('active');
    }
    
    var defaultLocation = { lat: 6.9271, lng: 79.8612 }; // Default (Colombo)
    
    // Initialize map with custom styling
    map = new google.maps.Map(document.getElementById('map'), {
        center: defaultLocation,
        zoom: 14,
        mapTypeControl: false,
        streetViewControl: false,
        fullscreenControl: true,
        zoomControl: true,
        styles: [
            {
                "featureType": "water",
                "elementType": "geometry",
                "stylers": [{"color": "#e9e9e9"},{"lightness": 17}]
            },
            {
                "featureType": "landscape",
                "elementType": "geometry",
                "stylers": [{"color": "#f5f5f5"},{"lightness": 20}]
            },
            {
                "featureType": "road.highway",
                "elementType": "geometry.fill",
                "stylers": [{"color": "#ffffff"},{"lightness": 17}]
            },
            {
                "featureType": "road.highway",
                "elementType": "geometry.stroke",
                "stylers": [{"color": "#ffffff"},{"lightness": 29},{"weight": 0.2}]
            },
            {
                "featureType": "road.arterial",
                "elementType": "geometry",
                "stylers": [{"color": "#ffffff"},{"lightness": 18}]
            },
            {
                "featureType": "road.local",
                "elementType": "geometry",
                "stylers": [{"color": "#ffffff"},{"lightness": 16}]
            },
            {
                "featureType": "poi",
                "elementType": "geometry",
                "stylers": [{"color": "#f5f5f5"},{"lightness": 21}]
            },
            {
                "featureType": "poi.park",
                "elementType": "geometry",
                "stylers": [{"color": "#dedede"},{"lightness": 21}]
            },
            {
                "elementType": "labels.text.stroke",
                "stylers": [{"visibility": "on"},{"color": "#ffffff"},{"lightness": 16}]
            },
            {
                "elementType": "labels.text.fill",
                "stylers": [{"saturation": 36},{"color": "#333333"},{"lightness": 40}]
            },
            {
                "elementType": "labels.icon",
                "stylers": [{"visibility": "off"}]
            },
            {
                "featureType": "transit",
                "elementType": "geometry",
                "stylers": [{"color": "#f2f2f2"},{"lightness": 19}]
            },
            {
                "featureType": "administrative",
                "elementType": "geometry.fill",
                "stylers": [{"color": "#fefefe"},{"lightness": 20}]
            },
            {
                "featureType": "administrative",
                "elementType": "geometry.stroke",
                "stylers": [{"color": "#fefefe"},{"lightness": 17},{"weight": 1.2}]
            }
        ]
    });

    // Initialize directions service and renderer
    directionsService = new google.maps.DirectionsService();
    directionsRenderer = new google.maps.DirectionsRenderer({
        map: map,
        suppressMarkers: true,
        polylineOptions: {
            strokeColor: '#0088ff',
            strokeWeight: 5,
            strokeOpacity: 0.7
        }
    });

    // Create info window for markers
    infoWindow = new google.maps.InfoWindow();

    // Create custom marker for current location
    marker = new google.maps.Marker({
        position: defaultLocation,
        map: map,
        draggable: false,
        animation: google.maps.Animation.DROP,
        icon: {
            path: google.maps.SymbolPath.CIRCLE,
            scale: 10,
            fillColor: '#0088ff',
            fillOpacity: 1,
            strokeColor: '#ffffff',
            strokeWeight: 2
        }
    });

    // Create destination marker (initially hidden)
    destinationMarker = new google.maps.Marker({
        map: map,
        draggable: false,
        visible: false,
        animation: google.maps.Animation.DROP,
        icon: {
            path: google.maps.SymbolPath.BACKWARD_CLOSED_ARROW,
            scale: 6,
            fillColor: '#00ccff',
            fillOpacity: 1,
            strokeColor: '#ffffff',
            strokeWeight: 2
        }
    });

    // Get User's Current Location with better error handling
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            function (position) {
                currentLatLng = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };

                // Move map to current location with animation
                map.panTo(currentLatLng);
                marker.setPosition(currentLatLng);
                
                // Add click listener to marker
                google.maps.event.addListener(marker, 'click', function() {
                    infoWindow.setContent(
                        '<div class="map-info-window">' +
                        '<div class="map-info-title">Your Location</div>' +
                        '<div class="map-info-address">' + document.getElementById("current_location").value + '</div>' +
                        '</div>'
                    );
                    infoWindow.open(map, marker);
                });

                // Reverse Geocoding to Get Address
                var geocoder = new google.maps.Geocoder();
                geocoder.geocode({ location: currentLatLng }, function (results, status) {
                    if (status === "OK" && results[0]) {
                        document.getElementById("current_location").value = results[0].formatted_address;
                    }
                    
                    // Hide loading indicator
                    if (loadingIndicator) {
                        loadingIndicator.classList.remove('active');
                    }
                });
            },
            function (error) {
                console.error("Error getting location: ", error);
                
                // Hide loading indicator
                if (loadingIndicator) {
                    loadingIndicator.classList.remove('active');
                }
                
                // Set a default location if geolocation fails
                currentLatLng = defaultLocation;
                document.getElementById("current_location").value = "Colombo, Sri Lanka";
            },
            { enableHighAccuracy: true, timeout: 10000, maximumAge: 0 }
        );
    } else {
        console.log("Geolocation is not supported by this browser.");
        currentLatLng = defaultLocation;
        
        // Hide loading indicator
        if (loadingIndicator) {
            loadingIndicator.classList.remove('active');
        }
    }

    // Initialize Places Autocomplete for destination input
    autocomplete = new google.maps.places.Autocomplete(
        document.getElementById("destination"),
        { types: ["establishment", "geocode"] }
    );
    
    // Bind autocomplete to the current map bounds
    autocomplete.bindTo("bounds", map);
    
    // Set autocomplete fields to retrieve
    autocomplete.setFields([
        "address_components",
        "formatted_address",
        "geometry",
        "name",
        "place_id"
    ]);

    // Focus map/viewport when selecting a place
    autocomplete.addListener("place_changed", function() {
        destinationMarker.setVisible(false);
    });
}

function calculateDistance() {
    // Show loading indicator
    var loadingIndicator = document.getElementById('loading-indicator');
    if (loadingIndicator) {
        loadingIndicator.classList.add('active');
    }
    
    var destination = autocomplete.getPlace();

    if (!destination || !destination.geometry) {
        if (loadingIndicator) {
            loadingIndicator.classList.remove('active');
        }
        return;
    }

    var destLatLng = destination.geometry.location;
    document.getElementById("destination").value = destination.formatted_address;
    
    // Set destination marker
    destinationMarker.setPosition(destLatLng);
    destinationMarker.setVisible(true);
    
    // Add click listener to destination marker
    google.maps.event.addListener(destinationMarker, 'click', function() {
        infoWindow.setContent(
            '<div class="map-info-window">' +
            '<div class="map-info-title">' + (destination.name || 'Destination') + '</div>' +
            '<div class="map-info-address">' + destination.formatted_address + '</div>' +
            '</div>'
        );
        infoWindow.open(map, destinationMarker);
    });

    // Calculate route
    var request = {
        origin: currentLatLng,
        destination: destLatLng,
        travelMode: 'DRIVING'
    };
    
    directionsService.route(request, function(response, status) {
        if (status === 'OK') {
            // Display the route on the map
            directionsRenderer.setDirections(response);
            
            // Fit map to show the entire route
            var bounds = new google.maps.LatLngBounds();
            bounds.extend(currentLatLng);
            bounds.extend(destLatLng);
            map.fitBounds(bounds);
            
            // Get distance and duration from the response
            var route = response.routes[0];
            var leg = route.legs[0];
            var distanceValue = leg.distance.value / 1000; // Convert meters to km
            var distanceInt = Math.round(distanceValue); // Round to nearest integer
            var durationMinutes = Math.round(leg.duration.value / 60); // Convert seconds to minutes
            
            // Calculate fare based on our rate (same as calculator.js)
            var fare = calculateFare(distanceInt);
            
            // Update distance input for booking form
            var distanceInput = document.getElementById("distance");
            if (distanceInput) {
                distanceInput.value = distanceInt;
                // Trigger the price calculation
                calculatePriceJee();
            }
            
            // Update form fields for submission
            var formCurrentLocation = document.getElementById("form_current_location");
            var formDestination = document.getElementById("form_destination");
            
            if (formCurrentLocation) {
                formCurrentLocation.value = document.getElementById("current_location").value;
            }
            
            if (formDestination) {
                formDestination.value = destination.formatted_address;
            }
            
            // Show results section if it exists
            var resultsSection = document.getElementById("results-section");
            if (resultsSection) {
                resultsSection.style.display = "block";
            }
            
            // Update summary values if they exist
            var distanceValueElem = document.getElementById("summary-distance");
            var timeValueElem = document.getElementById("summary-time");
            var priceValueElem = document.getElementById("summary-price");
            
            if (distanceValueElem) {
                distanceValueElem.textContent = distanceInt + " km";
                distanceValueElem.classList.add("animate-result");
            }
            
            if (timeValueElem) {
                timeValueElem.textContent = formatTime(durationMinutes);
                timeValueElem.classList.add("animate-result");
            }
            
            if (priceValueElem) {
                priceValueElem.textContent = formatPrice(fare);
                priceValueElem.classList.add("animate-result");
            }
            
            // Scroll to results if they exist
            if (resultsSection) {
                setTimeout(function() {
                    resultsSection.scrollIntoView({ behavior: 'smooth' });
                }, 500);
            }
        } else {
            alert("Directions request failed due to " + status);
        }
        
        // Hide loading indicator
        if (loadingIndicator) {
            loadingIndicator.classList.remove('active');
        }
    });
}

// Initialize map when page loads
window.onload = function() {
    // Check if map element exists before initializing
    if (document.getElementById('map')) {
        initMap();
    }
}; 
</script>  
<Style>  
:root {
    --primary: #0088ff;
    --primary-dark: #0066cc;
    --secondary: #00ccff;
    --dark: #333;
    --light: #f8f9fa;
    --card-bg: rgba(255, 255, 255, 0.95);
    --shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    --gradient: linear-gradient(135deg, var(--primary), var(--secondary));
    --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
    background-color: var(--light);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    color: var(--dark);
    background: radial-gradient(circle at top right, var(--secondary), transparent),
                radial-gradient(circle at bottom left, var(--primary), transparent);
    background-attachment: fixed;
}

.container {
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    display: flex;
    flex-direction: column;
    gap: 20px;
}

header {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px 0;
    position: relative;
}

.logo {
    font-size: 28px;
    font-weight: bold;
    color: var(--primary-dark);
    position: relative;
    text-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    display: flex;
    align-items: center;
    gap: 10px;
}

.logo i {
    font-size: 32px;
    color: var(--primary);
    animation: pulse 2s infinite;
}

.logo span {
    color: var(--secondary);
    animation: float 3s ease-in-out infinite;
    display: inline-block;
}

.main-content {
    display: flex;
    flex-direction: column;
    gap: 30px;
}

@media (min-width: 992px) {
    .main-content {
        flex-direction: row;
    }
}

.form-container {
    flex: 1;
    background: var(--card-bg);
    border-radius: 15px;
    padding: 30px;
    box-shadow: var(--shadow);
    display: flex;
    flex-direction: column;
    gap: 25px;
    position: relative;
    overflow: hidden;
    z-index: 1;
    animation: slideInLeft 0.5s ease-out;
}

.form-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 5px;
    background: var(--gradient);
    z-index: 2;
}

.form-title {
    font-size: 24px;
    font-weight: 600;
    color: var(--primary-dark);
    margin-bottom: 10px;
    position: relative;
    padding-bottom: 10px;
}

.form-title::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 50px;
    height: 3px;
    background: var(--gradient);
    border-radius: 3px;
    transition: var(--transition);
}

.form-container:hover .form-title::after {
    width: 100px;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
    margin-bottom: 15px;
}

.form-group label {
    font-weight: 500;
    color: var(--dark);
    display: flex;
    align-items: center;
    gap: 8px;
}

.form-group label i {
    color: var(--primary);
}

.input-container {
    position: relative;
}

.input-container i {
    position: absolute;
    left: 15px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--primary);
}

.form-control {
    width: 100%;
    padding: 15px 15px 15px 45px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 16px;
    transition: var(--transition);
    background-color: white;
}

.form-control:focus {
    outline: none;
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(0, 136, 255, 0.2);
}

.form-control[readonly] {
    background-color: #f5f5f5;
    cursor: not-allowed;
}

.btn {
    padding: 15px 25px;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: var(--transition);
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    margin-top: 10px;
}

.btn-primary {
    background: var(--gradient);
    color: white;
    box-shadow: 0 5px 15px rgba(0, 136, 255, 0.3);
}

.btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0, 136, 255, 0.4);
}

.btn-primary:active {
    transform: translateY(1px);
}

.btn-secondary {
    background-color: #f5f5f5;
    color: var(--primary-dark);
    border: 1px solid #ddd;
}

.btn-secondary:hover {
    background-color: #eeeeee;
    color: var(--primary);
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.btn-secondary:active {
    transform: translateY(1px);
}

.btn-small {
    padding: 8px 15px;
    font-size: 14px;
    margin-top: 5px;
    align-self: flex-start;
}

.help-text {
    font-size: 12px;
    color: #666;
    margin-top: 4px;
    margin-bottom: 8px;
}

.map-container {
    flex: 1.5;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: var(--shadow);
    position: relative;
    min-height: 400px;
    animation: slideInRight 0.5s ease-out;
}

#map {
    height: 100%;
    width: 100%;
    min-height: 400px;
    border-radius: 15px;
}

.results-container {
    background: var(--card-bg);
    border-radius: 15px;
    padding: 30px;
    box-shadow: var(--shadow);
    display: flex;
    flex-direction: column;
    gap: 20px;
    position: relative;
    overflow: hidden;
    animation: slideInUp 0.5s ease-out;
}

.results-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 5px;
    background: var(--gradient);
}

.results-title {
    font-size: 20px;
    font-weight: 600;
    color: var(--primary-dark);
    margin-bottom: 10px;
}

.results-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
}

.result-card {
    background: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    transition: var(--transition);
    position: relative;
    overflow: hidden;
}

.result-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.result-card::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 3px;
    background: var(--gradient);
    transform: scaleX(0);
    transform-origin: left;
    transition: var(--transition);
}

.result-card:hover::after {
    transform: scaleX(1);
}

.result-icon {
    font-size: 32px;
    color: var(--primary);
    margin-bottom: 15px;
}

.result-label {
    font-size: 14px;
    color: #777;
    margin-bottom: 5px;
}

.result-value {
    font-size: 24px;
    font-weight: 600;
    color: var(--dark);
}

.loading {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.8);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
    opacity: 0;
    visibility: hidden;
    transition: var(--transition);
}

.loading.active {
    opacity: 1;
    visibility: visible;
}

.spinner {
    width: 50px;
    height: 50px;
    border: 5px solid rgba(0, 136, 255, 0.2);
    border-radius: 50%;
    border-top-color: var(--primary);
    animation: spin 1s linear infinite;
}

/* Flash messages */
.flash-messages {
    position: fixed;
    top: 20px;
    right: 20px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    gap: 10px;
    max-width: 350px;
}

.flash-message {
    padding: 15px 20px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    opacity: 0;
    transform: translateX(30px);
    animation: fadeInRight 0.5s forwards;
}

.flash-message.success {
    border-left: 4px solid #28a745;
}

.flash-message.error {
    border-left: 4px solid #dc3545;
}

.flash-message.info {
    border-left: 4px solid var(--primary);
}

/* Animations */
@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.1); }
    100% { transform: scale(1); }
}

@keyframes float {
    0% { transform: translateY(0); }
    50% { transform: translateY(-5px); }
    100% { transform: translateY(0); }
}

@keyframes slideInLeft {
    from { transform: translateX(-50px); opacity: 0; }
    to { transform: translateX(0); opacity: 1; }
}

@keyframes slideInRight {
    from { transform: translateX(50px); opacity: 0; }
    to { transform: translateX(0); opacity: 1; }
}

@keyframes slideInUp {
    from { transform: translateY(50px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}

@keyframes fadeInRight {
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* Map-specific styling */
.map-info-window {
    padding: 5px;
    max-width: 250px;
}

.map-info-title {
    font-weight: bold;
    font-size: 14px;
    color: var(--primary-dark);
    margin-bottom: 3px;
}

.map-info-address {
    font-size: 12px;
    color: #666;
}

.gm-style .gm-style-iw-c {
    padding: 12px;
    border-radius: 8px;
}

/* Customize Google Maps controls */
.gm-style .gm-style-mtc button,
.gm-style .gm-style-mtc div {
    border-radius: 4px !important;
}

/* Animate results when calculated */
.animate-result {
    animation: highlightValue 1s ease;
}

@keyframes highlightValue {
    0% { color: var(--primary); transform: scale(1.1); }
    100% { color: var(--dark); transform: scale(1); }
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .container {
        padding: 15px;
    }
    
    .form-container, .results-container {
        padding: 20px;
    }
    
    .results-grid {
        grid-template-columns: 1fr;
    }
    
    /* Adjust layout for mobile */
    .main-content {
        flex-direction: column;
    }
    
    .map-container {
        order: -1; /* Make map appear first on mobile */
        margin-bottom: 20px;
    }
}  
</Style>    
</head>
<body>
    <!-- Loading indicator -->
    <div class="loading" id="loading-indicator">
        <div class="spinner"></div>
    </div>

    <!-- Flash messages -->
 

    <div class="container">
        <header>
            <div class="logo">
                <i class="fas fa-taxi"></i>
                Megacity<span>Jee</span>
            </div>
        </header>
        
        <div class="main-content">
            <div class="form-container">
                <h2 class="form-title">Book Your Ride</h2>
                
                <form action="{{ url_for('book') }}" method="post" id="bookingForm">
                    <div class="form-group">
                        <label for="customer_id"><i class="fas fa-user"></i> Customer ID</label>
                        <div class="input-container">
                            <i class="fas fa-id-card"></i>
                            <input type="text" id="customer_id" name="customer_id" class="form-control" placeholder="Enter your customer ID" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="current_location"><i class="fas fa-map-marker-alt"></i> Current Location</label>
                        <div class="input-container">
                            <i class="fas fa-location-arrow"></i>
                            <input type="text" id="current_location" name="current_location" class="form-control" placeholder="Enter your current location" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="destination"><i class="fas fa-map-pin"></i> Destination</label>
                        <div class="input-container">
                            <i class="fas fa-map-marked-alt"></i>
                            <input type="text" id="destination" name="destination" class="form-control" placeholder="Enter your destination" required>
                        </div>
                        <div class="help-text">
                            <small><i class="fas fa-info-circle"></i> Select a location from the dropdown to calculate route</small>
                        </div>
                        <button type="button" class="btn btn-secondary btn-small" onclick="calculateDistance()">
                            <i class="fas fa-route"></i> Calculate Route
                        </button>
                    </div>
                    
                    <div class="form-group">
                        <label for="distance"><i class="fas fa-route"></i> Distance (in kilometers)</label>
                        <div class="input-container">
                            <i class="fas fa-ruler-horizontal"></i>
                            <input type="number" id="distance" name="Distance" class="form-control" placeholder="Enter distance" min="0" step="0.1" oninput="calculatePriceJee()" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="price"><i class="fas fa-tag"></i> Estimated Price</label>
                        <div class="input-container">
                            <i class="fas fa-dollar-sign"></i>
                            <input type="text" id="price" name="price" class="form-control" placeholder="Calculated price" readonly>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check-circle"></i>
                        Book Now
                    </button>
                </form>
            </div>
            
            <div class="map-container">
                <div id="map">
                    <!-- Map will be displayed here using Google Maps API -->
                    <div style="display: flex; justify-content: center; align-items: center; height: 100%; flex-direction: column; text-align: center; padding: 20px;">
                        <i class="fas fa-map-marked-alt" style="font-size: 48px; color: var(--primary); margin-bottom: 20px;"></i>
                        <h3 style="margin-bottom: 10px; color: var(--primary-dark);">Interactive Map</h3>
                        <p style="color: #666;">Enter your location details to see the route and get fare estimates.</p>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="results-container">
            <h3 class="results-title">Ride Summary</h3>
            <div class="results-grid">
                <div class="result-card">
                    <div class="result-icon">
                        <i class="fas fa-route"></i>
                    </div>
                    <div class="result-label">Distance</div>
                    <div class="result-value" id="summary-distance">0 km</div>
                </div>
                <div class="result-card">
                    <div class="result-icon">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="result-label">Estimated Fare</div>
                    <div class="result-value" id="summary-price">?0.00</div>
                </div>
                <div class="result-card">
                    <div class="result-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="result-label">Estimated Time</div>
                    <div class="result-value" id="summary-time">0 min</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
