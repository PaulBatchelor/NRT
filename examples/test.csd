<CsoundSynthesizer>
<CsOptions>
-d -odac:system:playback_ -+rtaudio="jack" 
-B 4096
-t240
</CsOptions>
<CsInstruments>

sr	=	96000
ksmps	=	1
nchnls	=	2
0dbfs	=	1

instr 1	
ibase = 60
icps = cpsmidinn(ibase + p4)
a1 = foscili(0.1, icps, 1, 1, 1, ftgenonce(0, 0, 4096, 10, 1)) * linseg(1, p3, 0)
outs a1, a1
endin

</CsInstruments>
<CsScore bin="./nrt -c ">
S8Fl4tM8Rf4sR8Dm4sD2.#NokiaRingTone #MicroLanguage #NeedMoreHobbies
</CsScore>
</CsoundSynthesizer>

