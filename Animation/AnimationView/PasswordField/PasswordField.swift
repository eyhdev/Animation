//
//  PasswordField.swift
//  Animation
//
//  Created by eyh.mac on 4.09.2023.
//

import SwiftUI

struct PasswordField: View {
    
    @State private var password = "password"
    @State private var showPassword = true
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 50.0)
                .frame(width: 300, height: 75, alignment: .center)
                .foregroundColor(darkGray)
            
            HStack{
                if !showPassword {
                    Spacer()
                }
                RoundedRectangle(cornerRadius: showPassword ? 25.0 : 50.0)
                    .frame(width: showPassword ? 300 : 50, height: showPassword ? 75 : 50, alignment: .center)
                    .animation(.linear(duration: 0.2))
                    .padding(.trailing, showPassword ? 0 : 12)
            }
            HStack{
                if showPassword {
                    TextField("password", text: $password)
                        .font(.headline)
                        .padding(.leading, 20)
                        .foregroundColor(.black)
                } else {
                  SecureField("Password", text: $password)
                        .padding(.leading, 20)
                }
                Spacer()
                
                Image(systemName: showPassword ? "eye" : "eye.slash")
                    .resizable()
                    .frame(width: 32, height: 20)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.trailing, 20)
                    .onTapGesture {
                        showPassword.toggle()
                    }
            }
        }
    }
}

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            PasswordField()
                .frame(width: 300)
                .preferredColorScheme(.dark)
        }
    }
}
