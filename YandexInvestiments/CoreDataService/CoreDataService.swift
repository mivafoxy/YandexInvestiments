//
//  CoreDataService.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 28.07.2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {
    private static let entityName = "Ticket"
    
    public static func loadDataFromDb() -> [TicketEntity] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        var entities = [NSManagedObject]()
        
        do {
            entities = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        var tickets = [TicketEntity]()
        for entity in entities {
            guard let name = entity.value(forKey: "name") as? String else {
                continue
            }
            
            tickets.append(TicketEntity(name: name))
        }
        
        return tickets
    }
    
    public static func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
            return
        }
        let ticket = NSManagedObject(entity: entity, insertInto: managedContext)
        ticket.setValue(name, forKeyPath: "name")
        
        appDelegate.saveContext()
    }
    
    public static func delete(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            guard let results = try managedContext.execute(request) as? [NSManagedObject] else {
                return
            }
            for object in results {
                managedContext.delete(object)
            }
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
