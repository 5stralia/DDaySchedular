//
//  EditDetailView.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/18.
//

import SwiftUI

struct EditDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var reminders: [Int] = []
    @State private var isPresentedReminderAlert: Bool = false
    @State private var editMode: EditMode = .inactive

    let item: Item

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                TextField("New Year", text: $title)
                    .disableAutocorrection(true)
                Color.gray
                    .frame(height: 1)
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            .padding()
            ZStack(alignment: .top) {
                List {
                    ForEach(reminders, id: \.self) { reminder in
                        HStack {
                            Text("\(reminder)")
                            Spacer()
                            Text(item.timestamp!.calculate(addingDay: reminder)!, formatter: itemDateFormatter)
                        }
                    }
                    .onDelete(perform: removeReminder(indexSet:))
                    if editMode == .inactive {
                        Button("Add Reminder") {
                            withAnimation {
                                isPresentedReminderAlert = true
                            }
                        }
                    }
                }
                .environment(\.editMode, $editMode)
                HStack {
                    Spacer()
                    Button(editMode == .active ? "Done" : "Edit") {
                        editMode = editMode == .active ? .inactive : .active
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 24))
            }
        }
        .toolbar {
            ToolbarItem {
                Button(action: submit) {
                    Text("Done")
                }
            }
        }
        .modifier(Popup(isPresented: isPresentedReminderAlert,
                        alignment: .center,
                        content: {
            TextInputAlertView { text in
                if let days = Int(text) {
                    addReminder(days: days)
                }
                withAnimation {
                    isPresentedReminderAlert = false
                }
            } cancel: {
                withAnimation {
                    isPresentedReminderAlert = false
                }
            }
            .frame(width: 300, height: 200)
            .background(Color(uiColor: .systemBackground))
            .cornerRadius(5)
            .shadow(radius: 5)
        }
                       ))
    }

    init(item: Item) {
        self.item = item
        _title = State(initialValue: item.title!)
        _date = State(initialValue: item.timestamp!)
        _reminders = State(initialValue: item.reminders!)
    }

    private func addReminder(days: Int) {
        self.reminders = (reminders + [days]).sorted()
    }

    private func removeReminder(indexSet: IndexSet) {
        indexSet.forEach { index in
            self.reminders.remove(at: index)
        }
    }

    private func submit() {
        item.title = title
        item.timestamp = date
        item.reminders = reminders

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}

struct EditDetailView_Previews: PreviewProvider {
    static var previews: some View {
        do {
            let items = try PersistenceController.preview.container.viewContext.fetch(Item.fetchRequest()) as! [Item]
            return EditDetailView(item: items[0])
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
