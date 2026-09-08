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
    
    var body: some View {
        SymbolListView(searchText: searchText)
        .searchable(text: $searchText)
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
