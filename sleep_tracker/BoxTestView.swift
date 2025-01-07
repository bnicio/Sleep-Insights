//
//  BoxTestView.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 16.12.24.
//

import SwiftUI

struct BoxTestView: View {
    @State private var boxes = [
        Box(color: Color(.systemGray5), title: "Box 1"),
        Box(color: Color(.systemGray5), title: "Box 2"),
        Box(color: Color(.systemGray5), title: "Box 3"),
        Box(color: Color(.systemGray5), title: "Box 4")
    ]
    
    @State private var draggedBox: Box? // Temporär gehaltene Box für Drag
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(boxes) { box in
                    GroupBox {
                        VStack {
                            HStack {
                                Text(box.title)
                                Text("Lorem Ipsum")
                            }
                            .frame(maxWidth: .infinity)
                            Spacer()
                            Text(box.title)
                            Spacer()
                        }
                        .frame(maxHeight: .infinity)
                    }
                    .backgroundStyle(box.color)
                    .frame(height: 180)
                    .cornerRadius(20)
                    .onDrag {
                        // Setzt die aktuell gezogene Box
                        self.draggedBox = box
                        return NSItemProvider(object: box.id.uuidString as NSString)
                    }
                    .onDrop(of: [.plainText], delegate: DropViewDelegate(currentBox: box, boxes: $boxes, draggedBox: $draggedBox))
                }
            }
            .navigationTitle("Drag & Drop Grid")
            .padding()
        }
    }
}

// MARK: - DropViewDelegate
struct DropViewDelegate: DropDelegate {
    let currentBox: Box
    @Binding var boxes: [Box]
    @Binding var draggedBox: Box?

    func performDrop(info: DropInfo) -> Bool {
        // Setzt die gezogene Box auf nil
        self.draggedBox = nil
        return true
    }
    
    func dropEntered(info: DropInfo) {
        // Überprüfen, ob eine Box gezogen wird und die Indizes ermitteln
        guard let draggedBox = draggedBox,
              let fromIndex = boxes.firstIndex(where: { $0.id == draggedBox.id }),
              let toIndex = boxes.firstIndex(where: { $0.id == currentBox.id }),
              fromIndex != toIndex else {
            return
        }
        
        // Die Reihenfolge der Boxen im Array anpassen
        withAnimation {
            boxes.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
        }
    }
}

// MARK: - Box Model
struct Box: Identifiable {
    let id = UUID()
    var color: Color
    var title: String
    var subTitle: String
    
    init(color: Color = Color(.systemGray5), title: String = "Title", subTitle: String = "") {
        self.color = color
        self.title = title
        self.subTitle = subTitle
    }
}

// MARK: - Preview
struct BoxTestView_Previews: PreviewProvider {
    static var previews: some View {
        BoxTestView()
    }
}

