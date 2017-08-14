#!/usr/bin/env runhaskell
module RWH01 (main) where

-- pg 16

import Test.HUnit

lineCount :: String -> Int
lineCount bytes = length $ lines bytes

wordCount :: String -> Int
wordCount bytes = sum $ map (length . words) $ lines bytes

byteCount :: String -> Int
byteCount = length

main :: IO Counts
main = do
    runTestTT $ test [
        "lineCount tests" ~: test [
            3 ~=? (lineCount "foo\nbar\nquux\n")
        ],
        "wordCount tests" ~: test [ 
            5 ~=? (wordCount "foo bar\nquux spam\nalbatross\n")
        ],
        "byteCount tests" ~: test [
            14 ~=? (byteCount "Hello, world!\n")
        ] ]
            
