//
//  HomeView.swift
//  MyFirstApp
//
//  Created by Paul Miller on 11/4/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: WalletViewModel
    
    @State private var goToIntro = false
    @State private var goToTxs = false
    
    var body: some View {
        BackgroundWrapper {
            VStack {
                Button(action: {() in goToIntro = true}) {
                    HStack() {
                        Spacer()
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(Color.white)
                    }
                }
                NavigationLink(destination: SettingsView(), isActive: $goToIntro) { EmptyView() }
            }
            Spacer().frame(minHeight: 40)
            BalanceDisplay(balance: viewModel.balanceText ).padding(.leading, -10).padding(.trailing, -10)
            Spacer().frame(minHeight: 40)
            VStack() {
                BasicButton(action: viewModel.sync, text: "sync wallet").padding(.bottom, 10)
                NavigationLink(destination: TxsView(), isActive: $goToTxs) { EmptyView() }
                BasicButton(action: { goToTxs = true}, text: "transaction history")
            }.padding(.bottom, 10)
            switch viewModel.state {
                case .loaded(let wallet):
                    do {
                        SendReceiveButtons(wallet: wallet)
                    }
                default: do { }
            }
            Spacer().frame(minHeight: 40)
        }.navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
