//
//  BarChartManager.swift
//  MyExpenseTrackerApp
//
//  Created by Никита Савенко on 14.05.2023.
//

import Foundation
import UIKit
import Charts

class BarChartManager {
    
    let incomesModel = Incomes()
    
    func configureBarChart(_ barChartView: BarChartView) {
        barChartView.noDataText = "No data available"
        barChartView.legend.enabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false
    }
    
    func updateBarChartData(_ barChartView: BarChartView) {
        let categories = ["Зарплатня", "Подарунки", "Депозит", "Крипто", "Інший дохід"]
        var dataEntries: [BarChartDataEntry] = []
        var hasData = false // Track if any data is available
        
        for (index, category) in categories.enumerated() {
            let categoryTotal = calculateCategoryTotal(category)
            let dataEntry = BarChartDataEntry(x: Double(index), y: categoryTotal)
            dataEntries.append(dataEntry)
            
            if categoryTotal > 0 {
                hasData = true
            }
        }
        
        let dataSet = BarChartDataSet(entries: dataEntries, label: "")
        dataSet.colors = ChartColorTemplates.joyful()
        
        let data = BarChartData(dataSet: dataSet)
        data.setDrawValues(false)
        
        barChartView.data = data
        
        // Show or hide captions based on data availability
        if hasData {
            barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: categories)
            barChartView.xAxis.labelPosition = .bottom
            barChartView.xAxis.granularity = 1.0
            barChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 14.0)
            barChartView.xAxis.labelTextColor = .white
            barChartView.xAxis.drawLabelsEnabled = true
            barChartView.extraBottomOffset = 10.0
        } else {
            barChartView.xAxis.drawLabelsEnabled = false
        }
    }

    
    private func calculateCategoryTotal(_ category: String) -> Double {
            var total = 0.0
            
            for history in historiesArray {
                if let title = history.title, let cost = Double(history.cost ?? "") {
                    if incomesModel.incomes.contains(where: { $0.title == title }) && title == category {
                        total += cost
                    }
                }
            }
            
            return total
        }
}
