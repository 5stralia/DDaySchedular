//
//  EditDetailView.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/18.
//

import SwiftUI

struct EditDetailView: View {
    @ObservedObject var viewModel: EditDetailViewModel

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                TextField("New Year", text: $viewModel.title)
                    .disableAutocorrection(true)
                Color.gray
                    .frame(height: 1)
                DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
            }
            .padding()
            ZStack(alignment: .top) {
                List {
                    ForEach(viewModel.reminders, id: \.self) { reminder in
                        HStack {
                            Text("\(reminder)")
                            Spacer()
                            Text(viewModel.date.calculate(addingDay: reminder)!, formatter: itemDateFormatter)
                        }
                    }
                    .onDelete(perform: viewModel.removeReminder(indexSet:))
                    if viewModel.editMode == .inactive {
                        Button("Add Reminder") {
                            withAnimation {
                                viewModel.isPresentedReminderAlert = true
                            }
                        }
                    }
                }
                .environment(\.editMode, $viewModel.editMode)
                HStack {
                    Spacer()
                    Button(viewModel.editMode == .active ? "Done" : "Edit") {
                        viewModel.toggleEditMode()
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 24))
            }
        }
        .toolbar {
            ToolbarItem {
                Button(action: viewModel.submit) {
                    Text("Done")
                }
            }
        }
        .modifier(Popup(isPresented: viewModel.isPresentedReminderAlert,
                        alignment: .center,
                        content: {
            TextInputAlertView { text in
                if let days = Int(text) {
                    viewModel.addReminder(days: days)
                }
                withAnimation {
                    viewModel.isPresentedReminderAlert = false
                }
            } cancel: {
                withAnimation {
                    viewModel.isPresentedReminderAlert = false
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
        self.viewModel = EditDetailViewModel(item: item)
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
