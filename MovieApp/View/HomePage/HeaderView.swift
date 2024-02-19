import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack{
            Image("movie")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.yellow)
                .padding(.bottom)
            
            Text("Loodos Movie")
                .font(.custom("Poppins-SemiBold", size: 35))
                .fontWeight(.bold)
                .foregroundColor(.yellow)
        }.padding()
    }
}

#Preview {
    HeaderView()
}
