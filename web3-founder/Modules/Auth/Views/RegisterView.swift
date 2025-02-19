import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("邮箱", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)

            SecureField("密码", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("确认密码", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("注册") {
                // 注册逻辑
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .navigationTitle("注册")
    }
} 