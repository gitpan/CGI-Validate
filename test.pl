# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $ok = 0; $| = 1; $total = 29; print "1..$total\n"; }
END {print "not ok 1\n" unless $ok;}
use CGI::Validate qw(:all);
printf '%-20s', 'load';
print "ok 1\n"; $ok++;

@ARGV = qw(
	StringValid=ValidString StringBlank=
	WordValid=ValidWord		WordInvalid=@$	WordBlank=
	IntegerValid=123		IntegerInvalid1=foo
	IntegerInvalid2=12.2	IntegerBlank=
	FloatValid=12.3			FloatInvalid1=foo
	FloatInvalid2=12.2.		FloatBlank=
	EmailValid=foo@bar.com	EmailInvalid=@bar.com
	EmailBlank=
	ExtensionOneValid=foo:bar	ExtensionOneInvalid=foobar
	ExtensionOneBlank=
	InvalidField1=foo		InvalidField2=
	MultipleString=foo		MultipleString=bar
	MultipleString=cat		MultipleString=dog
);

addExtensions (
	ExtensionOne	=> sub { shift =~ /:/ }
);

my %Values = ();

$Values{MultipleString} = [];

my $Query = GetFormData (
	'StringValid=s'		=> \$Values{StringValid},
	'StringBlank=s'		=> \$Values{StringBlank},
	'WordValid=w'		=> \$Values{WordValid},
	'WordBlank=w'		=> \$Values{WordBlank},
	'WordInvalid=w'		=> \$Values{WordInalid},
	'IntegerValid=i'	=> \$Values{IntegerValid},
	'IntegerInvalid1=i'	=> \$Values{IntegerInvalid1},
	'IntegerInvalid2=i'	=> \$Values{IntegerInvalid2},
	'IntegerBlank=i'	=> \$Values{IntegerBlank},
	'FloatValid=f'		=> \$Values{FloatValid},
	'FloatInvalid1=f'	=> \$Values{FloatInalid1},
	'FloatInvalid2=f'	=> \$Values{FloatInalid2},
	'FloatBlank=f'		=> \$Values{FloatBlank},
	'EmailValid=e'		=> \$Values{EmailValid},
	'EmailInvalid=e'	=> \$Values{EmailInvalid},
	'EmailBlank=e'		=> \$Values{EmailBlank},
	'ExtensionOneValid=xExtensionOne'	=> \$Values{ExtensionOneValid},
	'ExtensionOneInvalid=xExtensionOne'	=> \$Values{ExtensionOneInvalid},
	'ExtensionOneBlank=xExtensionOne'	=> \$Values{ExtensionOneBlank},
	'MultipleString=s'	=> $Values{MultipleString},
	'MissingOne=s'		=> \$Values{MissingOne},
);

printf '%-20s', 'base';
if ($query) {
	print "not ok 2\n";
} else {
	print "ok 2\n"; $ok++;
}

printf '%-20s', 'invalid field one';
if ($Invalid{InvalidField1}) {
	print "ok 3\n"; $ok++
} else {
	print "not ok 3\n";
}
delete $Invalid{InvalidField1};

printf '%-20s', 'invalid field two';
if ($Invalid{InvalidField2}) {
	print "ok 4\n"; $ok++;
} else {
	print "not ok 4\n";
}
delete $Invalid{InvalidField2};

printf '%-20s', 'blank email';
if ($Blank{EmailBlank}) {
	print "ok 5\n"; $ok++;
} else {
	print "not ok 5\n";
}
delete $Blank{EmailBlank};

printf '%-20s', 'blank word';
if ($Blank{WordBlank}) {
	print "ok 6\n"; $ok++;
} else {
	print "not ok 6\n";
}
delete $Blank{WordBlank};

printf '%-20s', 'blank float';
if ($Blank{FloatBlank}) {
	print "ok 7\n"; $ok++;
} else {
	print "not ok 7\n";
}
delete $Blank{FloatBlank};

printf '%-20s', 'blank integer';
if ($Blank{IntegerBlank}) {
	print "ok 8\n"; $ok++;
} else {
	print "not ok 8\n";
}
delete $Blank{IntegerBlank};

