#!/usr/bin/env runhaskell
module RWH03 (main) where

{- RWH ch03 pg60 pg69 pg70 -}

import Data.List (sortBy)
import Control.Exception
import Test.HUnit

data List a = Cons a (List a)
            | Nil
    deriving (Show, Eq)

data Tree a = Node a (Tree a) (Tree a)
            | Empty
    deriving (Show)

data MTree a = MNode a (Maybe (MTree a)) (Maybe (MTree a))
    deriving (Show, Eq)

data Direction = CCW | CL | CW
    deriving (Eq, Show)

fromList :: [a] -> List a
fromList (x:xs) = Cons x $ fromList xs
fromList []     = Nil

toList :: List a -> [a]
toList (Cons x xs) = x : toList xs
toList Nil         = []

listMean :: [Float] -> Float
listMean [] = error "listMean: empty list"
listMean xs = (sum xs) / (fromIntegral $ length xs)

myLength :: [a] -> Int
myLength []     = 0
myLength (_:xs) = 1 + myLength xs

makePalindrome :: [a] -> [a]
makePalindrome xs = xs ++ sx
    where sx = reverse xs

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = xs == sx
    where sx = reverse xs

sortByLength :: [[a]] -> [[a]]
sortByLength xs = sortBy compareLengths xs
    where compareLengths xs ys = compare (length xs) (length ys)

intersperse :: a -> [[a]] -> [a]
intersperse sep []     = []
intersperse sep (x:xs) | null xs   = x
                       | otherwise = x ++ [sep] ++ (intersperse sep xs)

treeDepth :: Tree a -> Int
treeDepth Empty = 0
treeDepth (Node _ left right) = 1 + (max (treeDepth left) (treeDepth right))

direction :: (Int, Int) -> (Int, Int) -> (Int, Int) -> Direction
direction (x1, y1) (x2, y2) (x3, y3) | crossProduct > 0 = CCW
                                     | crossProduct < 0 = CW
                                     | otherwise        = CL
    where crossProduct = (x2-x1) * (y3-y1) - (y2-y1) * (x3-x1)

main :: IO Counts
main = do
    runTestTT $ test [ "fromList"       ~: [ (Cons 1 (Cons 2 Nil)) ~=? (fromList [1, 2]) ]
                     , "toList"         ~: [ [1, 2] ~=? (toList (Cons 1 (Cons 2 Nil))) ]
                     , "myLength"       ~: [ 0 ~=? (myLength [])
                                           , 3 ~=? (myLength [1..3])
                                           ]
                     , "listMean"       ~: [ test $ do { result <- try $ evaluate $ listMean [] :: IO (Either ErrorCall Float)
                                                       ; case result of
                                                           Left ex -> return ()
                                                           Right v -> assertFailure ("expected ErrorCall exception, not " ++ show v)
                                                       }
                                           , 2.0 ~=? (listMean [1..3])
                                           , 5.5 ~=? (listMean [1..10])
                                           ]
                     , "makePalindrome" ~: [ [1,2,3,3,2,1] ~=? (makePalindrome [1..3]) ]
                     , "isPalindrome"   ~: [ True ~=? (isPalindrome [1,2,3,3,2,1])
                                           , False ~=? (isPalindrome [1..16])
                                           ]
                     , "sortByLength"   ~: [ [[1], [1,2], [1,2,3]] ~=? (sortByLength [[1,2],[1],[1,2,3]]) ]
                     , "intersperse"    ~: [ [1,0,2,0,3] ~=? (intersperse 0 [[1],[2],[3]])
                                           , "" ~=? (intersperse ',' [])
                                           , "foo" ~=? (intersperse ',' ["foo"])
                                           , "foo,bar,baz,quux" ~=? (intersperse ',' ["foo","bar","baz","quux"])
                                           ]
                     , "treeDepth"      ~: [ 0 ~=? (treeDepth Empty)
                                           , 1 ~=? (treeDepth (Node 1 Empty Empty))
                                           , 2 ~=? (treeDepth (Node 2 (Node 1 Empty Empty) Empty))
                                           ]
                     , "direction"      ~: [ CCW ~=? (direction (0, 0) (1, 1) (0, 1))
                                           , CL  ~=? (direction (0, 0) (1, 1) (2, 2))
                                           , CW  ~=? (direction (0, 0) (1, 1) (1, 0))
                                           ]
                     ]
