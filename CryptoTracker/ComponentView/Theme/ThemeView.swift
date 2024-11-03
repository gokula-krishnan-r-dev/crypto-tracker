//
//  SwiftUIView.swift
//  CryptoTracker
//
//  Created by Gokula Krishnan R on 15/01/24.
//

import SwiftUI


  
struct ThemeView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    
    var body: some View {
        VStack {
            HoverView(title: "\(!isDarkMode ? "dark" : "light")") {
              
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.5)) {
                        isDarkMode.toggle()
                        
                    }
                }) {
                    Image(systemName: isDarkMode ? "light.max" : "moon")
                }
            }
          
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ThemeView()
}
