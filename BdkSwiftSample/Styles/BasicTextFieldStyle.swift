//
//  BasicTextFieldStyle.swift
//  MyFirstApp
//
//  Created by Paul Miller on 11/5/21.
//

import SwiftUI

struct BasicTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
//            .textFieldStyle(.roundedBorder)
            .textInputAutocapitalization(.never)
    }
}

struct BasicTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        Text("TEst")
    }
}
