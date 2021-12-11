//
//  BdkSwiftSampleApp.swift
//  BdkSwiftSample
//
//  Created by Paul Miller on 12/4/21.
//

import SwiftUI

@main
struct BdkSwiftSampleApp: App {
    @StateObject var wallet = WalletViewModel();
    var body: some Scene {
        WindowGroup {
            WalletView().environmentObject(wallet).preferredColorScheme(.dark)
        }
    }
}
