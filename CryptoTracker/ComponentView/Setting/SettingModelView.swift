//
//  SettingModelView.swift
//  CryptoTracker
//
//  Created by Gokula Krishnan R on 15/01/24.
//

import SwiftUI

struct SettingModelView: View {
    @State private var isSheetPresented = false

    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isSheetPresented.toggle()
                }
               
            }, label: {
                Image(systemName: "gear")
            })
            .sheet(isPresented: $isSheetPresented) {
                ModalContentView(isSheetPresented: $isSheetPresented) // Replace ModalContentView with the content of your modal
            }
        }
    }
}

struct ModalContentView: View {
    @Binding var isSheetPresented: Bool
    var body: some View {
        VStack {
            Text("Modal Content")
            Button(action: {
                isSheetPresented.toggle()
                // Close the modal if needed
            }, label: {
                Text("Close")
            })
        }
        .padding()
    }
}

#Preview {
    SettingModelView()
}
