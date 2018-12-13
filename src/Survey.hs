-- | Survey code

module Survey where
import           Euterpea
import           RhythmGn

myRhythms1 = [qn,en,sn,hn]
myRhythms2 = [hn,ten,tqn,qn]
myRhythms3 = [thn,en,hn,sn]

myInstruments1 = [BassDrum1,OpenHiHat,ClosedHiHat,AcousticSnare]
myInstruments2 = [BassDrum1,OpenHiHat,ClosedHiHat,AcousticSnare]
myInstruments3 = [BassDrum1,OpenHiHat,ClosedHiHat,AcousticSnare]

myudRhythm1 = udRhythm myInstruments1 myRhythms1 42
myudRhythm2 = udRhythm myInstruments2 myRhythms2 76
myudRhythm3 = udRhythm myInstruments3 myRhythms3 94

bea00,bea01,bea02,bea03,bea04,bea05,bea06,bea07,bea08,bea09 :: [Beat]
be00 = [wn]
be01 = [bn]
be02 = [dwn]
be03 = [dhn]
bea00 = [hn]
bea01 = [qn]
bea02 = [en,en]
bea03 = [en,sn,sn]
bea04 = [sn,sn,en]
bea05 = [sn,en,sn]
bea06 = [sn,sn,sn,sn]
bea07 = [ten,ten,ten]
bea08 = [tqn,ten]
bea09 = [ten,tqn]

-- | dotted groups
bea31,bea32,bea33,bea34 :: [Beat]
bea31 = [den,sn]
bea32 = [sn,den]
bea33 = [dden,tn]
bea34 = [tn,dden]

-- | syncopation groups

bea51,beb51,bec51,bea52,beb52,bec52,bed52,bee52 :: [Beat]
bea51 = [en]; beb51 = [qn,en]; bec51 = [en,qn]
bea52 = [en,en,sn]; beb52 = [sn,en]; bec52 = [en,sn,sn,sn]
bed52 = [sn,sn,sn,sn,sn]; bee52 = [sn,sn,sn]

bar01,bar02,bar03,bar04,bar05,bar06,bar07,bar08,bar09 :: Bar
bar01 = [bea01,bea01,bea31,bea01]
bar02 = [bea01,bea01,bec51,bea51]
bar03 = [bea01,bea01,bea00]
bar04 = [bea00,bea00]
bar05 = [bea00,bea01,bea00]; bar06 = [bea00,bea01]; bar07 = [bea01,bea00]
bar08 = [bea00,bea08,bea00]
bar09 = [bea06,bea01,bea01,bea01]
bar10 = [bea01,bea07,bea01,bea08]
bar11 = [be00]
bar12 = [be01]
bar13 = [be02]; bar15 = [bea00]; bar16 = [bea01,bea09]
bar14 = [be03]
bar17 = [bea00,bea01,bea09]
bar18 = [bea00,bea01,bea08]
bar20 = [bea01,bea07,bea01,bea06]
bar19 = [bea01,bea07,bea04,bea08]

-- | 30s @ 60 bpm = ~ 8 Bars

phr01,phr02,phr03,phr04,phr05,phr06,phr07,phr08 :: Mphrase
phr01 = [bar01,bar01,bar01,bar02,bar01,bar01,bar01,bar03]
phr05 = [bar04,bar04,bar04,bar02,bar04,bar04,bar05,bar06]
phr02 = [bar07,bar04,bar04,bar04,bar04,bar04,bar04,bar08]
phr06 = [bar09,bar09,bar09,bar04,bar09,bar09,bar09,bar10]
phr03 = [bar12,bar13,bar15,bar12,bar13,bar15]
phr07 = [bar12,bar13,bar16,bar12,bar13,bar16]
phr04 = [bar17,bar18,bar17,bar18,bar17,bar18,bar17,bar20]
phr08 = [bar11,bar18,bar11,bar20,bar11,bar18,bar11,bar19]

rhythmGen1 = rhythmGen [(BassDrum1,phr01),(AcousticSnare,phr02),(OpenHiHat,phr03),(ClosedHiHat,phr04)] 5 42
rhythmGen2 = rhythmGen [(BassDrum1,phr05),(AcousticSnare,phr06),(OpenHiHat,phr07),(ClosedHiHat,phr08)] 5 42
rhythmGen3 = rhythmGen [(BassDrum1,phr01),(AcousticSnare,phr02),(OpenHiHat,phr07),(ClosedHiHat,phr08)] 5 35

bea10,bea11,bea12,bea13,bea14,bea15,bea16,bea17,bea18,bea19,bea20,bea21,bea22,bea23 :: [Beat]
bea10 = [tn,tn,tn,tn,tn,tn,tn,tn]
bea11 = [sn,sn,tn,tn,tn,tn]
bea12 = [tn,tn,tn,tn,sn,sn]
bea13 = [sn,sn,sn,tn,tn]
bea14 = [sn,sn,tn,tn,sn]
bea15 = [sn,tn,tn,sn,sn]
bea16 = [tn,tn,sn,sn,sn]
bea17 = [tn,tn,tn,tn,tn,tn,sn]
bea18 = [tn,tn,tn,tn,tn,sn,tn]
bea19 = [tn,tn,tn,tn,sn,tn,tn]
bea20 = [tn,tn,tn,sn,tn,tn,tn]
bea21 = [tn,tn,sn,tn,tn,tn,tn]
bea22 = [tn,sn,tn,tn,tn,tn,tn]
bea23 = [sn,tn,tn,tn,tn,tn,tn]
