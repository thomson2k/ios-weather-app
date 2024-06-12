import SwiftUI
import MapKit

struct SearchBar: UIViewRepresentable {
    @Binding var searchText: String
    @Binding var searchResults: [MKLocalSearchCompletion]
    @Binding var showSearchResults: Bool
    var onCitySelected: (String) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.showsCancelButton = true
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = searchText
    }

    class Coordinator: NSObject, UISearchBarDelegate, MKLocalSearchCompleterDelegate {
        var parent: SearchBar
        var searchCompleter: MKLocalSearchCompleter

        init(_ parent: SearchBar) {
            self.parent = parent
            self.searchCompleter = MKLocalSearchCompleter()
            super.init()
            self.searchCompleter.delegate = self
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            parent.searchText = searchText
            parent.showSearchResults = !searchText.isEmpty
            searchCompleter.queryFragment = searchText
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            parent.searchText = ""
            parent.showSearchResults = false
        }

        func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            parent.searchResults = completer.results
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if let firstResult = parent.searchResults.first {
                parent.onCitySelected(firstResult.title)
                parent.showSearchResults = false
            }
        }
    }
}

struct SearchResultListView: View {
    @Binding var searchResults: [MKLocalSearchCompletion]
    var onSelect: (MKLocalSearchCompletion) -> Void

    var body: some View {
        List(searchResults, id: \.self) { result in
            Button(action: {
                onSelect(result)
            }) {
                Text(result.title)
                    .foregroundColor(.primary)
            }
        }
    }
}
