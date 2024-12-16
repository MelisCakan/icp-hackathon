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
  private stable var players: List.List<Player> = List.nil<Player>();
  
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
  
  func getRandomCard(f : Random.Finite ) : ? Nat {
    let max = 6;
    do ? {
      var n = max - 1 : Nat;
      var k = 0;
      while (n != 0) {
        k *= 2;
        k += bit(f.coin()!);
        n /= 2;
      };
      if (k < max) k + 1 else getRandomCard(f, max)!;
    };
  };

  public func createPlayer(newplayer: Player) : async Player {
    let PlayerId = next;
    next += 1;
    players := List.push<Player>(newplayer, players);
    return PlayerId;
  };

  public func addCards(newcard: Card) {
    // Rastgele bir kaynak oluşturuyoruz
    let randomSource = Random.Finite.init([true, false, true, true, false, true]);

    for (player in List.toArray(players).vals()) {
        var count = 0;
        while (count != 4) {
            let cardIndex = getRandomCard(randomSource); // Rastgele bir kart seçiliyor
            switch (cardIndex) {
                case (?index) {
                    Debug.print("Player " # debug_show(player) # " got card: " # debug_show(index));
                    count += 1; // 4 karta ulaşmak için sayacı artır
                };
                case null {
                    Debug.print("Random source exhausted, skipping...");
                };
            };
        };
    };
};

  public func play(currentPlayer: Player, otherPlayer: Player, playedCard: Card) : async Player {
    currentPlayer.heal += playedCard.heal;
    otherPlayer.heal -= playedCard.damage;
    currentPlayer.mana -= playedCard.mana;
  };

  public func checkGameOver(firstPlayer: Player, secondPlayer: Player) {
    if (firstPlayer.heal <= 0) {
      Debug.print(debug_show ("Player 2 won!"));
    };
    if (secondPlayer.heal <= 0) {
      Debug.print(debug_show ("Player 1 won!"));
    };
    if (firstPlayer.heal, secondPlayer.heal <= 0) {
      Debug.print(debug_show ("Draw!"));
    };
    else {
      Debug.print(debug_show ("Game has not ended yet!"));
    };
  };
};
