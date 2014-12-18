sub rep {
	my $times = $_[0];
	my $output = "";
	foreach(1..$times) {$output .= eval $_[1];}
	$output;
}

sub rev {
	my @val = split "", eval $_[0];
	#print join "", reverse @val;
	my $output = join "", reverse @val;
	$output;
}

sub ch{
	eval $_[int rand scalar @_];
}

sub nrt_encode {
	my $str = $_[0];
	$str =~ s/'/^/g;
	$str =~ s/,/_/g;
	$str =~ s/\./x/g;
	$str =~ s/:/,/g;
	return $str;
}

sub nrt_decode {
	my $str = $_[0];
	$str =~ s/\^/'/g;
	$str =~ s/_/,/g;
	$str =~ s/x/./g;
	return $str;
}
print
rep 2,mfs
;
print "\n";
my $output = rev(rep 2,mrd).trd;
print nrt $output."\n";

$output = "rev rep 2:d4.r8";
print nrt_decode eval nrt_encode($output)."\n";
