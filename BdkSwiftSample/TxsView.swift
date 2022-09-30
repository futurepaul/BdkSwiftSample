//
//  TxsView.swift
//  MyFirstApp
//
//  Created by Paul Miller on 11/5/21.
//

import SwiftUI
import BitcoinDevKit

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

struct TxsView: View {

    @EnvironmentObject var viewModel: WalletViewModel
    
    var body: some View {
        BackgroundWrapper {
            ScrollView {
                if viewModel.transactions.isEmpty {
                    Text("No transactions yet.").padding()
                } else {
                    ForEach(viewModel.transactions, id: \.self) { transaction in
                        SingleTxView(transactionDetails: transaction)
                    }
                }
            }
        }
        .navigationTitle("Transactions")
        .modifier(BackButtonMod())
    }
}

struct TxsView_Previews: PreviewProvider {
    static var previews: some View {
        TxsView()
    }
}

