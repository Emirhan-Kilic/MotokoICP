import List "mo:base/List";
import Option "mo:base/Option";
import Map "mo:base/OrderedMap";
import Nat32 "mo:base/Nat32";
import Trie "mo:base/Trie";
import Text "mo:base/Text";
import Result "mo:base/Result";


actor {

  public type SuperHeroID = Nat32;

  public type SuperHero = {
    name: Text;
    powers: List.List<Text>;

  };

  private stable var next: SuperHeroID = 0;
  private stable var superheros : Trie.Trie<SuperHeroID, SuperHero> = Trie.empty();


  public func create(newHero: SuperHero): async SuperHeroID{
    let SuperHeroID = next;
    next += 1;

    superheros := Trie.replace(
      superheros,
      key(SuperHeroID),
      Nat32.equal,
      ?newHero
    ).0;
    SuperHeroID
  };

  public func getHero(id: SuperHeroID): async ?SuperHero {
      let result = Trie.find(
        superheros,
        key(id),
        Nat32.equal,        
      );
    
    return result

  };

  public func update(id: SuperHeroID, updateValue: SuperHero) : async Bool{
      let result = Trie.find(
        superheros,
        key(id),
        Nat32.equal,        
      );

      let exists = Option.isSome(result);

      if (exists){
        superheros := Trie.replace(
          superheros,
          key(id),
          Nat32.equal, 
          ?updateValue
        ).0;
      };

      false 
  };

  private func key(x: SuperHeroID): Trie.Key<SuperHeroID>{
    {hash = x; key = x; }

  };


}
