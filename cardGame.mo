import Nat32 "mo:base/Nat32";
import Trie "mo:base/Trie";
import Option "mo:base/Option";
import List "mo:base/List";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Random "mo:base/Random";

actor{

  public type Player = {
    name: Text;
    health: Nat32;
    mana: Nat32;
    cardList: List.List<Card>;
  };

  public type PlayerId = Nat32;
  private stable var next: PlayerId = 0;
  
  public type Card = {
    name: Text;
    mana: Nat32;
    damage: Nat32;
    heal: Nat32;
  };

  private stable var cards: List.List<Card> = List.nil<Card>();

  let card1 : Card = {
  name = "Fireball";
  mana = 4;
  damage = 3;
  heal = 0;
  };
  cards := List.push<Card>(card1, cards);

  let card2 : Card = {
    name = "Poison Cloud";
    mana = 3;
    damage = 1;
    heal = 0;
  };
  cards := List.push<Card>(card2, cards);

  let card3 : Card = {
  name = "Frost";
  mana = 2;
  damage = 2;
  heal = 0;
  };
  cards := List.push<Card>(card3, cards);

  let card4 : Card = {
  name = "Frost Walker";
  mana = 2;
  damage = 3;
  heal = 0;
  };
  cards := List.push<Card>(card4, cards);

  let card5 : Card = {
  name = "Divine Healer";
  mana = 1;
  damage = 0;
  heal = 2;
  };
  cards := List.push<Card>(card5, cards);

  let card6 : Card = {
  name = "Powder";
  mana = 1;
  damage = 1;
  heal = 0;
  };
  cards := List.push<Card>(card6, cards);
  
  public func getRandomCardFromDeck(cards: [Card]): async Card {   
    let random = Random.Finite(await Random.blob());
    let seed : Blob = "\0\1\2\3\4\5";
    let seedRandom = Random.Finite(seed);
    return cards[seedRandom]; // Kartı döndür
  };

  public func createPlayer(newplayer: Player) : async Player {
    let PlayerId = next;
    next += 1;
    let randCard = await getRandomCardFromDeck(cards);
    newplayer.cardList.push<Card>(0, randCard);

    randCard = await getRandomCardFromDeck(cards);
    newplayer.cardList.push<Card>(1, randCard);

    randCard = await getRandomCardFromDeck(cards);
    newplayer.cardList.push<Card>(2, randCard);

    return PlayerId;
  };

  public func play(currentPlayer: Player, otherPlayer: Player, playedCard: Card) : async Player {
    
  };

};
