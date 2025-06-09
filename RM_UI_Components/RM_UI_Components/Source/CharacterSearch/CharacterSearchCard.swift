//
//  CharacterSearchCard.swift
//  RM_UI_Components
//
//  Created by Temur Chitashvili on 09.06.25.
//
import SwiftUI
import RM_Core

public struct CharacterSearchCard: View {
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
        HStack(alignment: .top, spacing: 16) {
            image()
            
            characterContent()
                .padding(.top, 8)
        }
    }
    
    private func image() -> some View {
        CachedImage(url: character.image) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 80, height: 80)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipped()
                    .cornerRadius(12)
            case .failure:
                Image(systemName: "xmark.circle")
                    .frame(width: 80, height: 80)
            @unknown default:
                fatalError()
            }
        }
    }
    
    private func characterContent() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(character.name)
                .font(.headline)
                .lineLimit(1)
            
            Text(character.gender)
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
    }
}
