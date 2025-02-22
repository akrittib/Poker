module Main where

import Random
import Random.Shuffle
import Data.List (sort, group, sortBy)

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
evaluateHand cards
    | isRoyalFlush cards    = RoyalFlush
    | isStraightFlush cards = StraightFlush
    | isFourOfAKind cards   = FourOfAKind
    | isFullHouse cards     = FullHouse
    | isFlush cards         = Flush
    | isStraight cards      = Straight
    | isThreeOfAKind cards  = ThreeOfAKind
    | isTwoPair cards       = TwoPair
    | isPair cards          = Pair
    | otherwise             = HighCard

isRoyalFlush :: [Card] -> Bool
isRoyalFlush cards = isStraightFlush cards && maximum ranks == Ace
  where ranks = map (\(Card rank _) -> rank) cards

isStraightFlush :: [Card] -> Bool
isStraightFlush cards = isFlush cards && isStraight cards

isFourOfAKind :: [Card] -> Bool
isFourOfAKind cards = any ((== 4) . length) (group ranks)
  where ranks = sort $ map (\(Card rank _) -> rank) cards

isFullHouse :: [Card] -> Bool
isFullHouse cards = any ((== 3) . length) (group ranks) && any ((== 2) . length) (group ranks)
  where ranks = sort $ map (\(Card rank _) -> rank) cards

isFlush :: [Card] -> Bool
isFlush cards = all (== head suits) suits
  where suits = map (\(Card _ suit) -> suit) cards

isStraight :: [Card] -> Bool
isStraight cards = and $ zipWith (\a b -> fromEnum b == fromEnum a + 1) sortedRanks (tail sortedRanks)
  where ranks = map (\(Card rank _) -> rank) cards
        sortedRanks = sort ranks

isThreeOfAKind :: [Card] -> Bool
isThreeOfAKind cards = any ((== 3) . length) (group ranks)
  where ranks = sort $ map (\(Card rank _) -> rank) cards

isTwoPair :: [Card] -> Bool
isTwoPair cards = length (filter ((== 2) . length) (group ranks)) == 2
  where ranks = sort $ map (\(Card rank _) -> rank) cards

isPair :: [Card] -> Bool
isPair cards = any ((== 2) . length) (group ranks)
  where ranks = sort $ map (\(Card rank _) -> rank) cards

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