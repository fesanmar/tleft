{-|
Module      : tleft
Description : Super naive CLI aplication that subtracts two timestamps with the format hh:mm.
Copyright   : (c) Felipe-Cruz Martínez-Acalá, 2021
License     : MIT license
Maintainer  : fesanmar@gmail.com
Stability   : experimental
Version     : 1.0.1
-}

import System.Environment
import Text.Read
    
main :: IO ()
main = do
    args <- getArgs 
    argParser args

usage = "Usage: \n\t tleft <hh:mm> <hh:mm>"

argParser :: [String] -> IO ()
argParser (x:[])
    | x `elem` helpCommands = putStrLn usage
    | otherwise = putStrLn ("Error: Must specify two timestamps.\n" ++ usage)
    where helpCommands = ["--help", "-h"]
argParser (x:y:[])
    | isValidTimeRange x y = putStrLn (timeLeftFromArgs x y)
    | areTimestamps [x, y] = putStrLn ("Error: first arg <" ++ x ++ ">" ++ " must be greater or equal to the second <" ++ y ++ ">\n" ++ usage)
    | otherwise = putStrLn ("Error: Expecting two timestamps. Please check usage:\n" ++ usage)
argParser args@(x:y:zs) = putStrLn ("Error: Expecting only two args but " ++ (show (length args)) ++ " where passsed.\n" ++ usage)
 
isValidTimeRange :: String -> String -> Bool
isValidTimeRange a b = areTimestamps [a, b] && a `isBiggerThanOrEqualTo` b

isBiggerThanOrEqualTo :: String -> String -> Bool
isBiggerThanOrEqualTo a b
    | h > h' = True
    | h == h' = m > m' || m == m'
    | otherwise = False
    where 
        h = fromArgToHours a
        h' = fromArgToHours b
        m = fromArgToMinutes a
        m' = fromArgToMinutes b

areTimestamps :: [String] -> Bool
areTimestamps (x:[]) = isValidTime x
areTimestamps (x:xs) = isValidTime x && areTimestamps xs

isValidTime :: String -> Bool
isValidTime (h:h':colon:m:m':[])
    | isValidTime' [h, h'] [colon] [m, m'] = True
    | otherwise = False
isValidTime (h:colon:m:m':[])
    | isValidTime' [h] [colon] [m, m'] = True
    | isValidTime' [h] [colon] [m] = True
    | otherwise = False
isValidTime (h:colon:m:m':_) = False

isValidTime' :: String -> String -> String -> Bool
isValidTime' h colon m = isValidHour h && colon == ":" && isValidMinute m

isValidHour :: String -> Bool
isValidHour a
    | isInt a = castedString >= 0
    | otherwise = False 
    where castedString = (read a :: Int)

isValidMinute :: String -> Bool
isValidMinute a
    | isInt a = castedString >= 0  && castedString <= 59 
    | otherwise = False 
    where castedString = (read a :: Int)

isInt :: String -> Bool
isInt a = (readMaybe a :: Maybe Int) /= Nothing

timeLeftFromArgs :: [Char] -> [Char] -> [Char]
timeLeftFromArgs arg1 arg2 = timeLeftMessage (fromArgToTimeTuple arg1) (fromArgToTimeTuple arg2)

fromArgToTimeTuple :: [Char] -> (Int, Int)
fromArgToTimeTuple arg = (fromArgToHours arg, fromArgToMinutes arg)

fromArgToHours :: [Char] -> Int
fromArgToHours (x:_:_:_:[]) = read [x]
fromArgToHours (x:y:_:__:_:[]) = read [x, y]

fromArgToMinutes :: [Char] -> Int
fromArgToMinutes (_:_:_:m:m':[]) = read ([m, m'])
fromArgToMinutes (_:_:m:m':[]) = read ([m, m'])

timeLeftMessage :: (Int, Int) -> (Int, Int) -> [Char]
timeLeftMessage time1 time2 = composeTimeLeftString (timeLeft time1 time2)

composeTimeLeftString :: (Int, Int) -> [Char]
composeTimeLeftString time = "Time left -> " ++ twoDigitFormatt (fst time) ++ ":" ++ twoDigitFormatt (snd time) ++ " hours"

twoDigitFormatt :: Int -> String
twoDigitFormatt n
    | n >= 10 || n < 0 = show n
    | otherwise = "0" ++ (show n)

timeLeft :: (Int, Int) -> (Int, Int) -> (Int, Int)
timeLeft time1 time2 = (hours, minutes) where 
    minutes = let minutes' = subMinutes (snd time1) (snd time2) in
        if minutes' < 60 then minutes' else 00
    hours = if snd time1 >= snd time2 
            then fst time1 - fst time2 
            else fst time1 - fst time2 - 1

subMinutes :: Int -> Int -> Int 
subMinutes m1 m2 = if m1 > m2 then m1 - m2 else m1 - m2 + 60

hoursLeft :: Int -> Int -> Int 
hoursLeft bigerHour smallerHour = bigerHour - smallerHour
