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
        
        VStack(alignment: .center){
        
            
            Text("Calculavirus")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .padding(100)
            HStack{
                Spacer()
                google().frame(width: 120,height: 50)
                Spacer()
            }
            Spacer()
            
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background(
            Image("canasta")
                .resizable()
//                .aspectRatio(geometry.size, contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 5)
        
            
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


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
 

