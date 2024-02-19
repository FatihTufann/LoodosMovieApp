import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var isSearching: Bool = false
    
    var onSearchButtonTapped: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Movie ...", text: $searchText)
                    .padding(.leading, 2)
                
                if searchText != "" {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.trailing,5)
            .onTapGesture {
                isSearching = true
            }
            
            Button(action: {
                LogEventManager().logActionStatus(title: "search_action", status: ActionStatus.button_pressed)
                onSearchButtonTapped()
            }) {
                Text("Search")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
            
        }    
        .padding(.horizontal)
        .padding(.bottom)
        
    }
}
