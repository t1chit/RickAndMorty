//
//  CharacterCard.swift
//  RM_UI_Components
//
//  Created by Temur Chitashvili on 09.06.25.
//

import SwiftUI
import RM_Core

// MARK: - Character Card

public struct CharacterCard: View {
    private let character: CharacterCardDomain
   
    public init(
        character: CharacterCardDomain
    ) {
        self.character = character
    }
    public var body: some View {
        content()
    }
    
    private func content() -> some View {
        VStack(alignment: .leading,
               spacing: 8) {
            image()
            
            characterContent()
        }
    }
    
    private func image() -> some View {
        CachedImage(url: character.image) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 200, height: 200)
            case .success(let image):
                image
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(16)
            case .failure( _ ):
                Image(systemName: "xmark.circle")
            @unknown default:
                fatalError()
            }
        }
    }
    
    private func characterContent() -> some View {
        VStack(alignment: .leading,
               spacing: 4) {
            
            Text(character.name)
                .font(.headline)
                .lineLimit(1)
            
            HStack {
                Text(character.gender)
                    .foregroundColor(.secondary)
            }
        }
    }
}
