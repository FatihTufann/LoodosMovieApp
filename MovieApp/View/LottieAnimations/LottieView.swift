import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    let name: String
    let loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        return animationView
    }
    
    func updateUIView(_ uiView: LottieAnimationView, context: Context) {
        uiView.loopMode = loopMode
    }
    
}
