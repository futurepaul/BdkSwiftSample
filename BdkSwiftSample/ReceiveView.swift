//
//  ReceiveView.swift
//  MyFirstApp
//
//  Created by Paul Miller on 11/5/21.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import BitcoinDevKit

let context = CIContext()
let filter = CIFilter.qrCodeGenerator()

struct ReceiveView: View {
    @EnvironmentObject var viewModel: WalletViewModel
    @State private var address: String = "tb1qfafsasdfasd"
    
    func splitAddress(address: String) -> (String, String) {
        let length = address.count
        
        return (String(address.prefix(length / 2)), String(address.suffix(length / 2)))
    }
    
    func getAddress() {
        switch viewModel.state {
            case .loaded(let wallet, _):
                do {
                        let addressInfo = try wallet.getAddress(addressIndex: AddressIndex.new)
                        address = addressInfo.address
                } catch {
                    address = "ERROR"
                }
            default: do { }
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    var body: some View {
        BackgroundWrapper {
            Spacer()
            VStack {
                Image(uiImage: generateQRCode(from: "bitcoin:\(address)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
                Text(splitAddress(address: address).0).textStyle(BasicTextStyle(white: true))
                Text(splitAddress(address:  address).1).textStyle(BasicTextStyle(white: true))
                    .onTapGesture(count: 1) {
                        UIPasteboard.general.string = address
                    }
                Spacer()
            }.contextMenu {
                Button(action: {
                    UIPasteboard.general.string = address}) {
                        Text("Copy to clipboard")
                    }
            }
            Spacer()
            BasicButton(action: getAddress, text: "Generate new address", color: "Green")
        }
        .navigationTitle("Receive Address")
        .modifier(BackButtonMod())
        .onAppear(perform: getAddress)
    }
}

struct ReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveView()
    }
}
