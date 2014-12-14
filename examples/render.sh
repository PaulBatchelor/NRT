perl note_gen.pl | nrt | awk -v BASE=60 -v TEMPO=220 -F, \
'BEGIN{t = 60/TEMPO} {print "i1 " $1*t,$2*t,($3+BASE)}' \
| csound -Lstdin pluckrev.csd 
