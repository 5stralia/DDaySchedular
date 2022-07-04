//
//  ListItemView.swift
//  DDay
//
//  Created by Hoju Choi on 2022/06/17.
//

import SwiftUI

struct ListItemView: View {
    @ObservedObject var viewModel: ListItemViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
            Spacer()
            HStack {
                Text(viewModel.date, formatter: itemDateFormatter)
                    .foregroundColor(.secondary)
                    .font(Font.system(size: 15))
                Spacer()
                Text("\(viewModel.dDay > 0 ? "+" : "")\(viewModel.dDay)")
                    .foregroundColor(dDayColor(viewModel.dDay))
            }
        }
    }

    init(title: String, date: Date, dDay: Int) {
        self.viewModel = ListItemViewModel(title: title, date: date, dDay: dDay)
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
        Group {
            ListItemView(title: "TEST", date: Date(), dDay: 100)
                .previewLayout(.fixed(width: 400, height: 50))
            ListItemView(title: "TEST", date: Date(), dDay: 0)
                .previewLayout(.fixed(width: 400, height: 50))
            ListItemView(title: "TEST", date: Date(), dDay: -100)
                .previewLayout(.fixed(width: 400, height: 50))
        }

    }
}
