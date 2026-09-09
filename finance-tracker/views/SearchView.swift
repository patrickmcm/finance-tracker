//
//  SearchView.swift
//  finance-tracker
//
//  Created by Patrick McManamon on 07/09/2026.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @State var searchText: String = ""
    @State private var isSearchPresented = true
    
    var body: some View {
        SymbolListView(searchText: searchText)
            .searchable(text: $searchText, isPresented: $isSearchPresented)
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {    
    NavigationStack {
        SearchView()
            .modelContainer(SampleSwiftData.shared.modelContainer)
    }
}
