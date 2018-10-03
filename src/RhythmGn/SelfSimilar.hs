module RhythmGn.SelfSimilar where
import Euterpea

data Cluster  = Cluster SNote [Cluster]
type SNote    = (Dur,AbsPitch)

selfSim      :: [SNote] -> Cluster
selfSim pat  = Cluster (0,0) (map mkCluster pat)
    where mkCluster note =
            Cluster note (map (mkCluster . addMult note) pat)

addMult                  :: SNote -> SNote -> SNote
addMult (d0,p0) (d1,p1)  = (d0*d1,p0+p1)

fringe                       :: Int -> Cluster -> [SNote]
fringe 0 (Cluster note cls)  = [note]
fringe n (Cluster note cls)  = concatMap (fringe (n-1)) cls


simToMusic     :: [SNote] -> Music Pitch
simToMusic     = line . map mkNote

mkNote         :: (Dur,AbsPitch) -> Music Pitch
mkNote (d,ap)  = note d (pitch ap)

-- ss :: [SNote] -> Int -> AbsPitch -> Dur -> Music a
ss pat n tr te = transpose tr $ tempo te $ simToMusic $ fringe n $ selfSim pat
