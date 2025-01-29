//
//  CoreDataManager.swift
//  ExchangeCurrencyApp
//
//  Created by Nikita on 29.01.2025.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CurrencyData")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
    
    func fetchRates() -> [CurrencyRate] {
        let request: NSFetchRequest<CurrencyRateEntity> = CurrencyRateEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isFavorite == true")
        
        do {
            let entities = try persistentContainer.viewContext.fetch(request)
            return entities.map { CurrencyRate(baseCurrency: $0.baseCurrency ?? "", quoteCurrency: $0.quoteCurrency ?? "", quote: $0.quote, date: $0.date ?? "") }
        } catch {
            print("Failed to fetch favorite rates: \(error)")
            return []
        }
    }
        
    func saveFavoriteRate(_ rate: CurrencyRate) {
        let context = persistentContainer.viewContext
        let entity = CurrencyRateEntity(context: context)
        entity.quoteCurrency = rate.quoteCurrency
        entity.baseCurrency = rate.baseCurrency
        entity.quote = rate.quote
        entity.date = rate.date
        entity.isFavorite = true
        saveContext()
    }
    
    func removeFavoriteRate(_ rate: CurrencyRate) {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<CurrencyRateEntity> = CurrencyRateEntity.fetchRequest()
        request.predicate = NSPredicate(format: "baseCurrency == %@ AND quoteCurrency == %@", rate.baseCurrency, rate.quoteCurrency)
        
        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            saveContext()
        } catch {
            print("Failed to delete favorite rate: \(error)")
        }
    }
}
