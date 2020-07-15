//
//  ContentView.swift
//  iTunesSwiftUI
//
//  Created by Fernando Olivares on 28/03/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

// Components of SwiftUI
// - Views
// - Modifiers

struct ContentView: View {
    
    @State var artistName = ""
    @State var artistGenre = ""
    
    var body: some View {
        VStack() {
            Text("Search for artists with the iTunes API")
            
            SearchBar(artistName: $artistName, artistGenre: $artistGenre)
            
            Text(artistName)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing, .bottom], 12)
            
            if !artistGenre.isEmpty {
                HStack {
                    Text("Artist Genre:")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    Text(artistGenre)
                        .font(.subheadline)
                }
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
