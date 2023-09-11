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
    @State private var favoriteProducts: Set<String> = []
    @State private var isAddingProduct = false
    @State private var isShowingSettings = false
    @State private var selectedColorScheme = AppColorScheme.lightGreen
    
    var body: some View {
        NavigationView {
            ZStack {
                colorSchemeBackground
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    productsList
                        .padding(.vertical)
                }
                .navigationBarTitle("Grocery list 🍋")
                .toolbar {
                }
                .sheet(isPresented: $isAddingProduct) {
                    addProductSheet
                }
                
                VStack {
                    Spacer()
                    buttonsStack
                        .padding()
                        .background(Color.white)
                }
            }
        }
    }
    
    private var buttonsStack: some View {
        HStack {
            Spacer()
            addButton
            Spacer()
            favoritesButton
            Spacer()
            settingsButton
            Spacer()
        }
    }
    
    private var addButton: some View {
        Button(action: {
            isAddingProduct = true
        }) {
            Image(systemName: "plus")
                .foregroundColor(textFieldColor)
                .font(.system(size: 35))
        }
    }
    
    private var favoritesButton: some View {
        NavigationLink(destination: FavoritesView(productAmounts: $productAmounts, favoriteProducts: $favoriteProducts, selectedColorScheme: $selectedColorScheme)) {
            Image(systemName: "heart")
                .foregroundColor(textFieldColor)
                .font(.system(size: 35))
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
    
    private func deleteProduct(at offsets: IndexSet) {
        for index in offsets {
            let product = Array(productAmounts.keys.sorted())[index]
            productAmounts[product] = nil
            favoriteProducts.remove(product)
        }
    }
    
    private var settingsButton: some View {
        Button(action: {
            isShowingSettings = true
        }) {
            Image(systemName: "gearshape.fill")
                .foregroundColor(Color.init("lightYellow"))
                .font(.system(size: 35))
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView(selectedColorScheme: $selectedColorScheme)
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



