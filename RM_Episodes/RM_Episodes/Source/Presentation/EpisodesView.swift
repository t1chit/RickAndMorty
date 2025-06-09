//
//  EpisodesView.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//

import SwiftUI
import RM_Core

struct EpisodesView: View {
    @StateObject var vm: DefaultEpisodesViewModel
    
    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                Text(vm.state.episode?.name ?? "Unkown Name")
                    .font(.largeTitle.bold())
                    .padding(.top)
                
                // Episode Info
                HStack {
                    Text(vm.state.episode?.episode ?? "Unknown Episode")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Spacer()
                    
                    Text("Aired: \(vm.state.episode?.airDate ?? "Unknown Date" )")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Characters
                Text("Characters")
                    .font(.title2.bold())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(vm.state.charactersInEpisode) { character in
                            CharacterCardViewInEpisode(character: character)
                        }
                    }
                    .frame(height: 150)
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
    }
}

struct CharacterCardViewInEpisode: View {
    let character: EpisodesCharacterDomain

    var body: some View {
        VStack {
            CachedImage(url: character.image) { phase in
                switch phase {
                case .empty:
                    Color.gray.opacity(0.3)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(16)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                case .failure( _ ):
                    Image(systemName: "xmark.circle")
                @unknown default:
                    fatalError()
                }
            }
            
            Text(character.name)
                .font(.caption)
                .lineLimit(1)
        }
        .frame(width: 100)
    }
}
