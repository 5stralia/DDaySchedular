//
//  ListViewModel.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/30.
//

import CoreData
import Foundation
import SwiftUI

final class ListViewModel: ObservableObject {
    @Environment(\.managedObjectContext) var viewContext

    @Published var items: [Item] = []

    func fetchItems() {
        items = viewContext.fetchItems()
    }

    func addItem() {
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
        newItem.title = "New Item"
        newItem.reminders = []

        viewContext.saveContext()
    }

    func deleteItems(offsets: IndexSet) {
        offsets.map { items[$0] }.forEach(viewContext.delete)

        viewContext.saveContext()
    }
}
