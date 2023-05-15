import System.Random
import Control.Monad

class (Show a) => Actor a where
    collide :: a -> a -> a
    move :: String -> [a] -> a -> [a]
    rect :: a -> (Int, Int, Int, Int)  -- (x, y, w, h)

data Arena a = Arena { actors :: [a]
                     } deriving (Show)

moveAll :: (Actor a) => String -> [a] -> [a]
moveAll keys actors = applyCollisionEffects (foldl (\acc actor -> move keys acc actor) actors actors)

tick :: (Actor a) => Arena a -> String -> Arena a
tick (Arena actors) keys = 
    Arena (moveAll keys actors)

operateArena :: (Actor a) => Arena a -> IO ()
operateArena arena = do
    print arena
    line <- getLine
    when (line /= "q") $ operateArena (tick arena line)

checkCollision :: (Actor a) => a -> a -> Bool
checkCollision a1 a2 = (rect a1) /= (rect a2) && y2 < y1+h1 && y1 < y2+h2 && x2 < x1+w1 && x1 < x2+w2
    where
        (x1, y1, w1, h1) = rect a1
        (x2, y2, w2, h2) = rect a2

maxX = 320
maxY = 240
actorW = 20
actorH = 20

data BasicActor = Ball { x :: Int, y :: Int, dx :: Int, dy :: Int }
                | Ghost { x :: Int, y :: Int, rnd :: StdGen}
                | Turtle { x :: Int, y :: Int, dead :: Bool} deriving (Show)


instance Eq BasicActor where
    (Ball x1 y1 _ _) == (Ball x2 y2 _ _) = x1 == x2 && y1 == y2
    (Ghost x1 y1 _) == (Ghost x2 y2 _) = x1 == x2 && y1 == y2
    (Turtle x1 y1 _) == (Turtle x2 y2 _) = x1 == x2 && y1 == y2
    _ == _ = False

checkForCollisions :: (Actor a) => [a] -> [a] -> [a]
checkForCollisions [] _ = []
checkForCollisions [a] acc = a:acc
checkForCollisions (x:xs) acc = 
    let collided = filter (checkCollision x) xs
        updated = foldl collide x collided
    in checkForCollisions xs (updated:acc)

applyCollisionEffects :: (Actor a) => [a] -> [a]
applyCollisionEffects actors = checkForCollisions (checkForCollisions actors []) []


updateList :: BasicActor -> BasicActor -> [BasicActor] -> [BasicActor]
updateList oldActor newActor actors = map update actors
  where update actor
          | actor == oldActor = newActor
          | otherwise = actor

instance Actor BasicActor where
    collide (Ball x y dx dy) (Ball x2 y2 _ _) = Ball x y (-dx) (-dy)
    collide (Ball x y dx dy) (Turtle x2 y2 _) = Ball x y (-dx) (-dy)
    collide (Turtle x y _) (Ball _ _ _ _) = Turtle x y True
    collide a _ = a
    rect (Ball x y _ _) = (x, y, actorW, actorH)
    rect (Ghost x y _) = (x, y, actorW, actorH)
    rect (Turtle x y _) = (x, y, actorW, actorH)
    move keys actors (Ball x y dx dy) = 
        let (x', y') = (x + dx, y + dy)
            dx' = if x' <= 0 || x' >= maxX - actorW then -dx else dx
            dy' = if y' <= 0 || y' >= maxY - actorH then -dy else dy
        in updateList (Ball x y dx dy) (Ball x' y' dx' dy') actors
    move keys actors (Ghost x y rnd) =   
        let (dx, newRnd) = randomR (-5, 5) rnd
            (dy, newRnd') = randomR (-5, 5) newRnd
            x' = (x + dx) `mod` maxX
            y' = (y + dy) `mod` maxY
        in updateList (Ghost x y rnd) (Ghost x' y' newRnd') actors
    move keys actors (Turtle x y False) =
        let actor = (Turtle x y False)
        in case keys of
            ('w':_) -> let y' = max 0 (y - 5) in updateList actor (Turtle x y' False) actors
            ('a':_) -> let x' = max 0 (x - 5) in updateList actor (Turtle x' y False) actors
            ('s':_) -> let y' = min (maxY - actorH) (y + 5) in updateList actor (Turtle x y' False) actors
            ('d':_) -> let x' = min (maxX - actorW) (x + 5) in updateList actor (Turtle x' y False) actors
            "newball" -> (Ball 150 170 5 5) : actors
            _ -> actors
    move keys actors (Turtle x y True) = actors

main = do
    rnd <- newStdGen
    operateArena (Arena [Ball 200 100 5 0, Ball 230 100 (-5) 0, Ghost 0 0 rnd, Turtle 100 100 False])