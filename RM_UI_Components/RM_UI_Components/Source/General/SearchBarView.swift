//
//  SearchBarView.swift
//  RM_UI_Components
//
//  Created by Temur Chitashvili on 09.06.25.
//


import SwiftUI

public struct SearchBarView: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var placeholder: String = "Search..."

    public init(
        text: Binding<String>,
        placeholder: String = "Search..."
    ) {
        self._text = text
        self.placeholder = placeholder
    }
    
    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(placeholder, text: $text)
                .focused($isFocused)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .submitLabel(.search)
              
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.2), value: text)
    }
}
