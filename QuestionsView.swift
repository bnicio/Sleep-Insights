//
//  QuestionsView.swift
//  sleep_tracker
//
//  Created by Benicio Nell on 05.01.25.
//

import SwiftUI

struct QuestionsView: View {
    
    @State var questions: [Question]
    
    var body: some View {
        NavigationStack {
            Text("Täglicher Fragebogen!")
                .font(.title)
            
            List {
                ForEach($questions) { $question in
                    HStack {
                        Text(question.text)
                        
                        Spacer()
                        
                        Picker("", selection: $question.answer, content: {
                            Text("Nein").tag(false)
                            Text("Ja").tag(true)
                        })
                        .pickerStyle(.segmented)
                        .frame(maxWidth: 130)
                    }
                }
                
                NavigationLink(destination: {
                    AddQuestionView()
                }, label: {
                    Text("Weitere Fragen hinzufügen")
                        .foregroundStyle(.blue)
                        .fontWeight(.bold)
                })
                
            }
        }
    }
}

class Question: Identifiable {
    var id: UUID = UUID()
    var text: String
    var answer: Bool = false
    
    init(text: String, answer: Bool) {
        self.text = text
        self.answer = answer
    }
}

struct AddQuestionView: View {
    @State var question: Question = Question(text: "", answer: false)
    
    var body: some View {
        
        Text("Neue Frage")
            .font(.title)
        
        Form {
            TextField("Neue Frage", text: $question.text)
            
            HStack {
                Text("Standard Antwort:")
                Spacer()
                Picker("", selection: $question.answer, content: {
                    Text("Ja").tag(true)
                    Text("Nein").tag(false)
                })
                .pickerStyle(.segmented)
                .frame(maxWidth: 140)
            }
            
            Text("Fertig")
                .foregroundStyle(.blue)
            
            Text("Vorschläge:")
        }
    }
}

#Preview("Fragebogen") {
    let q1: Question = Question(text: "Alkohol getrunken?", answer: false)
    let q3: Question = Question(text: "Unmittelbar vor dem schlafengehen gegessen?", answer: false)
    let q2: Question = Question(text: "Stressvollen Tag gehabt und noch was anderes?", answer: false)
    let q4: Question = Question(text: "Mittagsschlaf", answer: false)
    let q5: Question = Question(text: "Sport gemacht?", answer: true)
    QuestionsView(questions: [q1,q2,q3,q4,q5])
}

#Preview("Neue Frage") {
    AddQuestionView()
}
