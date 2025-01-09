//
//  BigBoxView.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 08.01.25.
//

import SwiftUI
import Charts

struct BigBoxView: View {
    @State private var selectedAmount: Double?

    var data: [ChartDataEntry] = [
        ChartDataEntry(count: 32, type: "Awake", color: Color(.red)),
        ChartDataEntry(count: 33, type: "REM", color: Color(.cyan)),
        ChartDataEntry(count: 200, type: "Core", color: Color(.blue)),
        ChartDataEntry(count: 90, type: "Deep", color: Color(.purple))
    ]
    
    let cumulativeIncomes: [(category: String, range: Range<Double>)]
    
    init() {
        var cumulative = 0.0
        self.cumulativeIncomes = data.map {
            let newCumulative = cumulative + Double($0.count)
            let result = (category: $0.type, range: cumulative ..< newCumulative)
            cumulative = newCumulative
            return result
        }
    }
    
    var selectedCategory: ChartDataEntry? {
        if let selectedAmount,
           let selectedIndex = cumulativeIncomes
            .firstIndex(where: { $0.range.contains(selectedAmount) }) {
            return data[selectedIndex]
        }
        return nil
    }
    
    var body: some View {

        
        HStack {
            ZStack {
                Chart(data) { data in
                    SectorMark(
                        angle: .value("Count", data.count),
                        innerRadius: .ratio(0.7),
                        angularInset: 8
                    )
                    .foregroundStyle(data.color)
                    .cornerRadius(4)
                }
                .padding()

                // Select a sector
                .chartAngleSelection(value: $selectedAmount)

                // Display data for selected sector
                .chartBackground { chartProxy in
                    GeometryReader { geometry in
                        let frame = geometry[chartProxy.plotFrame!]
                        VStack(spacing: 0) {
                            Text(selectedCategory?.category ?? "")
                                .multilineTextAlignment(.center)
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .frame(width: 120, height: 80)
                            Text("€\(selectedCategory?.amount ?? 0, specifier: "%.1f") M")
                                .font(.title.bold())
                                .foregroundColor((selectedCategory != nil) ? .primary : .clear)
                        }
                        .position(x: frame.midX, y: frame.midY)
                    }
                }

                
                Text("86")
                    .bold()
                    .font(.system(size: 34))
            }
            .frame(width: 200)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Dauer: 8:12 h")
                Text("Tiefe: 1:43 h")
                Text("Leicht: 5:32 h")
                Text("REM: 0:32 h")
                Text("Wach: 0:32 h")
                Text("Unruhige Momente: 12")
                
                // Testing chartAngleSelection

                Text("SelectedAmount")

                Text(selectedSection?.formatted() ?? "none")
            }
            
            Spacer()
        }
    }
}

struct ChartDataEntry: Identifiable {
    var id: UUID = UUID()
    var count: Double
    var type: String
    var color: Color
}

#Preview {
    BigBoxView()
}
