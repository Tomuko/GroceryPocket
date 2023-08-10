//
//  LSGroceryPocket.swift
//  GroceryPocket
//
//  Created by Виктория Страдзина on 06.08.2023.
//

import SwiftUI

struct LSGroceryPocket: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        ZStack {
            Color.init("lightGreen")
            
            VStack {
                Text("🍋")
                    .font(.system(size: 60))
                    .padding(.bottom, 10)
                Text("Grocery Pocket")
                
            }
            .font(.custom("Helvetica Neue", size: 24))
            .foregroundColor(.black)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LSGroceryPocket_Previews: PreviewProvider {
    static var previews: some View {
        LSGroceryPocket()
    }
}



