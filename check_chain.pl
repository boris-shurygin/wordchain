use utf8;
use open qw(:std :utf8);

my $dict_fname = $ARGV[0];
my $chain_fname  = $ARGV[1];

# Read dictionary 
open DICT, "<", $dict_fname or die "Cannot open $dict_fname";

my $dict = {};

while(<DICT>){
	if (/^(\S{4})$/)
	{
		my $word = $1;
		$dict->{$word} = 1;
	}
}

close DICT;

open CHAIN, "<", $chain_fname or die "Cannot open wordchain file $chain_fname";

my $i = 0;
my $ok = 1;

my $prev;
my $used = {};
while(<CHAIN>) {
	if (/^(\S{4})$/) {
		my $word = $1;
		if ( !$dict->{$word}) {
			print "Word $i: no such word $word\n";
			$ok = 0;
			last;
		}
		if ( $used->{$word}) {
			print "Word $i: already used word $word\n";
			$ok = 0;
			last;
		}
		if ($prev) {
			if (!is_valid_transition($prev, $word))	{	
				print "Word $i: invalid transition $prev -> $word\n";
				$ok = 0;
				last;
			}
		}
		$prev = $word;
		$used->{$word} = 1;
	} else {
		$ok = 0;
	}
	$i++;
}
if ($ok) {
	print "$i Success!!!\n";
} else {
	print "Fail!!!\n";
}
	

sub is_valid_transition
{
	my ($prev,$next) = @_;
    my @prev_arr = split //, $prev;
    my @next_arr = split //, $next;

	my $diff_num = 0;
	for (my $i = 0; $i < 4; $i++) {
		if ($prev_arr[$i] ne $next_arr[$i])
		{
			$diff_num++;				
		}
	}
	return 1 if ($diff_num == 1);
	return 0;
}
close CHAIN;
