//
//  SearchView.swift
//  iTunesSwiftUI
//
//  Created by Kenneth Jones on 7/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import SwiftUI

// Create a SwiftUI view that embeds a UISearchBar in it

final class SearchBar: NSObject, UIViewRepresentable {
    
    @Binding var artistName: String
    @Binding var artistGenre: String
    
    init(artistName: Binding<String> = .constant(""),
         artistGenre: Binding<String> = .constant("")) {
        _artistName = artistName
        _artistGenre = artistGenre
    }
    
    // We need to specify which UIView we're trying to use in SwiftUI
    typealias UIViewType = UISearchBar
    
    func makeUIView(context: Context) -> UIViewType {
        // Initialize and configure the search bar how we want it to be
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Update your view whenever the SwiftUI state changes if needed
        uiView.delegate = self
    }
}

extension SearchBar: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        iTunesAPI.searchArtists(for: searchTerm) { (result) in
            do {
                let artists = try result.get()
                
                guard let firstArtist = artists.first else {
                    self.artistName = "No artists found"
                    self.artistGenre = ""
                    return
                }
                
                self.artistName = firstArtist.artistName
                self.artistGenre = firstArtist.primaryGenreName
            } catch {
                NSLog("No artist found")
                self.artistName = "Error search for artist"
                self.artistGenre = ""
            }
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
