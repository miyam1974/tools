#!/usr/bin/env perl

# ---- SETTING
$interp = "/path/to/interpreter";
$script = "/path/to/script";
$log    = "${0}.log";

# ---- BACKGROUND JOB
`$interp $script 1> $log 2>&1 &`;

# ---- OUTPUT HTML
print  "Content-type: text/html\n\n";
printf "<html><body>ok</body></html>\n";
