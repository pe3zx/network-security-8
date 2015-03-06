<?php require_once("layout.header.php"); ?>
<?php
$password = "1234567";
?>
<div class="row">
<?php
print "<h2 align=\"center\">ห้องแห่งความลับ</h2>";

if (isset($_POST["password"]) && ($_POST["password"]=="$password")) {
?>

<p align="center"><br><br><br>
<b>He11o_$(r1pt_k1d3ede[-1e</b><br>ยินดีด้วยที่สามารถเข้าสู่ห้องแห่งความลับได้ :{ </p>

<?php
}
else
{

if (isset($_POST['password']) || $password == "") {
print "<p align=\"center\"><font color=\"red\"><b>ผิด</b><br>พยายามใหม่ สู้ๆ :D</font></p>";}
print "<form method=\"post\"><p align=\"center\">กรุณาใส่รหัสผ่าน เพื่อเข้าสู่ห้องแห่งความลับ<br>";
print "<input name=\"password\" type=\"password\" size=\"25\" maxlength=\"10\"><input value=\"Login\" type=\"submit\"></p></form>";
}
?>
<BR>
</div>
<?php require_once("layout.footer.php"); ?>