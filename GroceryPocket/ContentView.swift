//
//  ContentView.swift
//  GroceryPocket
//
//  Created by Виктория Страдзина on 05.08.2023.
//

import SwiftUI

struct ProductListView: View {
    @State private var products: [String] = ["Яблоко", "Банан", "Апельсин", "Груша", "Виноград"]
    @State private var newProduct: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Введите продукт", text: $newProduct)
                    .padding()
                
                Button(action: {
                    if !newProduct.isEmpty {
                        products.append(newProduct)
                        newProduct = ""
                    }
                }) {
                    Text("Добавить продукт")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom)
                
                List {
                    ForEach(products, id: \.self) { product in
                        Text(product)
                            .swipeActions {
                                Button(action: {
                                    if let index = products.firstIndex(of: product) {
                                        products.remove(at: index)
                                    }
                                }) {
                                    Text("Удалить")
                                        .foregroundColor(.white)
                                }
                                .background(Color.red)
                            }
                    }
                }
            }
            .navigationBarTitle("Список продуктов")
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}

