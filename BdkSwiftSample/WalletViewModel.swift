//
//  WalletViewModel.swift
//  IOSBdkAppSample
//
//  Created by Sudarsan Balaji on 29/10/21.
//

import Foundation
import BitcoinDevKit

class WalletViewModel: ObservableObject {
    enum State {
        case empty
        case loading
        case failed(Error)
        case loaded(OnlineWallet)
    }
    
    enum SyncState {
        case empty
        case syncing
        case synced
        case failed(Error)
    }
    
    private(set) var key = "private_key"
    @Published private(set) var state = State.empty
    @Published private(set) var syncState = SyncState.empty
    @Published private(set) var balance: UInt64 = 0
    @Published private(set) var balanceText = "sync plz"
    @Published private(set) var transactions: [BitcoinDevKit.Transaction] = []
    
    
    func load() {
        state = .loading
        let db = DatabaseConfig.memory(junk: "")
        let descriptor = "wpkh(tprv8ZgxMBicQKsPeSitUfdxhsVaf4BXAASVAbHypn2jnPcjmQZvqZYkeqx7EHQTWvdubTSDa5ben7zHC7sUsx4d8tbTvWdUtHzR8uhHg2CW7MT/*)"
        let electrum = ElectrumConfig(url: "ssl://electrum.blockstream.info:60002", socks5: nil, retry: 5, timeout: nil, stopGap: 10)
        let blockchain = BlockchainConfig.electrum(config: electrum)
        do {
            let wallet = try OnlineWallet(descriptor: descriptor, changeDescriptor: nil, network: Network.testnet, databaseConfig: db, blockchainConfig: blockchain)
            state = State.loaded(wallet)
        } catch let error {
            state = State.failed(error)
        }
    }
    
    func sync() {
            self.balanceText = "syncing"
        switch self.state {
        case .loaded(let wallet):
            self.syncState = .syncing
            do {
                // TODO use this progress update to show "syncing"
                try wallet.sync(progressUpdate: Progress(), maxAddressParam: nil)
                self.syncState = .synced
                self.balance = try wallet.getBalance()
                self.balanceText = String(format: "%.8f", Double(balance) / Double(100000000))
                let wallet_transactions = try wallet.getTransactions()
                transactions = wallet_transactions.sorted(by: {
                switch $0 {
                case .confirmed(_, let confirmation_a):
                    switch $1 {
                    case .confirmed(_, let confirmation_b): return confirmation_a.timestamp > confirmation_b.timestamp
                    default: return false
                    }
                default:
                    switch $1 {
                    case .unconfirmed(_): return true
                    default: return false
                    }
                } })
          } catch let error {
              print(error)
              self.syncState = .failed(error)
          }
        default: do { }
            print("default")
        }
    }
}
