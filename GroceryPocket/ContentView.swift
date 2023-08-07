//
//  ContentView.swift
//  GroceryPocket
//
//  Created by Виктория Страдзина on 05.08.2023.
//

import SwiftUI

struct ProductListView: View {
    @State private var newProduct: String = ""
    @State private var newAmount: String = ""
    @State private var productAmounts: [String: String] = ["Apple": "5", "Banana": "2", "Orange": "6", "Pear": "3", "Grape": "9"]
    @State private var isAddingProduct = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                VStack {
                    productsList
                        .padding(.vertical)
                }
                .navigationBarTitle("Grocery list 🍋")
                .navigationBarItems(trailing: addButton)
            }
            .sheet(isPresented: $isAddingProduct) {
                addProductSheet
            }
        }
    }
    
    private var addButton: some View {
        Button(action: {
            isAddingProduct = true
        }) {
            Image(systemName: "plus")
                .foregroundColor(.blue)
                .font(.title)
        }
    }
    
    private var addProductSheet: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            VStack {
                Text("Enter a product")
                    .font(.headline)
                TextField("Enter a product", text: $newProduct)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.top)
                TextField("Amount", text: $newAmount)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.top)
                Button("Add product", action: addNewProduct)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
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
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
