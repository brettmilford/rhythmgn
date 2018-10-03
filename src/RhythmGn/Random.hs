module RhythmGn.Random where
import Euterpea
import System.Random
import System.Random.Distributions
import RhythmGn.Lib

{-| Uniform Distribution
    List of percussion sounds, list of durations, seed int
udRhythm :: [PercussionSound] -> [a] -> Int -> Music Pitch
-}
udRhythm [] _ _ = rest wn
udRhythm (p:ps) rs n = dk p (map (selectRhythm rs) (r n)) :=: udRhythm ps rs (n + 256)
  where
    r n = randomRs (0,length(rs)-1) (mkStdGen n)

{-| Linear distribution
selectRhythm :: [a] -> Int -> a
-}
selectRhythm rs i = rs !! i

-- ldRhythm :: [PercussionSound] -> [a] -> Int -> Music Pitch
ldRhythm [] _ _ = rest wn
ldRhythm (p:ps) rs n = dk p (map (selectRhythm rs) l) :=: ldRhythm ps rs (n+256)
  where l   = map (toRange (0,length(rs)-1)) rs1
        rs1 = rands linear (mkStdGen n)

-- tuplet in the form (lower bound, range), a (random) float
toRange :: (Int,Int) -> Float -> Int
toRange (l,r) x = round (fromIntegral(l) * x + fromIntegral(r))

{-| Exponential distribution
edRhythm :: [PercussionSound] -> [a] -> Int -> Float -> Music Pitch
-}
edRhythm [] _ _ _ = rest wn
edRhythm (p:ps) rs n lam = dk p (map (selectRhythm rs) l)
                            :=: edRhythm ps rs (n+245) lam
  where l   = map (toRange (0,length(rs)-1)) rs1
        rs1 = rands (exponential lam) (mkStdGen n)

{-| Gaussian distribution
gdRhythm :: [PercussionSound] -> [a] -> Int -> Float -> Float -> Music Pitch
-}
gdRhythm [] _ _ _ _ = rest wn
gdRhythm (p:ps) rs n sig m = dk p (map (selectRhythm rs) l)
                              :=: gdRhythm ps rs (n+256) sig m
  where l   = map (toRange (0,length(rs)-1)) rs1
        rs1 = rands (gaussian sig m) (mkStdGen n)

-- TODO: Impliment rhythm selection within beat unit
