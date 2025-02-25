/* template.php - Redirects users and logs visits */
<?php
include 'ip.php';
$file = 'redirects.log';
$fp = fopen($file, 'a');
$date = date('Y-m-d H:i:s');
$ip = $_SERVER['REMOTE_ADDR'];
fwrite($fp, "[$date] Redirected IP: $ip\r\n");
fclose($fp);

// Set default forwarding link if environment variable is not set
$forwarding_link = getenv('FORWARDING_LINK') ?: 'index.html';

// Check if index2.html exists before redirecting
if (!file_exists('index2.html')) {
    $forwarding_link = 'index.html';
}

// Redirect user
header('Location: ' . $forwarding_link);
exit;
?>
