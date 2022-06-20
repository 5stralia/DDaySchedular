//
//  ListView.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/17.
//

import CoreData
import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.title, ascending: true)],
        animation: .default)
    var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items, id: \.id) { item in
                NavigationLink {
                    DetailView(item: item)
                } label: {
                    VStack {
                        ListItemView(title: item.title!, date: item.timestamp!, dDay: calculate(item.timestamp!))
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }

    private func calculate(_ date: Date) -> Int {
        return -Int((Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)?.timeIntervalSinceNow ?? 0) / (60 * 60 * 24))
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = "New Item"
            newItem.reminders = []

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
