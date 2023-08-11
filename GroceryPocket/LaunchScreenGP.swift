//
//  LaunchScreenGP.swift
//  GroceryPocket
//
//  Created by Виктория Страдзина on 11.08.2023.
//

import SwiftUI

struct LaunchScreenGP: View {
    
    @State private var isActive = false
    @State private var size: CGFloat = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ProductListView()
        } else {
            ZStack {
                Color("lightGreen")
                
                VStack {
                    Text("🍋")
                        .font(.system(size: 60))
                        .scaleEffect(size)
                        .opacity(opacity)
                        .padding(.bottom, 10)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 2.0)) {
                                size = 1.0
                                opacity = 1.0
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isActive = true
                                }
                            }
                        }
                    
                    Text("Grocery Pocket")
                        .opacity(opacity)
                        .font(.custom("Helvetica Neue", size: 24))
                        .foregroundColor(.black)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 2.0)) {
                                opacity = 1.0
                            }
                        }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    struct LaunchScreenGP_Previews: PreviewProvider {
        static var previews: some View {
            LaunchScreenGP()
        }
    }
}

