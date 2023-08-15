//
//  ProductListView.swift
//  GroceryPocket
//
//  Created by Виктория Страдзина on 05.08.2023.
//

import SwiftUI

enum AppColorScheme: String, CaseIterable {
    case lightGreen = "Green"
    case lightBlue = "Blue"
    case lightPink = "Pink"
}

struct ProductListView: View {
    @State private var newProduct: String = ""
    @State private var newAmount: String = ""
    @State private var productAmounts: [String: String] = ["Apple": "5", "Banana": "2", "Orange": "6", "Pear": "3", "Grape": "9"]
    @State private var isAddingProduct = false
    @State private var selectedColorScheme = AppColorScheme.lightGreen
    @State private var isShowingSettings = false
    @State private var favoriteProducts: Set<String> = []
    var body: some View {
        NavigationView {
            ZStack {
                colorSchemeBackground
                    .ignoresSafeArea()
                VStack {
                    productsList
                        .padding(.vertical)
                }
                .navigationBarTitle("Grocery list 🍋")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        addButton
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        settingsButton
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Spacer()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        favoritesButton
                    }
                }
            }
            .fullScreenCover(isPresented: $isShowingSettings) {
                SettingsView(selectedColorScheme: $selectedColorScheme)
            }
        }
        .sheet(isPresented: $isAddingProduct) {
            addProductSheet
        }
    }
    
    private var addButton: some View {
        Button(action: {
            isAddingProduct = true
        }) {
            Image(systemName: "plus")
                .foregroundColor(Color.init("lightYellow"))
                .font(.title)
        }
    }
    
    private var favoritesButton: some View {
        NavigationLink(destination: FavoritesView(productAmounts: $productAmounts, favoriteProducts: $favoriteProducts, selectedColorScheme: $selectedColorScheme)) {
            Image(systemName: "heart.fill")
                .foregroundColor(Color.init("lightYellow"))
                .font(.headline)
        }
    }
    
    private var addProductSheet: some View {
        ZStack {
            Color.init("lightYellow")
                .ignoresSafeArea()
            VStack {
                Text("Enter a product")
                    .font(.headline)
                TextField("Enter a product", text: $newProduct)
                    .padding()
                    .background(textFieldColor)
                    .cornerRadius(10)
                    .padding(.top)
                TextField("Amount", text: $newAmount)
                    .padding()
                    .background(textFieldColor)
                    .cornerRadius(10)
                    .padding(.top)
                Button("Add product", action: addNewProduct)
                    .foregroundColor(.black)
                    .padding()
                    .background(textFieldColor)
                    .cornerRadius(10)
                    .padding(.top)
            }
            .padding()
        }
    }
    
    private var productsList: some View {
        List {
            ForEach(productAmounts.keys.sorted(), id: \.self) { product in
                HStack {
                    Text(product)
                    Spacer()
                    Text(productAmounts[product] ?? "")
                        .foregroundColor(.gray)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(action: {
                        moveToFavorites(product)
                    }) {
                        Label("Favorite", systemImage: favoriteProducts.contains(product) ? "heart.fill" : "heart")
                    }
                }
            }
            .onDelete(perform: deleteProduct)
        }
    }
    
    private func addNewProduct() {
        if !newProduct.isEmpty {
            productAmounts[newProduct] = newAmount
            newProduct = ""
            newAmount = ""
            isAddingProduct = false
        }
    }
    
    private func moveToFavorites(_ product: String) {
        if productAmounts[product] != nil {
            favoriteProducts.insert(product)
            productAmounts[product] = nil
        }
    }
    
    private func deleteProduct(at offsets: IndexSet) {
        for index in offsets {
            let product = Array(favoriteProducts.sorted())[index]
            favoriteProducts.remove(product)
        }
    }
    
    private var settingsButton: some View {
        Button(action: {
            isShowingSettings = true
        }) {
            Image(systemName: "gearshape.fill")
                .foregroundColor(Color.init("lightYellow"))
                .font(.title)
        }
    }
    
    private var textFieldColor: Color {
        switch selectedColorScheme {
        case .lightGreen:
            return Color.init("lightGreen")
        case .lightBlue:
            return Color.init("lightBlue")
        case .lightPink:
            return Color.init("lightPink")
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

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}

// добавить избранное, часто покупали, картинки с продуктом, возможно вам будет интересно
