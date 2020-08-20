#!/bin/perl
# 
# ref. https://qz.tsugumi.org/Perl_socket.html

use Socket;

my $port = 9999;
my $s;
socket($s, AF_INET, SOCK_STREAM, getprotobyname("tcp"));
bind  ($s, pack_sockaddr_in($port, inet_aton("0.0.0.0")));
listen($s, SOMAXCONN);

while(my $addr = accept(my $c, $s)){
  my($cport, $caddr) = unpack_sockaddr_in($addr);
  my($host,  $ip)    = (gethostbyaddr($caddr, AF_INET), inet_ntoa($caddr));
  printf "connected from %s(%s):%s\n", $host, $ip, $cport;
  my $t = <$c>;
  $t =~ tr/\r\n//d;
  print "$t\n";
  print $c "--ok--\n";
  close($c);
}
close($s);
