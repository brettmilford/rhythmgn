{-# LANGUAGE ConstraintKinds #-}

module RhythmGn.Markov where
import Euterpea
import System.Random
import Data.MarkovChain as M
import RhythmGn.Lib

mc' ps n i = M.run n ps 0 (mkStdGen i)
mcm' pss n i = concat (M.runMulti n pss 0 (mkStdGen i))
mcmcm' pss n i = concat $ concat (M.runMulti n pss 0 (mkStdGen i))

rhythmGen' :: (PercussionSound, Mphrase) -> Int -> Int  -> Music Pitch
rhythmGen' (s,p) n i = dk s $ mcmcm' p n i

rhythmGen :: [(PercussionSound, Mphrase)] -> Int -> Int -> Music Pitch
rhythmGen [] _ _ = rest wn
rhythmGen ((s,p):ds) n i = rhythmGen' (s,p) n i :=: rhythmGen ds n i


{-| TODO: Impliment [Dur] chunking based on timesignature
    Turn [Dur] into Phrase based on TimeSignature
    i.e. chunk a list to beat & bar length

mkPhrase :: TimeSignature -> [Dur] -> Phrase
mkPhrase (i,d) ds = mkBars i $ mkBeats d ds

mkBar :: Int -> [Beat] -> Bar
mkBar i (b:bs) = mkbar' i-1 bs b
          where
          mkbar' _ [] b     = error "not enough beats to make a bar"
          mkbar' 0 _ b      = b
          mkbar' i (m:ms) b = mkbar' i-1 ms m:b

mkBeat :: Dur -> [Dur] -> (Beat,[Dur])
mkBeat l (d:ds)
          | d == l    = ([d],ds)
          | d < b     = mkbeat' l-d ds [d]
          | otherwise = error errmsg
          where
          errmsg = "The rhythm crosses the beat"
          mkbeat' l (d:ds) b
                    | d == l = (d:b,ds)
                    | d < l = mkbeat' l-d ds d:b
                    | otherwise = error errmsg

mkBeats :: Int -> [Dur] ->
mkBeats l ds = mkBeat l ds 
-}
