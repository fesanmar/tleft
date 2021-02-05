module Main where

import System.Environment ( getArgs )
import Data.Maybe ( fromJust, isJust )
import Tleft (tleft)

main :: IO ()
main = do
    args <- getArgs 
    argParser args

usage :: [Char]
usage = "Usage: \n\t tleft <hh:mm> <hh:mm>"

argParser :: [String] -> IO ()
argParser [x]
    | x `elem` helpCommands = putStrLn usage
    | otherwise = putStrLn ("Error: Must specify two or more timestamps.\n" ++ usage)
    where helpCommands = ["--help", "-h"]
argParser args@(x:xs)
    | isJust time = putStrLn (composeTimeLeftString (fromJust time))
    | otherwise = putStrLn ("Error: Expecting two timestamps. Please check usage:\n" ++ usage)
    where time = tleft args

composeTimeLeftString :: (Int, Int) -> String
composeTimeLeftString time = "Time left -> " ++ twoDigitFormatt (fst time) ++ ":" ++ twoDigitFormatt (snd time) ++ " hours"

twoDigitFormatt :: Int -> String
twoDigitFormatt n
    | n >= 10 || n < 0 = show n
    | otherwise = "0" ++ show n