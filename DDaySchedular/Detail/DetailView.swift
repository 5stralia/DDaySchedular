//
//  DetailView.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/17.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @State private var title: String = ""
//    @State private var timestamp: Date = Date()
//    @State private var reminders: [Int] = []

//    let item: Item

    @ObservedObject var item: Item

//    var body: some View {
//        VStack {
//            Text(title)
//            Text(timestamp, formatter: timeFormatter)
//            List {
//                ForEach(reminders, id: \.self) { reminder in
//                    if let toDate = timestamp.calculate(addingDay: reminder) {
//                        HStack {
//                            Text("\(reminder)일")
//                            Spacer()
//                            Text("\(toDate, formatter: timeFormatter)")
//                        }
//                    }
//                }
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                NavigationLink {
//                    EditDetailView(item: item)
//                } label: {
//                    Text("Edit")
//                }
//            }
//        }
////        .onAppear(perform: refresh)
//    }

    var body: some View {
        VStack {
            Text(item.title!)
            Text(item.timestamp!, formatter: timeFormatter)
            List {
                ForEach(item.reminders!, id: \.self) { reminder in
                    if let toDate = item.timestamp!.calculate(addingDay: reminder) {
                        HStack {
                            Text("\(reminder)일")
                            Spacer()
                            Text("\(toDate, formatter: timeFormatter)")
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    EditDetailView(item: item)
                } label: {
                    Text("Edit")
                }
            }
        }
//        .onAppear(perform: refresh)
    }

//    init(item: Item) {
//        self.item = item
//        _title = State(initialValue: item.title!)
//        _timestamp = State(initialValue: item.timestamp!)
//        _reminders = State(initialValue: item.reminders!)
//    }
//
//    private func refresh() {
//        title = item.title!
//        timestamp = item.timestamp!
//        reminders = item.reminders!
//    }

}

private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY MMM d EEE"

    return formatter
}()

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        do {
            let items = try PersistenceController.preview.container.viewContext.fetch(Item.fetchRequest()) as! [Item]
            return DetailView(item: items[0])
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
