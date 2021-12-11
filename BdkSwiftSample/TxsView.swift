//
//  TxsView.swift
//  MyFirstApp
//
//  Created by Paul Miller on 11/5/21.
//

import SwiftUI
import BitcoinDevKit

//extension Transaction {
//    public func getDetails() -> TransactionDetails {
//        switch self {
//        case Transaction.unconfirmed(let details): return details
//        case Transaction.confirmed(let details, _): return details
//        }
//    }
//}

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

struct TxsView: View {
//    var transactions: [BitcoinDevKit.Transaction]
    @EnvironmentObject var viewModel: WalletViewModel
    
    var body: some View {
        BackgroundWrapper {
            ScrollView {
                if viewModel.transactions.isEmpty {
                    Text("No transactions yet.").padding()
                } else {
                    ForEach(viewModel.transactions, id: \.self) { transaction in
                        SingleTxView(transaction: transaction)
                    }
                }
//                SingleTxView()
//                SingleTxView()
//                SingleTxView()
//                SingleTxView()
//                SingleTxView()
//                SingleTxView()
//                SingleTxView()
//                SingleTxView()
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

