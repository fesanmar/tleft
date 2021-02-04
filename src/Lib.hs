module Lib
    ( tleft
    ) where

import Text.Read ( readMaybe )
import Data.Char ( isNumber )

tleft :: [String] -> Maybe (Int, Int)
tleft args
    | areTimestamps args = Just (foldl1 timeLeft (map fromArgToTimeTuple args))
    | otherwise = Nothing 

areTimestamps :: [String] -> Bool
areTimestamps [x] = isValidTime x
areTimestamps (x:xs) = isValidTime x && areTimestamps xs

isValidTime :: String -> Bool
isValidTime [h, h', colon, m, m']
    | isValidTime' [h, h'] [colon] [m, m'] = True
    | otherwise = False
isValidTime [h, colon, m,m']
    | isValidTime' [h] [colon] [m, m'] = True
    | isValidTime' [h] [colon] [m] = True
    | otherwise = False
isValidTime str = False

isValidTime' :: String -> String -> String -> Bool
isValidTime' h colon m = isValidHour h && colon == ":" && isValidMinute m

isValidHour :: String -> Bool
isValidHour a
    | isInt a = castedString >= 0
    | otherwise = False 
    where castedString = read a :: Int

isValidMinute :: String -> Bool
isValidMinute a
    | isInt a = castedString >= 0  && castedString <= 59 
    | otherwise = False 
    where castedString = read a :: Int

isInt :: String -> Bool
isInt = foldl (\acc c -> isNumber c) False

fromArgToTimeTuple :: [Char] -> (Int, Int)
fromArgToTimeTuple arg = (fromArgToHours arg, fromArgToMinutes arg)

fromArgToHours :: [Char] -> Int
fromArgToHours [x, _, _, _] = read [x]
fromArgToHours [x, y, _, __, _] = read [x, y]

fromArgToMinutes :: [Char] -> Int
fromArgToMinutes [_, _, _, m, m'] = read [m, m']
fromArgToMinutes [_, _, m, m'] = read [m, m']

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