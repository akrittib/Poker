data Suit = 
    Hearts 
    | Diamonds 
    | Spades 
    | Clubs deriving (Show, Eq, Enum)

data Rank =
    Two 
    | Three 
    | Four 
    | Five 
    | Six 
    | Seven 
    | Eight 
    | Nine 
    | Ten 
    | Jack 
    | Queen 
    | King 
    | Ace deriving (Show, Eq, Enum)

data Card = Card Rank Suit deriving (Show, Eq)

deck :: [Card] 
deck = [Card rank suit | rank <- [Two .. Ace], suit <- [Hearts .. Clubs]] 


