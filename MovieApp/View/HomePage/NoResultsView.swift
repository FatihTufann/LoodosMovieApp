import SwiftUI

struct NoResultsView: View {
    var body: some View {
        VStack {
            Image(systemName: "info.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
            
            Text("Movie/Series Not Found!")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NoResultsView()
}
