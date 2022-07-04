//
//  ListView.swift
//  DDay
//
//  Created by Hoju Choi on 2022/06/17.
//

import CoreData
import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DDayItem.title, ascending: true)],
        animation: .default)
    var items: FetchedResults<DDayItem>

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
                    Label("Add DDayItem", systemImage: "plus")
                }
            }
        }
    }

    private func calculate(_ date: Date) -> Int {
        return -Int((Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)?.timeIntervalSinceNow ?? 0) / (60 * 60 * 24))
    }

    private func addItem() {
        withAnimation {
            let newItem = DDayItem(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = "New DDayItem"
            newItem.reminders = []

            viewContext.saveContext()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            viewContext.saveContext()
        }
    }

}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
