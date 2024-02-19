import SwiftUI

struct MovieItem: View {
    let movie: MovieItemModel
    let width: CGFloat
    
    var body: some View {
        HStack {
            VStack{
                HStack(spacing: 16) {
                    
                    if movie.poster != "N/A" {
                        AsyncImage(url: URL(string: movie.poster)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: width * 0.35)
                                .cornerRadius(5)
                        } placeholder: {
                            
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                .frame(width: width * 0.245)
                        }
                    }else{
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: width * 0.25)
                            .foregroundColor(.gray)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .foregroundColor(.white)
                            .font(.headline)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        Text("Type: \(movie.type)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text("Year: \(movie.year)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Spacer()
                        
                    }
                    .padding(.vertical)
                    
                }
                .padding(7)
                .background(Color.black)
                .cornerRadius(10)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.yellow)
            
        }.padding(.vertical,5)
        
        
        
        
    }
}

