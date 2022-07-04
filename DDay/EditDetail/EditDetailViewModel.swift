//
//  EditDetailViewModel.swift
//  DDay
//
//  Created by Hoju Choi on 2022/06/30.
//

import CoreData
import Foundation
import SwiftUI

final class EditDetailViewModel: ObservableObject {
    @Environment(\.managedObjectContext) var viewContext

    @Published var title: String
    @Published var date: Date
    @Published var reminders: [Int]
    @Published var isPresentedReminderAlert: Bool = false
    @Published var editMode: EditMode = .inactive

    let item: DDayItem

    init(item: DDayItem) {
        self.item = item

        self.title = item.title ?? ""
        self.date = item.timestamp ?? Date()
        self.reminders = item.reminders ?? []
    }

    func toggleEditMode() {
        editMode = editMode == .active ? .inactive : .active
    }

    func addReminder(days: Int) {
        reminders = (reminders + [days]).sorted()
    }

    func removeReminder(indexSet: IndexSet) {
        indexSet.forEach { self.reminders.remove(at: $0) }
    }

    func submit() {
        item.title = title
        item.timestamp = date
        item.reminders = reminders

        viewContext.saveContext()
    }
}
