//
//  HypnoGramView.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 08.01.25.
//

import SwiftUI
import Charts

struct HypnoGramView: View {
    var body: some View {
        GroupBox {
            VStack {
                HStack {
                    Text("Hypnogram")
                        .bold()

                    Spacer()
                    
                    Image(systemName: "chevron.right").bold().foregroundStyle(.purple)
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                
                Spacer()

                Chart {
                    BarMark(xStart: .value("Time", 0),
                            xEnd: .value("Time", 2),
                            y: .value("Test", "Awake"))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    BarMark(xStart: .value("Time", 2),
                            xEnd: .value("Time", 6),
                            y: .value("Test", "Asleep"))
                        .clipShape(RoundedRectangle(cornerRadius: 4))

                }
//                .chartXAxis(.hidden)
//                .chartYAxis(.hidden)
//                .chartYScale(domain: ["Awake", "Asleep"])
//                .frame(maxWidth: 135)
//                .foregroundStyle(Color(.cyan))
//                .mask {
//                    LinearGradient(
//                        colors: [.green, .yellow],
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                }
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    HypnoGramView()
        .backgroundStyle(Color(.systemGray5))
        .frame(width: 400, height: 400)
        .cornerRadius(20)
}
