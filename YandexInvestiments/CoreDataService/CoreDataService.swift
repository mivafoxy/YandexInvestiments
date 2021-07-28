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
    public static func loadDataFromDb() -> [TicketEntity] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Ticket")
        
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
}
