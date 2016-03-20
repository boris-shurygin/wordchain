# Makes a list of 4-letter nouns from input dictionary
use utf8;
use open qw(:std :utf8);

my $i = 0;

my $words = {};

while(<>)
{
	my $str = $_;
	if ($str=~/^(\S{4})\s+NOUN/)
	{
		my $word = $1;
		if ( !defined ($words->{$word})     #remove copies
			 && $str=~/sing/ 
			 && $str=~/nomn/ 
			 && !($str=~/Name/) 
			 && !($str=~/Patr/)
			 && !($str=~/Orgn/)
			 && !($str=~/Surn/)
			 && !($str=~/Abbr/)
			 && !($str=~/Fixd/)
			 && !($str=~/Geox/) 
			)
		{
			$words->{$word} = 1;
			print $word."\n";
		}
	}
}