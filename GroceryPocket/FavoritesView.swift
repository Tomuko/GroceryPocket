//
//  FavoritesView.swift
//  GroceryPocket
//
//  Created by Виктория Страдзина on 11.08.2023.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var productAmounts: [String: String]
    @Binding var favoriteProducts: Set<String>
    @Binding var selectedColorScheme: AppColorScheme
    
    var body: some View {
        NavigationView {
            ZStack {
                colorSchemeBackground
                    .ignoresSafeArea()
                VStack {
                    List {
                        ForEach(Array(favoriteProducts).sorted(), id: \.self) { product in
                            HStack {
                                Text(product)
                                Spacer()
                                Text(productAmounts[product] ?? "")
                                    .foregroundColor(.gray)
                                Button(action: {
                                    toggleFavorite(product)
                                }) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                }
                            }
                            .background(Color.yellow.opacity(0.2))
                        }
                        .onDelete(perform: deleteProduct)
                    }
                }
                .navigationBarTitle("Favorites")
            }
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
            let product = Array(favoriteProducts.sorted())[index]
            favoriteProducts.remove(product)
        }
    }
    
    private var colorSchemeBackground: some View {
        switch selectedColorScheme {
        case .lightGreen:
            return Color.init("lightGreen")
        case .lightBlue:
            return Color.init("lightBlue")
        case .lightPink:
            return Color.init("lightPink")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let initialFavoriteProducts: Set<String> = ["Strawberry", "Chocolate", "Blueberry"]
        
        return FavoritesView(productAmounts: .constant(["Apple": "5", "Banana": "2", "Orange": "6"]),
                             favoriteProducts: .constant(initialFavoriteProducts),
                             selectedColorScheme: .constant(.lightGreen))
    }
}

//Проработать логику приложения, возможно добавить отдельное окно для ввода продуктов в фавориты








