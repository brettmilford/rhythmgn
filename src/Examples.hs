module Examples where
import           Euterpea
import           RhythmGn

{-| Simple, non-generative rhythm
    The play this with `play rhythmicPattern`
-}

kick = perc BassDrum1 en
ohhat = perc OpenHiHat en
chhat = perc ClosedHiHat sn
snare = perc AcousticSnare en

kickLine = line[kick, rest qn, kick, kick, rest dqn]
snareLine = line[rest qn, snare, rest qn, snare]
chhatLine = line[rest sn, chhat, chhat, chhat]
rhythmicPattern = kickLine :=: snareLine :=: times 4 chhatLine

{-| Self Similar Generator
    See RhythmGn.SelfSimilar for more information
    Usage: `> play tma`
-}

smp1 :: [SNote]
smp1 = [(en,36),(qn,0),(en,36),(en,36),(dqn,0)]
smp2 = [(qn,0),(en,38),(qn,0),(en,38)]
smp3 = [(sn,0),(sn,42),(sn,42),(sn,42),(sn,0),(sn,42),(sn,42),(sn,42),(sn,0),(sn,42),(sn,42),(sn,42),(sn,0),(sn,42),(sn,42),(sn,42)]

tm1 = instrument Percussion (ss smp1 4 0 (1/100))
tm2 = instrument Percussion (ss smp2 4 0 (1/100))
tm3 = instrument Percussion (ss smp3 4 0 (1/100))
tma = tm1 :=: tm2 :=: tm3

{-| Random Generator with probability distributions
    See RhythmGn.Random for more info
    Usage: `play myudRhythm`
-}

-- N.B Rests in the same list cause a type error
-- e.g. myRhythms = [qnr,en,sn,hnr]
myRhythms = [qn,en,sn,hn]
myInstruments = [BassDrum1,OpenHiHat,ClosedHiHat,AcousticSnare]

-- Uniform distribution
myudRhythm = udRhythm myInstruments myRhythms 42

-- Linear distribution
myldRhythm = ldRhythm myInstruments myRhythms 42

-- Exponential distribution
myedRhythm = edRhythm myInstruments myRhythms 42 0.34

-- Gaussian distribution
mygdRhythm = gdRhythm myInstruments myRhythms 42 0.34 0

{-| Markov Chains
    See RhythmGn.Markov for more information
    Usage: `> play testRhythmGen`
-}

bea01,bea02,bea03,bea04,bea05,bea06 :: [Beat]
bea01 = [qn]
bea02 = [en,en]
bea03 = [en,en]
bea04 = [en,en]
bea05 = [qn,qn,qn,qn]
bea06 = [ten,ten,ten]

bar01,bar02 :: Bar
bar01 = [bea01,bea03,bea06,bea01]
bar02 = [bea02,bea01,bea05,bea04]

phr01,phr02 :: Mphrase
phr01 = [bar01,bar02]
phr02 = [bar02,bar01]

-- Phrases must corespond to instruments, it doesn't make sense to
-- select the instrument randomly as in the random implementation
testRhythmGen = rhythmGen [(BassDrum1,phr01),(AcousticSnare,phr02)] 3 42
