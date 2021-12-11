//
//  ContentView.swift
//  MyFirstApp
//
//  Created by Paul Miller on 11/4/21.
//

import SwiftUI
import Combine
import BitcoinDevKit

class Progress : BdkProgress {
    func update(progress: Float, message: String?) {
        print("progress", progress, message as Any)
    }
}

struct WalletView: View {
    @EnvironmentObject var viewModel: WalletViewModel
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.monospacedSystemFont(ofSize: 28, weight: .bold), .foregroundColor: UIColor.white]
        }
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .empty:
                VStack {Text("error")}
            case .failed(_):
                VStack {Text("error")}
            case .loading:
                VStack {Text("error")}
            case .loaded(_):
                HomeView()
            }
        }.onAppear(perform: viewModel.load)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
