//
//  Date+calculate.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/18.
//

import Foundation

extension Date {
    func calculate(to: Date) -> Int {
        return Int(self.timeIntervalSince(to) / (60 * 60 * 24))
    }

    func calculate(addingDay: Int) -> Date? {
        return Calendar.current.date(byAdding: DateComponents(day: addingDay), to: self)
    }
}
