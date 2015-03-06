<?php require_once("layout.header.php"); ?>
<div>
<?php
define("UPLOAD_DIR", "uploads/");
 
if (!empty($_FILES["myFile"])) {
    $myFile = $_FILES["myFile"];
 
    if ($myFile["error"] !== UPLOAD_ERR_OK) {
        echo "<p>An error occurred.</p>";
        exit;
    }
 
    // ensure a safe filename
    $name = preg_replace("/[^A-Z0-9._-]/i", "_", $myFile["name"]);
 
    // don't overwrite an existing file
    $i = 0;
    $parts = pathinfo($name);
    while (file_exists(UPLOAD_DIR . $name)) {
        $i++;
        $name = $parts["filename"] . "-" . $i . "." . $parts["extension"];
    }

    // preserve file from temporary directory
    $success = move_uploaded_file($myFile["tmp_name"],
        UPLOAD_DIR . $name);
    if (!$success) { 
        echo "<p>Unable to save file.</p>";
        exit;
    }
    else{
    	echo "Ju$t_th3_b@s1c_l-lt/\/\L.";

    }

 
    // set proper permissions on the new file
    chmod(UPLOAD_DIR . $name, 0644);
}else{
	echo "<img src=\"yao.png\"/><br />";
	echo "Looking for the key?";
}
?>
</div>
<?php require_once("layout.footer.php"); ?>