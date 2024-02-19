import SwiftUI
import Firebase

struct SplashView: View {
    
    let remoteConfig = RemoteConfig.remoteConfig()
    
    @State private var isButtonTapped = false
    @State private var isLoodosTapped = false
    @State private var isLoading = false
    @State private var isActive: Bool = false
    @State private var splashName: String = ""
    
    var body: some View {
        
        NavigationView{
            GeometryReader{ geometry in
                ZStack{
                    Color.black
                        .ignoresSafeArea()
                    
                    ZStack() {
                        
                        NavigationLink(
                            destination: HomePageView()
                                .navigationBarBackButtonHidden(true),
                            isActive: $isActive
                        ) {
                            Button(action: {
                                
                                withAnimation(Animation.linear(duration: 1.0)) {
                                    isLoading = true
                                    isButtonTapped.toggle()
                                    isLoodosTapped = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        isActive = true
                                    }
                                }
                            }) {
                                
                                Text(splashName)
                                    .font(.custom("Poppins-SemiBold", size: 35))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .scaleEffect(isButtonTapped ? 1.2 : 1.0)
                                    .offset(y: isLoodosTapped ? -40 : 0)
                                
                            }
                            .disabled(isLoodosTapped)
                            
                        }
                        
                        .padding()
                        
                        if isLoading {
                            ProgressView()
                                .scaleEffect(1.7)
                                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                                .padding(.top, geometry.size.height * 0.2)
                        }
                        
                    }
                    .padding(.bottom)
                }
            }
        }
        .onAppear {
            fetchSplashNameConfig()
            Analytics.logEvent(AnalyticsEventScreenView,
                               parameters: [AnalyticsParameterScreenName: "\(SplashView.self)",
                                           AnalyticsParameterScreenClass: "\(SplashView.self)"])
        }
        
    }
    
    
    private func fetchSplashNameConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                self.remoteConfig.activate { changed, error in
                    guard error == nil else {
                        return
                    }
                    
                    if let value = self.remoteConfig.configValue(forKey: "splash_name").stringValue {
                        self.splashName = value
                    }
                }
            } else {
                Analytics.logEvent("config_event", parameters: [
                    "message": "Config not fetched"
                ])
            }
        }
    }
    
}



#Preview {
    SplashView()
}
