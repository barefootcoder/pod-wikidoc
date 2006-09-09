# Pod::WikiDoc - check module loading and create testing directory

use Test::More;
use IO::String;
use t::Casefiles;

use Pod::WikiDoc;

#--------------------------------------------------------------------------#
# parser setup
#--------------------------------------------------------------------------#

my $parser = Pod::WikiDoc->new( { comment_blocks => 1 } );

#--------------------------------------------------------------------------#
# case file runner
#--------------------------------------------------------------------------#

my $cases = t::Casefiles->new( "t/filter_comments" );

$cases->run_tests( 
    sub { 
        my $input_string = shift;
        my $got = $parser->convert( $input_string );
        $got =~ s{\A [^\n]+ \n \n}{}xms; # strip "Generated by" line
        return $got;
    }
);

