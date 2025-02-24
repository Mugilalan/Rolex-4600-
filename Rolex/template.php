/* template.php - Redirects users and logs visits */
<?php
include 'ip.php';
$file = 'redirects.log';
$fp = fopen($file, 'a');
$date = date('Y-m-d H:i:s');
$ip = $_SERVER['REMOTE_ADDR'];
fwrite($fp, "[$date] Redirected IP: $ip\r\n");
fclose($fp);
die(header('Location: ' . getenv('FORWARDING_LINK') . '/index2.html'));
?>