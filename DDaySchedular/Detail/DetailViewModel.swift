//
//  DetailViewModel.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/30.
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published var title: String
    @Published var date: Date
    @Published var reminders: [Int]

    let item: Item

    init(item: Item) {
        self.item = item

        self.title = item.title ?? ""
        self.date = item.timestamp ?? Date()
        self.reminders = item.reminders ?? []
    }
}
