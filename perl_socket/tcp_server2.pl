#!/usr/bin/perl
# ----------------------------------------------------------------------
# 引数に指定したポート番号でTCPのポートをリッスンする簡易プログラム
# http://www.samba.gr.jp/ml/article/samba-jp/msg15726.html

use Socket;

$port = $ARGV[0];

socket(CLIENT_WAITING,PF_INET,SOCK_STREAM,0) or die "Can't create Socket.$!";
setsockopt(CLIENT_WAITING,SOL_SOCKET,SO_REUSEADDR,1) or die "setsockoptfaild.$!";
bind(CLIENT_WAITING,pack_sockaddr_in($port,INADDR_ANY)) or die "bindfaild.$!";
listen(CLIENT_WAITING,SOMAXCONN) or die "listen: $!";

print "looking port number [$port]\n";

while (1){
    $paddr = accept(CLIENT,CLIENT_WAITING);
    ($client_port,$client_iaddr) = unpack_sockaddr_in($paddr);
    $client_hostname = gethostbyaddr($client_iaddr,AF_INET);
    $client_ip = inet_ntoa($client_iaddr);

    print "---------------------------------------------------------\n";
    print "connect: $client_hostname ($client_ip) port->$client_port\n";

    select(CLIENT); $|=1; select(STDOUT);
    while (<CLIENT>){
        print "message: $_";
        print CLIENT $_;
    }
    close(CLIENT);

    print "closed looking port number [$port]\n";
}
# ----------------------------------------------------------------------
