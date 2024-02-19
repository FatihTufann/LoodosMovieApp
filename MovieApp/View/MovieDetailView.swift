import SwiftUI
import Firebase


struct MovieDetail: View {
    let imdbID: String
    
    @StateObject var viewModel = MovieDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .imageScale(.large)
                        }
                        .frame(width: 50, height: 50)
                        
                        Spacer()
                        
                        Text("Movie Detail")
                            .foregroundColor(.yellow)
                            .font(.custom("Poppins-Medium", size: 25))
                            .padding(.trailing, geometry.size.width * 0.30)
                    }
                    
                    if viewModel.detailResults != nil {
                        HStack {
            
                            if viewModel.detailResults?.poster != "N/A" {
                                AsyncImage(url: URL(string: viewModel.detailResults?.poster ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width * 0.35)
                                        .padding(.leading, 20)
                                        .padding(.top, 20)
                                } placeholder: {
                                    
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                        .frame(width: geometry.size.width * 0.26)
                                }
                            }else{
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.35)
                                    .padding(.leading, 20)
                                    .padding(.top, 20)
                                    .foregroundColor(.gray)
                            }
                            
                       
                            
                            VStack(alignment: .leading) {
                                Text(viewModel.detailResults?.title ?? "Title")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 5)
                                HStack {
                                    
                                    Text("IMDB: \(viewModel.detailResults?.imdbRating ?? "")")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 13))
                                }
                                
                                Text("\(viewModel.detailResults?.released ?? "")")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                
                                
                                Text("\(viewModel.detailResults?.runtime ?? "")")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.gray)
                                    .cornerRadius(5)
                                
                            }
                            .padding(.leading, 20)
                            Spacer()
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.detailResults?.genre ?? "")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.gray)
                                .cornerRadius(5)
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(viewModel.detailResults?.plot ?? "")
                                .font(.body)
                                .foregroundColor(.white)
                            Text("Director: ")
                                .font(.headline)
                                .foregroundColor(.yellow)
                            +
                            Text("\(viewModel.detailResults?.director ?? "")")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text("Actors: ")
                                .font(.headline)
                                .foregroundColor(.yellow)
                            +
                            Text("\(viewModel.detailResults?.actors ?? "")")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text("Country: ")
                                .font(.headline)
                                .foregroundColor(.yellow)
                            +
                            Text("\(viewModel.detailResults?.country ?? "")")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            Text("Awards: ")
                                .font(.headline)
                                .foregroundColor(.yellow)
                            +
                            Text("\(viewModel.detailResults?.awards ?? "")")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top)
                    }else if !viewModel.response {
                     
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
                        
                    }else {
                        Spacer()
                        HStack {
                            Spacer()
                            ProgressView()
                                .scaleEffect(1.7)
                                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                .padding(.top, geometry.size.width * 0.6)
                            Spacer()
                        }
                        Spacer()
                        
                    }

                }
                .onAppear {
                    Analytics.logEvent(AnalyticsEventScreenView,
                                       parameters: [AnalyticsParameterScreenName: "\(HomePageView.self)",
                                                   AnalyticsParameterScreenClass: "\(HomePageView.self)"])
                }
            }

            .background(Color.black)
            .onAppear {
                viewModel.getMovies(with: imdbID)
            }
        }
        
        
    }
    
    
}


