<?php require_once("layout.header.php"); ?>
<script>
function check(){
	var input = prompt("Enter the password!");
	pass = "password";
	pass = String.fromCharCode(0x63, 0x72, 0x79, 0x70, 0x74, 0x30, 0x5f, 0x31, 0x35, 0x5f, 0x66, 0x75, 0x6e);
	if(input == pass){
		location.href=input+".html";
	}else{
		alert("Password Incorrect!");
		check();
	}
}
check();
</script>
<?php require_once("layout.footer.php"); ?>
