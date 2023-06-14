//
//  MyExpenseTrackerWidget.swift
//  MyExpenseTrackerWidget
//
//  Created by Никита Савенко on 10.06.2023.
//

import SwiftUI
import WidgetKit

//let categories = ["Salary", "Gifts", "Deposit", "Crypto", "Other"]
//let incomes = [2000, 500, 1000, 300, 700]
//
//let colors: [Color] = [
//            Color(red: 251/255, green: 128/255, blue: 114/255),
//            Color(red: 128/255, green: 177/255, blue: 211/255),
//            Color(red: 141/255, green: 211/255, blue: 199/255),
//            Color(red: 255/255, green: 237/255, blue: 111/255),
//            Color(red: 190/255, green: 186/255, blue: 218/255),
//            Color(red: 253/255, green: 180/255, blue: 98/255),
//            Color(red: 179/255, green: 222/255, blue: 105/255)
//            ]
//
//struct BarChartView: View {
//    let categories: [String]
//    let incomes: [Int]
//
//    var body: some View {
//        VStack {
//            Text("Balance")
//                .font(.system(size: 12))
//                .foregroundColor(.white)
//                .padding(.top, 0)
//                .padding(.trailing, 210)
//            Text("2567 3245 7689 3345")
//                .font(.system(size: 12))
//                .foregroundColor(.white)
//                .padding(.top, 0)
//                .padding(.leading, 20)
//
//
//
//            HStack(spacing: 30) {
//                ForEach(0..<categories.count, id: \.self) { index in
//                    VStack {
//                        Spacer()
//                        Rectangle()
//                            .fill(colors[index % colors.count])
//                            .frame(width: 20, height: CGFloat(incomes[index]) / CGFloat(incomes.max()!) * 50)
//                    }
//                }
//            }
//            .padding(.trailing, 40)
//
//            HStack(spacing: 0) {
//                ForEach(0..<categories.count, id: \.self) { index in
//                    Text(categories[index])
//                        .foregroundColor(Color.white)
//                        .font(.system(size: 9))
//                        .lineLimit(1)
//                        .minimumScaleFactor(0.5)
//                        .frame(width: 50)
//                }
//            }
//            .padding(.trailing, 40)
//        }
//        .padding(.trailing, 50)
//    }
//}
//
//
//struct MyExpenseTrackerWidget: Widget {
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: "MyExpenseTrackerWidget", provider: Provider()) { entry in
//            BarChartView(categories: categories, incomes: incomes)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .padding()
//                .background(Color.black)
//        }
//        .supportedFamilies([.systemMedium])
//        .configurationDisplayName("Expense Tracker")
//        .description("Track your expenses with this widget.")
//    }
//}
//
//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> BarChartEntry {
//        BarChartEntry(date: Date(), categories: categories, incomes: incomes)
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (BarChartEntry) -> ()) {
//        let entry = BarChartEntry(date: Date(), categories: categories, incomes: incomes)
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<BarChartEntry>) -> ()) {
//        let entry = BarChartEntry(date: Date(), categories: categories, incomes: incomes)
//        let timeline = Timeline(entries: [entry], policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct BarChartEntry: TimelineEntry {
//    let date: Date
//    let categories: [String]
//    let incomes: [Int]
//}
//
//
//struct MyExpenseTrackerWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        BarChartView(categories: categories, incomes: incomes)
//            .previewLayout(.fixed(width: 320, height: 180))
//            .padding()
//            .background(Color.black)
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//    }
//}

 
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let historyCount = (try? getData().count) ?? 0
        
        return SimpleEntry(date: Date(), historyCount: historyCount)
    }
    

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        do {
            
            let histories = try getData()
            let entry = SimpleEntry(date: Date(), historyCount: histories.count)
            completion(entry)
        } catch {
            print(error)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        do {
            let histories = try getData()
            let entry = SimpleEntry(date: Date(), historyCount: histories.count)
            
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        } catch {
            print(error)
        }
    }
    
    private func getData() throws -> [HistoryEntity] {
        let context = PersistenceController.shared.container.viewContext
        let request = HistoryEntity.fetchRequest()
        let result = try context.fetch(request)
        
        return result
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let historyCount: Int
}

struct MyExpenseTrackerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.historyCount, format: .number)
    }
}

struct MyExpenseTrackerWidget: Widget {
    let kind: String = "MyExpenseTrackerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyExpenseTrackerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
 

