#! /usr/bin/perl 
######################################################################################
# Details about the tool
# It is a standalone tool, which runs to find # of connectors running on a given
# connect cluster and its associated tasks
# Its work in progress. Feel free to modify it.
#
# @author : rdhakne@confluent.io
######################################################################################

my $message = "Usage: Example : perl $0 <connect-worker>\n" .
        "Usage: Example : perl $0 mycom.connector.worker01.com\n";
        die "Usage: perl $0 <connect-worker>\n$message\n"
          unless $#ARGV >= 0;

my $host = $ARGV[0] || "localhost";
print "Working on connect host [$host]\n";

my $cmd = "curl -X GET http://$host:8083/connectors/  \| sed \'s/\\[//\' \| sed \'s/\\]//\'";
print "cmd=[$cmd]\n";
my $conn_list = `$cmd`;
chomp($conn_list);

print "list of all the connectors [$conn_list]\n";

my @conns = split(/,/, $conn_list);

print "Found these[@conns] connectors to operate and total of [" . @conns . "]\n";
foreach my $con (@conns) {
	#$command = "curl -X GET http://localhost:8083/connectors/$con | grep \"tasks.max\" | cut -d \":\" -f 7,6";
  $command = "curl -X GET http://$host:8083/connectors/$con | grep \"tasks.max\" | cut -d \":\" -f 7,8";
  my $task_list = `$command`;
  chomp($task_list);
  print "Connector [$con] has tasks [$task_list]\n";
}
#exit 0;
system(exit);

###############################################################################
###############################################################################
sub sig_int_handler {
    my $signal = shift;

    print "\nWARN: SIGINT received...";

    print "Performing cleanup\n";

    # Wait for the threads to finish
    cleanup();
    print "Cleanup Done\n";

    print "Exiting\n";
    exit 1;
}

###############################################################################
###############################################################################
sub cleanup {
    print("Clean up successfull\n");
}

