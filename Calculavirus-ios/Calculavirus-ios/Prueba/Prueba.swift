import Combine
import Foundation
import SwiftUI
import GoogleSignIn
import FirebaseAuth

class UserData: ObservableObject {
   @Published var loggedIn = false
}


struct LoginView: View {
    
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
    
    @EnvironmentObject var userData: UserData

    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        let vc = UIApplication.shared.windows.first!.rootViewController
        GIDSignIn.sharedInstance()?.presentingViewController = vc
        return button
    }
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>) {
        
    }
    
}
 

