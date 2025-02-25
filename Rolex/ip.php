/* ip.php - Logs IP, device info, and location */
<?php
// Get user IP
$ip = $_SERVER['REMOTE_ADDR'];

// Fetch IP details from external API
$api_url = "http://ip-api.com/json/{$ip}";
$response = @file_get_contents($api_url);

// Check if API request was successful
if ($response === false) {
    error_log("Failed to fetch IP details for: $ip");
    $data = [];
} else {
    $data = json_decode($response, true);
}

// Handle missing values gracefully
$lat = $data['lat'] ?? 'Unknown';
$lon = $data['lon'] ?? 'Unknown';
$city = $data['city'] ?? 'Unknown';
$country = $data['country'] ?? 'Unknown';
$status = $data['status'] ?? 'fail';

// Log API response for debugging
error_log("IP Lookup: IP={$ip}, Status={$status}, City={$city}, Country={$country}, Lat={$lat}, Lon={$lon}");

if ($status !== 'success') {
    $lat = 'N/A';
    $lon = 'N/A';
    $city = 'N/A';
    $country = 'N/A';
}

// Return JSON response
header('Content-Type: application/json');
echo json_encode([
    'ip' => $ip,
    'lat' => $lat,
    'lon' => $lon,
    'city' => $city,
    'country' => $country
]);
?>
