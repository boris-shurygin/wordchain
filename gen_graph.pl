use utf8;
use open qw(:std :utf8);

my $dict_fname = $ARGV[0];
my $start_word  = $ARGV[1];
my $print_chain = 0;

$print_chain = 1 if $ARGV[2] eq "--print";

# Read dictionary 
open DICT, "<", $dict_fname or die "Cannot open $dict_fname";

my $dict = {};
my $num_words = 0;
while(<DICT>){
	if (/^(\w{4})/)
	{
		my $word = $1;
		$dict->{$word} = 1;
		$num_words++;
	}
}
print "Loaded dictionary with $num_words words\n";

close DICT;

my @words = gen_words("КОРТ");
print join ", ", @words;

exit 0;

sub gen_words
{
    my ($word) = @_;
    my @word_arr = split //, $word;
    my @letters = split //, "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ";
    for (my $i = 0; $i < @word_arr; ++$i)
    {
        my @new_word_arr = @word_arr;
    	foreach my $letter (@letters)
	    {
            @new_word_arr[$i] = $letter;
	        my $new_word = join '', @new_word_arr;
	        push @new_words, $new_word if ($new_word ne $word && $dict->{$new_word});
	    }
    }
	return @new_words;
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
