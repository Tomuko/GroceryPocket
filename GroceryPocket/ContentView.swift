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
    @State private var isAddingProduct = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(products, id: \.self) { product in
                        Text(product)
                    }
                    .onDelete(perform: deleteProduct)
                }
                .padding(.vertical)
            }
            .navigationBarTitle("Список продуктов")
            .navigationBarItems(trailing: addButton)
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
                .foregroundColor(.blue)
                .font(.title)
        }
    }
    
    private var addProductSheet: some View {
        VStack {
            Text("Добавьте продукт")
                .font(.headline)
            TextField("Введите продукт", text: $newProduct)
                .padding()
            Button("Добавить", action: addNewProduct)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.top)
        }
        .padding()
    }
    
    private func addNewProduct() {
        if !newProduct.isEmpty {
            products.append(newProduct)
            newProduct = ""
            isAddingProduct = false
        }
    }
    
    private func deleteProduct(at offsets: IndexSet) {
        products.remove(atOffsets: offsets)
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}

