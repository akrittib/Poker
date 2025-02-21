module Main where

import System.Random
import System.Random.Shuffle


data Suit = Hearts | Diamonds | Spades | Clubs deriving (Show, Eq, Enum, Ord)
data Rank = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace deriving (Show, Eq, Enum, Ord)

data Card = Card Rank Suit deriving (Show, Eq)

deck :: [Card] 
deck = [Card rank suit | rank <- [Two .. Ace], suit <- [Hearts .. Clubs]] 

shuffleDeck :: IO [Card]
shuffleDeck = shuffleM deck 

deal :: Int -> [Card] -> ([Card], [Card])
deal n deck = (take n deck, drop n deck)

data HandRank = 
    HighCard 
    | Pair 
    | TwoPair 
    | ThreeOfAKind 
    | Straight 
    | Flush 
    | FullHouse 
    | FourOfAKind 
    | StraightFlush 
    | RoyalFlush deriving (Show, Eq, Ord)

evaluateHand :: [Card] -> HandRank
evaluateHand cards = HighCard -- Placeholder for actual hand evaluation logic

data Action = 
     Fold 
    | Check 
    | Call 
    | Raise 
    | AllIn deriving (Show, Eq)

main :: IO ()
main = do 
    shuffledDeck <- shuffleDeck
    let (player1Hand, remainingDeck1) = deal 2 shuffledDeck
    let (player2Hand, remainingDeck2) = deal 2 remainingDeck1
    putStrLn "Player 1's Hand:"
    print player1Hand
    putStrLn "Player 2's Hand:"
    print player2Hand
    putStrLn "Player 1's Hand Rank:"
    print (evaluateHand player1Hand)
    putStrLn "Player 2's Hand Rank:"
    print (evaluateHand player2Hand)