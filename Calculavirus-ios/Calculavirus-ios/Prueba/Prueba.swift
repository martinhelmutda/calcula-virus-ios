import Combine
import Foundation
import SwiftUI

struct ContentViewPhoto: View {
    
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                  self.showCaptureImageView.toggle()
                }) {
                    Text("Choose photos")
                }
                image?.resizable()
                  .frame(width: 250, height: 250)
                  .clipShape(Circle())
                  .overlay(Circle().stroke(Color.white, lineWidth: 4))
                  .shadow(radius: 10)
            }
            
            if (showCaptureImageView) {
                   CaptureImageView(isShown: $showCaptureImageView, image: $image)
                 }
        }
    }
}

struct CaptureImageView {
  /// MARK: - Properties
  @Binding var isShown: Bool
  @Binding var image: Image?
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, image: $image)
  }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
       if !UIImagePickerController.isSourceTypeAvailable(.camera){
           picker.sourceType = .photoLibrary
       } else {
           picker.sourceType = .camera
       }
       return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CaptureImageView>){
        
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @Binding var isCoordinatorShown: Bool
  @Binding var imageInCoordinator: Image?
  init(isShown: Binding<Bool>, image: Binding<Image?>) {
    _isCoordinatorShown = isShown
    _imageInCoordinator = image
  }
  func imagePickerController(_ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
     imageInCoordinator = Image(uiImage: unwrapImage)
     isCoordinatorShown = false
  }
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     isCoordinatorShown = false
  }
}

struct ContentViewPhoto_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewPhoto()
    }
}
