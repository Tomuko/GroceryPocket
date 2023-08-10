//
//  SettingsView.swift
//  GroceryPocket
//
//  Created by Виктория Страдзина on 10.08.2023.
//
import SwiftUI

struct SettingsView: View {
    @Binding var selectedColorScheme: AppColorScheme
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Change color")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                Picker("Color Scheme", selection: $selectedColorScheme) {
                    ForEach(AppColorScheme.allCases, id: \.self) { scheme in
                        Text(scheme.rawValue).tag(scheme)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Spacer()
                
                Text("Selected Color: \(selectedColorScheme.rawValue)")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: doneButton)
            .background(colorSchemeBackground)
        }
    }
    
    private var doneButton: some View {
        Button("Done") {
            presentationMode.wrappedValue.dismiss()
        }
        .foregroundColor(Color.init("lightYellow"))
        .font(.headline)
        .padding()
    }
    
    private var colorSchemeBackground: Color {
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedColorScheme: .constant(.lightGreen))
    }
}







