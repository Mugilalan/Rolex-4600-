/* ip.php - Logs IP, device info, and location */
<?php
if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
    $ipaddress = $_SERVER['HTTP_CLIENT_IP'] . "\r\n";
} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
    $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'] . "\r\n";
} else {
    $ipaddress = $_SERVER['REMOTE_ADDR'] . "\r\n";
}
$useragent = " User-Agent: ";
$browser = $_SERVER['HTTP_USER_AGENT'];
$location = json_decode(file_get_contents("http://ip-api.com/json/" . trim($ipaddress)), true);
$lat = $location['lat'];
$lon = $location['lon'];
$city = $location['city'];
$country = $location['country'];
$file = 'ip.txt';
$fp = fopen($file, 'a');
fwrite($fp, "IP: " . $ipaddress);
fwrite($fp, $useragent . $browser . "\r\n");
fwrite($fp, "Location: $city, $country (Lat: $lat, Lon: $lon)\r\n");
fclose($fp);
?>
