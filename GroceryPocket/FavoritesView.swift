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
    @State private var isAddingFavorite = false
    @State private var newFavorite: String = ""
    
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
                        .onDelete(perform: deleteProduct(at:))
                    }
                    .navigationBarTitle("Favorites")
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            addButton
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isAddingFavorite) {
            addFavoriteSheet
        }
    }

    private var addButton: some View {
        Button(action: {
            isAddingFavorite = true
        }) {
            Image(systemName: "plus")
                .foregroundColor(.red)
        }
    }

    private var addFavoriteSheet: some View {
        ZStack {
            colorSchemeBackground
                .ignoresSafeArea()
            VStack {
                Text("Add Favorite Product")
                    .font(.headline)
                TextField("Enter a product", text: $newFavorite)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.top)
                Button("Add", action: addFavorite)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.top)
            }
            .padding()
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

    private func addFavorite() {
        if !newFavorite.isEmpty {
            favoriteProducts.insert(newFavorite)
            newFavorite = ""
            isAddingFavorite = false
        }
    }

    private var colorSchemeBackground: Color {
        let colorMap: [AppColorScheme: Color] = [
            .lightGreen: Color("lightGreen"),
            .lightBlue: Color("lightBlue"),
            .lightPink: Color("lightPink")
        ]
        return colorMap[selectedColorScheme] ?? Color.clear
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