printf '%-20s', 'blank extension';
if ($Blank{ExtensionOneBlank}) {
	print "ok 9\n"; $ok++;
} else {
	print "not ok 9\n";
}
delete $Blank{ExtensionOneBlank};

printf '%-20s', 'blank string';
if ($Blank{StringBlank}) {
	print "ok 10\n"; $ok++;
} else {
	print "not ok 10\n";
}
delete $Blank{StringBlank};

printf '%-20s', 'invalid blanks';
unless (%Blank) {
	print "ok 11\n"; $ok++;
} else {
	print "not ok 11\n";
}

printf '%-20s', 'invalid word';
if ($InvalidType{WordInvalid}) {
	print "ok 12\n"; $ok++;
} else {
	print "not ok 12\n";
}
delete $InvalidType{WordInvalid};

printf '%-20s', 'invalid extension';
if ($InvalidType{ExtensionOneInvalid}) {
	print "ok 13\n"; $ok++;
} else {
	print "not ok 13\n";
}
delete $InvalidType{ExtensionOneInvalid};

printf '%-20s', 'invalid float one';
if ($InvalidType{FloatInvalid1}) {
	print "ok 14\n"; $ok++;
} else {
	print "not ok 14\n";
}
delete $InvalidType{FloatInvalid1};

printf '%-20s', 'invalid integer one';
if ($InvalidType{IntegerInvalid1}) {
	print "ok 15\n"; $ok++;
} else {
	print "not ok 15\n";
}
delete $InvalidType{IntegerInvalid1};

printf '%-20s', 'invalid email';
if ($InvalidType{EmailInvalid}) {
	print "ok 16\n"; $ok++;
} else {
	print "not ok 16\n";
}
delete $InvalidType{EmailInvalid};

printf '%-20s', 'invalid float two';
if ($InvalidType{FloatInvalid2}) {
	print "ok 17\n"; $ok++;
} else {
	print "not ok 17\n";
}
delete $InvalidType{FloatInvalid2};

printf '%-20s', 'invalid integer two';
if ($InvalidType{IntegerInvalid2}) {
	print "ok 18\n"; $ok++;
} else {
	print "not ok 18\n";
}
delete $InvalidType{IntegerInvalid2};

printf '%-20s', 'invalid invalid-type';
unless (%InvalidType) {
	print "ok 19\n"; $ok++;
} else {
	print "not ok 19\n";
}

printf '%-20s', 'invalid invalids';
unless (%Invalid) {
	print "ok 20\n"; $ok++;
} else {
	print "not ok 20\n";
}

printf '%-20s', 'missing one';
if ($Missing{MissingOne}) {
	print "ok 21\n"; $ok++;
} else {
	print "not ok 21\n";
}
delete $Missing{MissingOne};

printf '%-20s', 'invalid missing';
unless (%Missing) {
	print "ok 22\n"; $ok++;
} else {
	print "not ok 22\n";
}

printf '%-20s', 'valid string';
if ($Values{StringValid} eq 'ValidString') {
	print "ok 23\n"; $ok++;
} else {
	print "not ok 23\n";
}

printf '%-20s', 'valid word';
if ($Values{WordValid} eq 'ValidWord') {
	print "ok 24\n"; $ok++;
} else {
	print "not ok 24\n";
}

printf '%-20s', 'valid integer';
if ($Values{IntegerValid} == 123) {
	print "ok 25\n"; $ok++;
} else {
	print "not ok 25\n";
}

printf '%-20s', 'valid float';
if ($Values{FloatValid} == 12.3) {
	print "ok 26\n"; $ok++;
} else {
	print "not ok 26\n";
}

printf '%-20s', 'valid email';
if ($Values{EmailValid} eq 'foo@bar.com') {
	print "ok 27\n"; $ok++;
} else {
	print "not ok 27\n";
}

printf '%-20s', 'valid extension';
if ($Values{ExtensionOneValid} eq 'foo:bar') {
	print "ok 28\n"; $ok++;
} else {
	print "not ok 28\n";
}

printf '%-20s', 'multiple select';
if (scalar @{ $Values{MultipleString} } == 4) {
	print "ok 29\n"; $ok++;
} else {
	print "not ok 29\n";
}

if ($ok != $total) {
	$failed = $total - $ok;
	die "Failed $failed out of $total tests\n";
} else {
	print "Passed all $total tests\n";
}
