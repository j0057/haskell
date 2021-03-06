#!/usr/bin/env runhaskell
module RWH02 (main) where

{- RWH pg 39
   and http://www.randomhacks.net.s3-website-us-east-1.amazonaws.com/2007/03/10/haskell-8-ways-to-report-errors/
   and https://stackoverflow.com/revisions/6147930/2 ...
   and https://stackoverflow.com/a/6009807/424131 -}

import Control.Exception
import Test.HUnit

last' :: [a] -> a
last' [] = error "last': empty list"
last' (x:xs) | null xs   = x
             | otherwise = last' xs

secondLast :: [a] -> a
secondLast (x1:x2:xs) | null xs   = x1
                      | otherwise = secondLast (x2:xs)
secondLast _ = error "secondLast: list too short"

main :: IO Counts
main = do
    runTestTT $ test [
        "last tests" ~: test [
            test $ do { result <- try $ evaluate $ last' [] :: IO (Either ErrorCall Int)
                      ; case result of
                            Left ex -> return ()
                            Right v -> assertFailure ("expected ErrorCall exception, not " ++ show v)
                      },
            13 ~=? (last' [13]),
            13 ~=? (last' [1, 4, 13])
        ],
        "secondLast tests" ~: test [
            test $ do { result <- try $ evaluate $ secondLast [] :: IO (Either ErrorCall Int)
                      ; case result of
                            Left ex -> return ()
                            Right v -> assertFailure ("expected ErrorCall exception, not " ++ show v)
                      },
            test $ do { result <- try $ evaluate $ secondLast [1] :: IO (Either ErrorCall Int)
                      ; case result of
                            Left ex -> return ()
                            Right v -> assertFailure ("expected ErrorCall exception, not " ++ show v)
                      },
            1 ~=? (secondLast [1, 2]),
            2 ~=? (secondLast [1, 2, 3]),
            3 ~=? (secondLast [1, 2, 3, 4]),
            4 ~=? (secondLast [1, 2, 3, 4, 5])
        ] ]
