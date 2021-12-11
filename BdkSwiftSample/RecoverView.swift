//
//  RecoverView.swift
//  MyFirstApp
//
//  Created by Paul Miller on 11/5/21.
//

import SwiftUI

struct RecoverView: View {
    @State private var words = Array(repeating: "", count: 12)
    
    var body: some View {
        BackgroundWrapper {
            ScrollView {
                ForEach(0..<12) { i in
                    TextField(
                    "Word \(i + 1)",
                    text: $words[i]
                    )
                }
                .disableAutocorrection(true).padding(.bottom, 10)
                .textInputAutocapitalization(.never)
                BasicButton(action: {}, text: "Recover")
            }
            .textFieldStyle(.roundedBorder)
        }
        .navigationTitle("12 Words")
        .modifier(BackButtonMod())
    }
}

struct RecoverView_Previews: PreviewProvider {
    static var previews: some View {
        RecoverView()
    }
}
