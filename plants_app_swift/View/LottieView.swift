import Lottie
import SwiftUI

struct LottieEmptyStateView: UIViewRepresentable {
  var fileName: String
   
  func makeUIView(context: UIViewRepresentableContext<LottieEmptyStateView>) -> some UIView {
     
    let view = UIView(frame: .zero)
     
    let lottieAnimationView = Lottie.LottieAnimationView(name: fileName,
                                                         configuration: LottieConfiguration(renderingEngine: .automatic)
    )
    
     
    
    lottieAnimationView.contentMode = .scaleAspectFit
    lottieAnimationView.loopMode = .loop
    lottieAnimationView.play()
     
    lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(lottieAnimationView)
     
    NSLayoutConstraint.activate([
      lottieAnimationView.widthAnchor.constraint(equalTo: view.widthAnchor),
      lottieAnimationView.heightAnchor.constraint(equalTo: view.heightAnchor)
    ])
     
    return view
  }
   
  func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieEmptyStateView>) {
     
  }
}


//struct LottieView: UIViewRepresentable {
//    
//    var animationFileName: String
//    let loopMode: LottieLoopMode
//    
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        
//    }
//    
//    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
//        let animationView = LottieAnimationView(name: animationFileName)
//        animationView.loopMode = loopMode
//        animationView.play()
//        animationView.contentMode = .scaleAspectFill
//        return animationView
//    }
//}


#Preview {
    MainView()
}
