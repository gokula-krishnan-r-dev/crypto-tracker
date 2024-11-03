//
//  Select.swift
//  CryptoTracker
//
//  Created by Gokula Krishnan R on 15/01/24.
//

import SwiftUI
enum Flavor: String, CaseIterable, Identifiable {
    case chocolate, vanilla, strawberry
    var id: Self { self }
}

struct Select: View {
   
    var label: String
    @Binding var selectedFlavor: Flavor
    var options: [Flavor]

    init(label: String, selectedFlavor: Binding<Flavor>, options: [Flavor]) {
        self.label = label
        self._selectedFlavor = selectedFlavor
        self.options = options
    }

    var body: some View {
        VStack {
            Picker(label, selection: $selectedFlavor) {
                ForEach(options, id: \.self) { flavor in
                    Text(flavor.rawValue.capitalized).tag(flavor)
                }
            }
            .frame(width: 160)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 22)
    }
}

struct Select_Previews: PreviewProvider {
    static var previews: some View {
        
        Select(label: "", selectedFlavor: .constant(.chocolate), options: Flavor.allCases)
    }
}
