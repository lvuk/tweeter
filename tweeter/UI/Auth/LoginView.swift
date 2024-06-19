//
//  LoginView.swift
//  tweeter
//
//  Created by Luka Vuk on 13.11.2023..
//
import SwiftUI
import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
       NavigationStack {
            VStack {
                Image("logo-twitter")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 100)
                    .padding(.top, 88)
                    .padding(.bottom, 32)
                
                VStack {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color.init(UIColor(white: 0, alpha: 0.05)))
                        .clipShape(Capsule())
                        .padding()
                    
                    CustomSecureField(text: $password, placeholder: Text("Password"))
                        .padding()
                        .background(Color.init(UIColor(white: 0, alpha: 0.05)))
                        .clipShape(Capsule())
                        .padding(.horizontal)
                }
                
                HStack {
                    Spacer()
                    
                    Button {
                        //Forgot password handling
                    } label: {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .bold()
                            .foregroundStyle(.black)
                            .padding(.top, 8)
                            .padding(.trailing)
                    }
                }
                
                Button {
                    if email.isEmpty || password.isEmpty {
                        errorMessage = "Please enter both email and password."
                        showError = true
                    } else {
                        viewModel.login(withEmail: email, password: password)
                    }
                } label: {
                    Text("Sign In")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 150)
                        .background(Color.init(UIColor(white: 0, alpha: 1)))
                        .clipShape(Capsule())
                        .padding(.top)
                }
                
                Spacer()
                
                NavigationLink(
                    destination: RegisterView().navigationBarBackButtonHidden(),
                    label: {
                        HStack {
                            Text("Don't have an account yet?")
                            Text("Sign Up")
                                .font(.headline)
                        }
                        .foregroundStyle(.black)
                    }
                )
            }
            .onReceive(viewModel.$error) { loginError in
                if let error = loginError {
                    errorMessage = error.localizedDescription
                    showError = true
                }
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

//#Preview {
//    LoginView()
//}
