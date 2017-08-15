#!/usr/bin/env runhaskell
module RWH00 (add, fac, fib, main) where

import Test.HUnit

add :: Int -> Int -> Int
add a b = a + b

fac :: Integer -> Integer
fac n = foldr (*) 1 [1..n]

fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

main :: IO Counts
main = do
    runTestTT $ test [
        "add tests" ~: test [ 5 ~=? (add 2 3),
                              7 ~=? (add 3 4),
                              9 ~=? (add 4 5) ],
        "fac tests" ~: test [ 120 ~=? (fac 5),
                              720 ~=? (fac 6) ],
        "fib tests" ~: test [ 2 ~=? (fib 2) ] ]
