//
//  TextInputAlertView.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/18.
//

import SwiftUI

struct TextInputAlertView: View {
    private var submit: (_ text: String) -> Void
    private var cancel: () -> Void

    @State private var text: String = ""

    var body: some View {
        VStack {
            Text("Add Reminder")
            TextField("100", text: $text)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .padding()
            HStack {
                Spacer()
                Button("Cancel") {
                    cancel()
                }
                Spacer()
                Button("OK") {
                    submit(text)
                }
                Spacer()
            }
        }
    }

    init(submit: @escaping (_ text: String) -> Void, cancel: @escaping () -> Void) {
        self.submit = submit
        self.cancel = cancel
    }
}

struct TextInputAlertView_Previews: PreviewProvider {
    @State var text: String = ""
    static var previews: some View {
        TextInputAlertView(submit: { _ in }, cancel: { })
    }
}
