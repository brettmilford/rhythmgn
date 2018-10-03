{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
module RhythmGn.Lib
where
import Euterpea

-- Support for triplets

tbn,twn,thn,tqn,ten,tsn,ttn,tsfn :: Dur
tbnr,twnr,thnr,tqnr,tenr,tsnr,ttnr,tsfnr :: Music Pitch

tbn   = 4/3;   tbnr    = rest tbn
twn   = 2/3;   twnr    = rest twn
thn   = 1/3;   thnr    = rest thn
tqn   = 1/6;   tqnr    = rest tqn
ten   = 1/12;  tenr    = rest ten
tsn   = 1/24;  tsnr    = rest tsn
ttn   = 1/48;  ttnr    = rest ttn
tsfn  = 1/96;  tsfnr   = rest tsfn

{-| better conversion from percussion sound

percToAbsPitch' :: PercussionSound -> AbsPitch
percToAbsPitch' ps = absPitch $ pitch (fromEnum ps + 35)

-}
percToAbsPitch :: PercussionSound -> AbsPitch
percToAbsPitch ps = fromEnum ps + 35

percToPitch :: PercussionSound -> Pitch
percToPitch ps = pitch (fromEnum ps + 35)


{-| Handle durations and rests with the same function
    Adhoc polymorphism 
-}

class Percs a where
      perc' :: PercussionSound -> a -> Music Pitch

instance Percs (Music a) where
      perc' _ (Prim (Rest d)) = rest d

instance Percs Dur where
      perc' ps d = instrument Percussion $ 
                      note d (pitch (fromEnum ps + 35))

{-|
    perc' :: PercussionSound -> Music a -> Music Pitch
    perc' _ (Prim (Rest d)) = rest d
    perc' ps d = instrument Percussion $ note (dur d) (pitch (fromEnum ps + 35))
-}

-- Bind a rhythm to an instrument

dk :: Percs a => PercussionSound -> [a] -> Music Pitch
dk ps ds = line (map (perc' ps) ds)

-- Construct rhythmic structures

type Mphrase = [Bar]
type Bar = [Beats]
type Beats = [Beat]
type Beat = Dur 

{-| TODO: WIP, make polymorphic over Rests as well
    data Beat = Dur | Music Pitch deriving (Show, Eq, Ord)
-}
type TimeSignature = (Int,Dur)

-- ptp :: PercussionSound -> Dur -> Music Pitch
-- ptp ps d = Prim (Note d (percToPitch ps))

-- sounds :: [Dur -> Music Pitch]
sounds = [ptp BassDrum1, ptp AcousticSnare]
-- durs :: [a -> Primitive a]
-- durs = [Note qn, Note en, Rest tn]
-- this approach will map all rests to their own line...
-- percMap :: [Dur -> Music Pitch] -> [Dur] -> Music Pitch
percMap (s:ss) ds = line (map s ds) :=: percMap ss ds

-- Turn PercussionSound into Primitive a
ptp ps d = flip Note (percToPitch ps) d

{-| An attempt to encode behaviour in the performance of
    rhythmic instruments based on the following assumptions: 

    - Simple, quadruple meter (4/4)
    - Beat hirarchy is as follows: 1,3,2,4
    - Phrases are roughly 2^n measures long (2,4,8,16)

data FourFour = FourFour { beatOne :: Dur
                         , beatTwo :: Dur
                         , beatThree :: Dur
                         , beatFour :: Dur
                         } deriving (Show)


data QuarterBeat a = QuarterBeat Music
                  deriving (Show)

mkQuarterBeat :: Music a -> QuarterBeat
mkQuarterBeat m = if dur m == 1 % 4 then m else error "beatOne, is too short or too long"

bar :: FourFour -> Music a
bar b(one two three four) = one :+: two :+: three :+: four

-}

-- An enumerated version

rkick :: Int -> Music Pitch
rkick 1 = rest qn
rkick 2 = perc BassDrum1 qn
rkick 3 = perc BassDrum1 en :+: perc BassDrum1 en
rkick 4 = perc BassDrum1 den :+: perc BassDrum1 sn
rkick 5 = perc BassDrum1 sn :+: perc BassDrum1 den
rkick 6 = tempo (3/2) (perc BassDrum1 en :+: perc BassDrum1 en :+: perc BassDrum1 en)

rsnare :: Int -> Music Pitch
rsnare 1 = rest qn
rsnare 2 = perc AcousticSnare qn
rsnare 3 = perc AcousticSnare en :+: perc AcousticSnare en
rsnare 4 = perc AcousticSnare den :+: perc AcousticSnare sn
rsnare 5 = perc AcousticSnare sn :+: perc AcousticSnare den
rsnare 6 = tempo (3/2) (perc AcousticSnare en :+: perc AcousticSnare en :+: perc AcousticSnare en)

rhihat :: Int -> Music Pitch
rhihat 1 = rest qn
rhihat 2 = perc ClosedHiHat qn
rhihat 3 = perc ClosedHiHat en :+: perc ClosedHiHat en
rhihat 4 = perc ClosedHiHat den :+: perc ClosedHiHat sn
rhihat 5 = perc ClosedHiHat sn :+: perc ClosedHiHat den
rhihat 6 = tempo (3/2) (perc ClosedHiHat en :+: perc ClosedHiHat en :+: perc ClosedHiHat en)

rhitom :: Int -> Music Pitch
rhitom 1 = rest qn
rhitom 2 = perc HighTom qn
rhitom 3 = perc HighTom en :+: perc HighTom en
rhitom 4 = perc HighTom den :+: perc HighTom sn
rhitom 5 = perc HighTom sn :+: perc HighTom den
rhitom 6 = tempo (3/2) (perc HighTom en :+: perc HighTom en :+: perc HighTom en)

