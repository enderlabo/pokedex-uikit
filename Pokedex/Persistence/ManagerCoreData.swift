import UIKit
import CoreData

protocol CoreDataCrudProtocol {
  func savePokemonInPokedex(pokemon: Pokemon)
    func fetchPokemons() -> [PokemonCD]?
    func deletePokeminInPokedex(withId id: Int)
    func countPokemos() -> Int
}

final class CoreDataManager: CoreDataCrudProtocol {    
    
  static let shared = CoreDataManager()

  func savePokemonInPokedex(pokemon: Pokemon) {

    // interact with Core Data along their classes
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

    //1
        let managedContext = appDelegate.persistentContainer.viewContext

        //2
        let entity = NSEntityDescription.entity(forEntityName: "PokemonCD", in: managedContext)!

        //3
        let pokemonObject = NSManagedObject(entity: entity, insertInto: managedContext)
        pokemonObject.setValue(pokemon.id, forKeyPath: "id")
        pokemonObject.setValue(pokemon.sprites?.frontDefault, forKey: "image")
        pokemonObject.setValue(pokemon.name, forKey: "name")
        pokemonObject.setValue(pokemon.stats?.first?.baseStat, forKey: "stat")
        pokemonObject.setValue(pokemon.types?.first?.type?.name, forKey: "type")

        //4
        do {
          // this line do the magic
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }

      } // end func

    func fetchPokemons() -> [PokemonCD]? {
            
            //data for table view
            var items: [PokemonCD]?
            
            // Refering AppDelegate container
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return nil
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            do {
                
                items = try managedContext.fetch(PokemonCD.fetchRequest())
                if let items = items, !items.isEmpty {
                    print("Bring data from Core Data")
                    return items
                } else {
                    return nil
                }
                
            } catch {
                print("Error while fetching the pokemons")
                return nil
            }
        }
    
    func deletePokeminInPokedex(withId id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonCD")
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(id)")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            //The execute action
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    func countPokemos() -> Int{
        var items: [PokemonCD]?
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return 0
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        do{
            items = try managedContext.fetch(PokemonCD.fetchRequest())
            if let items = items, !items.isEmpty{
                print(" bring data from Core Data")
                return items.count
            }else{
                return 0
            }
        }
        catch{
            return 0
        }
    }
}
