use 5.010;
use strict;

my @chunks =  qw (d4sd r4d8r4m D8ts R4.MD D8tsmR4 d1s2r1);

foreach(1..15)
{
    print $chunks[int rand scalar @chunks]
}
