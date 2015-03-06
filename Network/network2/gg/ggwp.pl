#!/usr/bin/perl
use IO::Socket;
my $welcome_msg = <<"EOT";

 .d88888b.                             888                                                
d88P" "Y88b                            888                                                
888     888                            888                                                
888     888 88888b.   .d88b.  88888b.  88888b.   .d88b.  888  888 .d8888b   .d88b.        
888     888 888 "88b d8P  Y8b 888 "88b 888 "88b d88""88b 888  888 88K      d8P  Y8b       
888     888 888  888 88888888 888  888 888  888 888  888 888  888 "Y8888b. 88888888       
Y88b. .d88P 888 d88P Y8b.     888  888 888  888 Y88..88P Y88b 888      X88 Y8b.           
 "Y88888P"  88888P"   "Y8888  888  888 888  888  "Y88P"   "Y88888  88888P'  "Y8888        
            888                                                                           
            888                                                                           
            888                                                                                                              

#Only admin is allowed

EOT
$|=1;
$lis = IO::Socket::INET->new (LocalPort => 6969, 
							  Type => SOCK_STREAM, 
							  Reuse=> 1, 
							  Listen => 1000) or die "Error #1 $@\n";



open(agentz,">>agents");
		  
$authenticated = 0;
$logs = "";
sub show_help{
	print $c "\nAdd Agent             : add <agent_name> <age> <origin>";
	print $c "\nPending Data          : pending";
	print $c "\nConfirm modifications : confirm\n";
}


sub add_agent{
	$agent_n = $_[0];
	$age     = $_[1];
	$origin  = $_[2];
	do{
		$rand=int(rand(10000));
		$home = "agent".$rand;
	}while(-d $home);
	if($logs eq ""){
		$logs.=$agent_n.",".$age.",".$origin.",".$home."\n";
		print $c "\nAgent Added !\n";
	}else{
		print $c "\nyou can only add one agent before confirming\n";
	}
}
sub pending{
	if($logs eq ""){
		print $c "\nNothing Pending\n";
	}else{
		print $c "\n".$logs."\n";
	}
}
sub confirm{
	$conf = 0;
  if($logs=~ m/^(.*?),(.*?),(.*?),(.*)/){
    $home=$4;
	$d1=$1;
	$d2=$2;
	$d3=$3;	
	if($home=~ /^[A-OQ-Za-oq-z0-9\s|=\$\/,]+$/ || $d1=~/^[A-OQ-Za-oq-z0-9\s|=\$\/,]+$/ || $d2=~/^[A-OQ-Za-oq-z0-9\s|=\$\/,]+$/ || 
$d3=~/^[A-OQ-Za-oq-z0-9\s|=\$\/,]+$/){
			$cmd="echo \"$d1,$d2,$d3\" > ".$home;
			$ex=`$cmd`;
			if($? == -1){
				print $c "\ncommand failed\n";
				$logs="";
				$conf=0;
			}else{
				print $c "\nWriting agent details at file $home with success\n";
				$conf=1;
			}
		}else{
			print $c "\nError : Non allowed char used Or command way too long\n";
			$logs="";
			$conf=0;
		}
	}
	if($conf){$logs="";print $c "\nConfirmed\n";}
}
while($c = $lis->accept()){
	$start=0;
	if($pid=fork){
		next;
	}else{
		unless (defined $pid) {die "Threads problem $! \n";}
		print $c $welcome_msg."UserName : ";
		$username = <$c>;
		print $c "Password : ";
		$password = <$c>;
		chomp($username);
		chomp($password);
		if(($username eq 'admin') and ($password eq 'password')){
			$authenticated=1;
			print $c "\nWelcome EiEi\n";
			print $c "\nYou can use command : help \n";
			print $c "\n> ";
		}else{
			print $c "\nRejected\n";
		}
		while(($line = <$c>)&&($authenticated==1)){
			print $line;
			chomp($line);
			if($line eq 'help'){
				show_help();
			}elsif($line eq 'agents'){
				agents_display();
			}elsif($line=~m/details (.*)$/i){
				details_agent($1);
			}elsif($line=~m/add <(.*)> <(.*)> <(.*)>$/i){
				add_agent($1,$2,$3);
			}elsif($line eq 'pending'){
				pending();
			}elsif($line eq 'confirm'){
				print $c "y/n ?\n";
				$confirm = <$c>;
				chomp($confirm);
				if($confirm eq 'y'){
					confirm();
				}
			}
			print $c "\n> ";
		}
		close $c;
		exit;
   }
   exit;
}
close $lis;
close(agents);
close(agentz);
