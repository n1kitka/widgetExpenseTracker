//
//  HistoryModel.swift
//  MyExpenseTrackerApp
//
//  Created by Никита Савенко on 12.05.2023.
//

import Foundation
import UIKit
import CoreData

var historiesArray = [HistoryEntity]()

let context = PersistenceController.shared.persistentContainer.viewContext
let defaults = UserDefaults.standard


struct HistoryModel {

    
    var totalIncomes = 0.0
    var totalExpenses = 0.0
    var currentTotal = 0.0
    
    func getRowInSection() -> Int {
        historiesArray.count
    }
    
    func getHeightConstant() -> Double {
        
        if historiesArray.count == 0 {
            return 0
        } else {
            let heightConstant = (Double(historiesArray.count) * 90) + 40
            return heightConstant
        }
    }
    
    func getNewHistory(_ newHistory: History) {
        let newHistories = HistoryEntity(context: context)
        newHistories.title = newHistory.title
        newHistories.date = newHistory.date
        newHistories.cost = newHistory.cost
        
        let imageData = newHistory.image.pngData()
        newHistories.image = imageData
        
        saveCategories()
        
        historiesArray.insert(newHistories, at: 0)
   
    }
    
    func getHistory(_ indexpath:Int) -> HistoryEntity{
        return historiesArray[indexpath]
    }
    
    mutating func getTotalIncomes(_ incomes:Double) -> Double {
         totalIncomes += incomes
         return totalIncomes
    }
    
    mutating func getTotalExpenses(_ expenses:Double) -> Double {
        totalExpenses += expenses
        return totalExpenses
    }
    
    
    mutating func getTotalCurrent (_ segment:Int , _ total:Double) -> Double {
        if segment == 0 {
            currentTotal += total
            return currentTotal
        } else {
            currentTotal -= total
            return currentTotal
        }
    }
    
    func deleteHistory(at indexPath: IndexPath) {
        let history = historiesArray[indexPath.row]
        context.delete(history)
        saveCategories()
        historiesArray.remove(at: indexPath.row)
        
    }

    func saveCategories() {
        do {
            try context.save()
        } catch {
            print(error)
        }

    }
    
    func loadCategories() {
        let request : NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
        do {
            historiesArray =  try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
}

    
