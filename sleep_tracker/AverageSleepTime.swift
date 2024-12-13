//
//  AverageSleepTime.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 09.11.24.
//

import SwiftUI

struct AverageSleepTime: View {
    @State var time: String = ""
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Average Sleep Time")
                        .fontWeight(.bold)
                }
                .frame(maxHeight: .infinity)
                
                HStack {
                    Text(time)
                        .font(.title)
                    Text("Hours")
                        .font(.title)
                }
            }
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AverageSleepTime()
}
