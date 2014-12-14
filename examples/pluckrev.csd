<CsoundSynthesizer>
<CsOptions>
-d -odac:system:playback_ -+rtaudio="jack" 
-B 4096
</CsOptions>
<CsInstruments>

sr	=	96000
ksmps	=	1
nchnls	=	2
0dbfs	=	1

alwayson 999

gaRev init 0

instr 1	
;a1 = oscili(0.1, cpsmidinn(p4), ftgenonce(0, 0, 4096, 10, 1)) * linseg(1, p3, 0)
icps = cpsmidinn(p4)
a1 = pluck(0.4, icps, icps, 0, 1)
a1 = butlp(a1, 4000)
a1 *= expsegr(1, 0.5, 0.00001, 0.1, 0.00001)
outs a1, a1
gaRev = gaRev + a1 * 0.3
endin

instr 999
aoutL, aoutR reverbsc gaRev, gaRev, 0.95, 10000
outs aoutL, aoutR
clear gaRev
endin

</CsInstruments>
<CsScore>
f 0 $INF
t 0 120

</CsScore>
</CsoundSynthesizer>

