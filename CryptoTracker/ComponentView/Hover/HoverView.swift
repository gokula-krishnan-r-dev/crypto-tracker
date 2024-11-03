//
//  HoverView.swift
//  CryptoTracker
//
//  Created by Gokula Krishnan R on 15/01/24.
//

import SwiftUI

class HoverModel: ObservableObject {
    @Published var hovered: Bool = false
}

struct HoverViewModifier: ViewModifier {
    @ObservedObject var hoverModel = HoverModel()
    var title: String
    func body(content: Content) -> some View {
        content
            .onHover { isHovered in
                withAnimation {
                    hoverModel.hovered = isHovered
                }
            }
            .overlay(
                TooltipView(isHovered: hoverModel.hovered, title: title)
                    .offset(y: -30)
                    .zIndex(888)
            )
    }
}

struct TooltipView: View {
    var isHovered: Bool
    var title: String

    var body: some View {
        if isHovered {
            VStack {
                Text(title)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black)
                    .cornerRadius(8)
                    .opacity(0.9)
                    .frame(width: 100)
            }
            .padding(8)
            .background(Color.clear)
            .transition(.opacity)
        }
    }
}

struct HoverView<Content: View>: View {
    var content: Content
    var title: String

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        HStack {
            content
                .modifier(HoverViewModifier( title: title))
        }
    }
}



#Preview(body: {
    HoverView(title: " Demo") {
        Text("Hover Me")
    }
    .frame(width: 300 ,height: 300)
})
