cabal install Random
import System.Random
import System.Random.Shuffle

data Suit = Hearts | Diamonds | Spades | Clubs deriving (Show, Eq, Enum, Ord)
data Rank = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace deriving (Show, Eq, Enum, Ord)

data Card = Card Rank Suit deriving (Show, Eq)

deck :: [Card] 
deck = [Card rank suit | rank <- [Two .. Ace], suit <- [Hearts .. Clubs]] 

shuffleDeck :: IO [Card]
shuffleDeck = shuffleM deck 

deal :: [Card] -> ([Card], [Card])
deal n deal = (take n deal, drop n deal)

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
evaluateHand cards = --Implement logic for ranking hands

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



 