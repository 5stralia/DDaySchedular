//
//  ListItemView.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/17.
//

import SwiftUI

struct ListItemView: View {
    @State private var title: String
    @State private var date: Date
    @State private var dDay: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            Spacer()
            HStack {
                Text(date, formatter: itemDateFormatter)
                    .foregroundColor(.secondary)
                    .font(Font.system(size: 15))
                Spacer()
                Text("\(dDay > 0 ? "+" : "")\(dDay)")
                    .foregroundColor(dDayColor(dDay))
            }
        }
    }

    init(title: String, date: Date, dDay: Int) {
        _title = State(initialValue: title)
        _date = State(initialValue: date)
        _dDay = State(initialValue: dDay)
    }

    private func dDayColor(_ days: Int) -> Color {
        if days > 0 {
            return .blue
        } else if days == 0 {
            return .black
        } else {
            return .red
        }
    }
}

public let itemDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 M월 dd일"
    return formatter
}()

struct DDayListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(title: "TEST", date: Date(), dDay: 100)
    }
}
