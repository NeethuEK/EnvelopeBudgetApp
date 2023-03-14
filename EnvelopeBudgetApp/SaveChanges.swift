//
//  SaveChanges.swift
//  EnvelopeBudgetApp
//
//  Created by Neethu Kuruvilla on 1/27/23.
//

import Foundation
import CoreData

extension NSManagedObjectContext{
    func saveIfChanged() -> NSError?{
        guard hasChanges else{
            return nil
        }
        do{
            try save()
            return nil
        } catch {
            return error as NSError
        }
        
    }
}
