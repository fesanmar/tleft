import System.Environment
    
main :: IO ()
main = do
    args <- getArgs 
    putStrLn (timeLeftFromArgs (head args) (args !! 1))

someFunc :: IO ()
someFunc = putStrLn "someFunc"

timeLeftFromArgs :: [Char] -> [Char] -> [Char]
timeLeftFromArgs arg1 arg2 = timeLeftMessage (fromArgToTimeTuple arg1) (fromArgToTimeTuple arg2)

fromArgToTimeTuple :: [Char] -> (Int, Int)
fromArgToTimeTuple arg = (fromArgToHours arg, fromArgToMinutes arg)

fromArgToHours :: [Char] -> Int
fromArgToHours arg = read (take 2 arg)

fromArgToMinutes :: [Char] -> Int
fromArgToMinutes arg = read (take 2 (drop 3 arg))

timeLeftMessage :: (Int, Int) -> (Int, Int) -> [Char]
timeLeftMessage time1 time2 = composeTimeLeftString (timeLeft time1 time2)

composeTimeLeftString :: (Int, Int) -> [Char]
composeTimeLeftString time = "Time left: " ++ show (fst time) ++ ":" ++ show (snd time) ++ " hours"

timeLeft :: (Int, Int) -> (Int, Int) -> (Int, Int)
timeLeft time1 time2 = (hours, subMinutes (snd time1) (snd time2)) where 
    hours = if snd time1 > snd time2 then fst time1 - fst time2 else fst time1 - fst time2 - 1

subMinutes :: Int -> Int -> Int 
subMinutes m1 m2 = if m1 > m2 then m1 - m2 else m1 - m2 + 60

hoursLeft :: Int -> Int -> Int 
hoursLeft bigerHour smallerHour = bigerHour - smallerHour
