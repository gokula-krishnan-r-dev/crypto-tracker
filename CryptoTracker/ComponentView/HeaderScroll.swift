//
//  HeaderScroll.swift
//  CryptoTracker
//
//  Created by Gokula Krishnan R on 15/01/24.
//

import SwiftUI

struct HeaderScroll: View {
    @State private var scrollOffset: CGFloat = 0
      private let scrollSpeed: CGFloat = 1.0
    var body: some View {

            ScrollView(.horizontal, showsIndicators: false) {
                       HStack(spacing: 20) {
                           ForEach(0..<10) { _ in
                               HStack {
                                   Text("Market Cap:")
                                       .foregroundColor(Color(red: 0.39, green: 0.45, blue: 0.55))
                                       .font(.system(size: 14))
                                   Text("$2.2323T")
                                       .foregroundColor(Color.black)
                                       .font(.system(size: 14 , weight: .semibold))
                               }
                           }
                       }
                       .padding(.horizontal , 24)
                       .padding(.vertical , 8)
                       .frame(minWidth: 0, maxWidth: .infinity)
                       .offset(x: scrollOffset)
                       .gesture(DragGesture()
                                  .onChanged { value in
                                      let dragSpeed: CGFloat = 12.0  // Adjust the divisor for slower scrolling

                                      let velocity = value.predictedEndTranslation.width - value.translation.width

                                      withAnimation(.linear(duration: 0.33)) {
                                          scrollOffset += velocity / dragSpeed
                                      }
                                  }
                              )
                       .onAppear {
                           let timer = Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { _ in
                               withAnimation(.linear(duration: 0.5)) {
                                   scrollOffset -= scrollSpeed
                               }
                           }
                           RunLoop.current.add(timer, forMode: .common)
                       }
                   }
                
                    
        }
    }


#Preview {
    HeaderScroll()
        .preferredColorScheme(.light)
}
