//
//  MenuBarCoinView.swift
//  CryptoTracker
//
//  Created by Gokula krishnan on 03/02/22.
//

import SwiftUI

struct MenuBarCoinView: View {
    
    @ObservedObject var viewModel: MenuBarCoinViewModel
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "circle.fill")
                .foregroundColor(viewModel.color)
            
            VStack(alignment: .trailing, spacing: -2) {
                Text(viewModel.name)
                Text(viewModel.value)
            }
            .font(.caption)
        }
        .frame(maxWidth: 300)
        .onChange(of: viewModel.selectedCoinType) { _ in
            viewModel.updateView()
            print("update")
        }
        .onAppear {
            viewModel.subscribeToService()
            print("update")
        }
        
        
    }
}

struct MenuBarCoinView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarCoinView(viewModel: .init(name: "Bitcoin", value: "$40,000", color: .green))
    }
}
