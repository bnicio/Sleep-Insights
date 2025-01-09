//
//  BoxHFRQView.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 08.01.25.
//

import SwiftUI
import Charts

struct BoxHFRQView: View {
    var body: some View {
        
        GroupBox {
            VStack {
                HStack {
                    Text("Herzfrequenz")
//                        .font(.system(size: 14))
                        .bold()
                    Spacer()
                    
                    Image(systemName: "chevron.right").bold().foregroundStyle(.purple)
                }
                .frame(maxWidth: .infinity)
                Divider()
                
                Spacer()

                HStack{
                    Text("Heute")
                    Text("49 - 64")
                        .foregroundStyle(.red)
                        .font(.system(size: 20))
                        .bold()
                    Spacer()
                }
                
                Chart {
                    BarMark(x: .value("Time", 1), yStart: .value("Test", 51), yEnd: .value("Test", 56))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    BarMark(x: .value("Time", 2), yStart: .value("Test", 50), yEnd: .value("Test", 60))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    BarMark(x: .value("Time", 3), yStart: .value("Test", 51), yEnd: .value("Test", 62))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    BarMark(x: .value("Time", 4), yStart: .value("Test", 49), yEnd: .value("Test", 57))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    BarMark(x: .value("Time", 5), yStart: .value("Test", 52), yEnd: .value("Test", 61))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    BarMark(x: .value("Time", 6), yStart: .value("Test", 54), yEnd: .value("Test", 61))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    BarMark(x: .value("Time", 7), yStart: .value("Test", 49), yEnd: .value("Test", 58))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    BarMark(x: .value("Time", 8), yStart: .value("Test", 51), yEnd: .value("Test", 61))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    BarMark(x: .value("Time", 9), yStart: .value("Test", 54), yEnd: .value("Test", 61))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    BarMark(x: .value("Time", 10), yStart: .value("Test", 55), yEnd: .value("Test", 64))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    RuleMark(xStart: .value("", 0),
                             xEnd: .value("", 11),
                             y: .value("Test2", 55))
                    .annotation(position: .trailing) {
                        Text("63").bold()
                    }
                    .foregroundStyle(.white)
                    
//                    RuleMark(xStart: .value("", 9),
//                             xEnd: .value("", 11),
//                             y: .value("Test2", 64.5))
//                    .annotation(position: .top) {
//                        Text("64")
//                            .bold()
//                            .font(.system(size: 14))
//                            .offset(x: 0, y: 2)
//                    }
//                    
//                    RuleMark(xStart: .value("", 3),
//                             xEnd: .value("", 5),
//                             y: .value("Test2", 48.5))
//                    .annotation(position: .bottom) {
//                        Text("49").font(.system(size: 14)).bold().offset(x: 0, y: -2)
//                    }
                }
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .chartYScale(domain: 49...64)
//                .frame(maxHeight: 100)
                .foregroundStyle(.red)
                
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    BoxHFRQView()
        .backgroundStyle(Color(.systemGray5))
        .frame(width: 200, height: 200)
        .cornerRadius(20)
}
