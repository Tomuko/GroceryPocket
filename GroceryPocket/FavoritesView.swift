//
//  FavoritesView.swift
//  GroceryPocket
//
//  Created by Виктория Страдзина on 11.08.2023.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var productAmounts: [String: String]
    @State private var favoriteProducts: Set<String> = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(productAmounts.keys.sorted(), id: \.self) { product in
                    HStack {
                        Text(product)
                        Spacer()
                        Text(productAmounts[product] ?? "")
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            toggleFavorite(product)
                        }) {
                            Image(systemName: favoriteProducts.contains(product) ? "heart.fill" : "heart")
                                .foregroundColor(favoriteProducts.contains(product) ? .red : .gray)
                        }
                    }
                    .background(favoriteProducts.contains(product) ? Color.yellow.opacity(0.2) : Color.clear)
                }
                .onDelete(perform: deleteProduct)
            }
            .navigationBarTitle("Favorites")
        }
    }
    
    private func toggleFavorite(_ product: String) {
        if favoriteProducts.contains(product) {
            favoriteProducts.remove(product)
        } else {
            favoriteProducts.insert(product)
        }
    }
    
    private func deleteProduct(at offsets: IndexSet) {
        for index in offsets {
            let product = Array(productAmounts.keys.sorted())[index]
            productAmounts[product] = nil
            favoriteProducts.remove(product)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(productAmounts: .constant(["Apple": "5", "Banana": "2", "Orange": "6"]))
    }
}
