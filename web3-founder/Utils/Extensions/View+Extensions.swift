import SwiftUI

struct Toast {
    let message: String
}

extension View {
    func toastView(toast: Toast?) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}

struct ToastModifier: ViewModifier {
    let toast: Toast?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if let toast = toast {
                VStack {
                    Spacer()
                    Text(toast.message)
                        .padding()
                        .background(Color.gray.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .transition(.opacity)
                }
                .padding()
            }
        }
    }
} 