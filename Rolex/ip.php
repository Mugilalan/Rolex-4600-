<?php
// Get user IP
$ip = $_SERVER['REMOTE_ADDR'];

// Fetch IP details from external API
$api_url = "http://ip-api.com/json/{$ip}";
$response = @file_get_contents($api_url);
$data = json_decode($response, true);

// Handle missing values gracefully
$lat = $data['lat'] ?? 'Unknown';
$lon = $data['lon'] ?? 'Unknown';
$city = $data['city'] ?? 'Unknown';
$country = $data['country'] ?? 'Unknown';

// Print results
echo json_encode([
    'ip' => $ip,
    'lat' => $lat,
    'lon' => $lon,
    'city' => $city,
    'country' => $country
]);
?>
