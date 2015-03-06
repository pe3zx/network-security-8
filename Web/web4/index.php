<?php require_once("layout.header.php"); ?>
<div class="row">
<?php
   $host = '';
   if (isset( $_POST['host'] ) )
      $host = $_POST['host'];
   system("nslookup " . $host);
?>

<form method="post">
   Enter NS for Lookup: <input type="text" name="host"><br>
   <input type="submit">
</form>
</div>

<?php require_once("layout.footer.php"); ?>