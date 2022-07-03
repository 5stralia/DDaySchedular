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
    @ObservedObject var viewModel = ListViewModel()

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
            viewModel.addItem()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewModel.deleteItems(offsets: offsets)
        }
    }

}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
