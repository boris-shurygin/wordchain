#Read dictionary
use utf8;
use open qw(:std :utf8);

my $dict = {};

while(<>)
{
	my $str=$_;
	$str = chomp $str;
	$dict->{$str} = 1;
}

