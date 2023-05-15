import System.Random 

-- | The main function of the game.
playGame :: IO ()
playGame = do
  secret <- randomRIO (1, 90) -- Generate a random secret number between 1 and 90.
  playRound secret 1          -- Start playing the first round with a guess count of 1.

-- | Play one round of the game, given the secret number and the current guess count.
playRound :: Int -> Int -> IO ()
playRound secret 10 = do
    putStrLn $ "Secret number : (" ++ show secret ++ ") but max tries reached."
playRound secret guesses = do
  putStrLn $ "Guess #" ++ show guesses ++ ": Enter a number between 1 and 90:"
  guess <- readLn           -- Read the user's guess from the console.
  if guess == secret        -- If the guess is correct, print a success message and end the game.
    then do
      putStrLn $ "Congratulations! You guessed the secret number (" ++ show secret ++ ") in " ++ show guesses ++ " tries."
    else do                  -- If the guess is wrong, provide a hint and play another round.
      putStrLn $ "Sorry, that's not the secret number. The secret number is " ++ (if guess < secret then "greater" else "lower") ++ " than your guess."
      playRound secret (guesses + 1) -- Otherwise, play another round with an increased guess count.

