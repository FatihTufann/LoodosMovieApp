import SwiftUI
import Firebase
import NavigationTransitions

struct SplashView: View {
    
    let remoteConfig = RemoteConfig.remoteConfig()
    
    @State private var isLoading = false
    @State private var splashName: String = ""
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
                    ZStack {
                        NavigationLink(
                            destination: HomePageView().navigationBarBackButtonHidden(true),
                            isActive: $isActive
                        ){
                            Text(splashName)
                                .font(.custom("Poppins-SemiBold", size: 35))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .scaleEffect(isLoading ? 1.2 : 1.0)
                                .offset(y: isLoading ? -40 : 0)
                        }
                        
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
        .navigationTransition(
            .fade(.in).animation(.easeInOut(duration: 0.3))
        )
        .onAppear {
            fetchSplashNameConfig()
            LogEventManager().logCurrentView(screenName: "splash_view", className: "\(SplashView.self)")
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
                        startAnimation()
                    } else {
                        self.splashName = "LOODOS"
                        startAnimation()
                    }
                }
            } else {
                LogEventManager().logCustomEvent(title: "config_param_status", parameters: [
                    "message": "Config not fetched"
                ])
            }
        }
    }
    
    private func startAnimation() {
        withAnimation(Animation.linear(duration: 1.0)) {
            isLoading = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isActive = true
        }
    }
}


#Preview {
    SplashView()
}
