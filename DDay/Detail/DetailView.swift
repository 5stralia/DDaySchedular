//
//  DetailView.swift
//  DDay
//
//  Created by Hoju Choi on 2022/06/17.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        VStack {
            Text(viewModel.title)
            Text(viewModel.date, formatter: timeFormatter)
            List {
                ForEach(viewModel.reminders, id: \.self) { reminder in
                    if let toDate = viewModel.date.calculate(addingDay: reminder) {
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
                    EditDetailView(item: viewModel.item)
                } label: {
                    Text("Edit")
                }
            }
        }
    }

    init(item: DDayItem) {
        self.viewModel = DetailViewModel(item: item)
    }
}

private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY MMM d EEE"

    return formatter
}()

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        do {
            let items = try PersistenceController.preview.container.viewContext.fetch(DDayItem.fetchRequest()) as! [DDayItem]
            return DetailView(item: items[0])
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
