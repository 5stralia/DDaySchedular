//
//  ComplicationViews.swift
//  DDaySchedular
//
//  Created by Hoju Choi on 2022/06/18.
//

import ClockKit
import SwiftUI

struct ComplicationViews: View {
    var body: some View {
        ZStack {
            ProgressView(
                "30011",
                value: 0.4,
                total: 1
            )
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
        }
    }
}

struct ComplicationViews_Previews: PreviewProvider {
    static var previews: some View {
        ComplicationViews()
    }
}
