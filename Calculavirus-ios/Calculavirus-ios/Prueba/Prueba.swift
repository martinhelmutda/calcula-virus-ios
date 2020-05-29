import Combine
import Foundation
import SwiftUI
import GoogleSignIn



struct LoginView: View {
    var profile = GIDProfileData()
    
    var body: some View {
        VStack(alignment: .leading){
            google().frame(width: 120,height: 50)
            
            Text("Hola")
            
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}


struct google : UIViewRepresentable {
    

    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        
        return button
    }
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>) {
        print("HOLA")
    }
}
 

