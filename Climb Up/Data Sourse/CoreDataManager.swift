//
//  AspirationsDataModel.swift
//  Climb Up
//
//  Created by Bohdan on 07.11.2020.
//

import Foundation
import Combine
import CoreData
import SwiftUI

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // MARK: - Main entity publisher
    var aspirationsEntityPublisher = PersistenceController.shared.container.viewContext.publisher(for: AspirationEntity.self)
    
    var climbsEntityPublisher = PersistenceController.shared.container.viewContext.publisher(for: ClimbEntity.self)
    
    // MARK: - Private consts
    private let _viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext

    // MARK: - Work with entities

    //MARK: Aspirations
    func addAspiration(id: UUID = UUID(), name: String, color: Color, date: Date) {

        let aspiration = AspirationEntity(context: _viewContext)
        aspiration.id = id
        aspiration.name =  name
        aspiration.colorHexStr = color.getHEXString()
        aspiration.date = date
        
        self.saveContext()
    }
    
    func removeAspiration(at id: UUID) {
        let fetchRequest : NSFetchRequest<AspirationEntity> = AspirationEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let aspirations = try _viewContext.fetch(fetchRequest)
            
            aspirations.forEach ({ index in
                
                // MARK: Remove climbs
                removeClimbs(byAspiration: index)
                
                self._viewContext.delete(index as NSManagedObject)
            })
            
            self.saveContext()
            
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    // MARK: Climbs
    func addClimbToAspiration(by id: UUID,
                              climbDate: Date,
                              climbQuality: Double,
                              climbTimeActive: Double,
                              climbTimeAll: Double,
                              climbTimeRest: Double,
                              climbTimeInterval: Double) {
        
        let fetchRequest : NSFetchRequest<AspirationEntity> = AspirationEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let aspirations = try _viewContext.fetch(fetchRequest)
            
            aspirations.forEach ({ aspiration in
                
                let newClimb = ClimbEntity(context: _viewContext)
                
                newClimb.id = UUID()
                newClimb.date = climbDate
                newClimb.quality = Int16(climbQuality)
                newClimb.timeActive = climbTimeActive
                newClimb.timeAll = climbTimeAll
                newClimb.timeRest = climbTimeRest
                newClimb.timeInterval = climbTimeInterval
                newClimb.aspiration = aspiration
                
                aspiration.addToClimb(newClimb)
            })
            
            self.saveContext()
            
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func removeClimb(by id: UUID) {
        let fetchRequest : NSFetchRequest<ClimbEntity> = ClimbEntity.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let climb = try _viewContext.fetch(fetchRequest)
            
            climb.forEach ({ index in
                self._viewContext.delete(index as NSManagedObject)
            })
            
            self.saveContext()
            
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    func removeClimbs(byAspiration aspiration: AspirationEntity) {
        let fetchRequest : NSFetchRequest<ClimbEntity> = ClimbEntity.fetchRequest()
        let predicate = NSPredicate(format: "aspiration == %@", aspiration as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let climb = try _viewContext.fetch(fetchRequest)
            
            climb.forEach ({ index in
                self._viewContext.delete(index as NSManagedObject)
            })
            
            self.saveContext()
            
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    //MARK: Save context
    private func saveContext() {
        
        if _viewContext.hasChanges {
          do {
            try _viewContext.save()
          } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
        }
    }
}
