//
//  ListItemViewModel.swift
//  DDay
//
//  Created by Hoju Choi on 2022/06/30.
//

import Foundation

final class ListItemViewModel: ObservableObject {
    @Published var title: String
    @Published var date: Date
    @Published var dDay: Int

    init(title: String, date: Date, dDay: Int) {
        self.title = title
        self.date = date
        self.dDay = dDay
    }
}
