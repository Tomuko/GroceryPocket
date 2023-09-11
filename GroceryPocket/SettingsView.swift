import SwiftUI

struct SettingsView: View {
    @Binding var selectedColorScheme: AppColorScheme
    @Environment(\.presentationMode) var presentationMode
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var bio: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Information")) {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                    TextEditor(text: $bio)
                }
                
                Section(header: Text("App Settings")) {
                    Picker("Color Scheme", selection: $selectedColorScheme) {
                        ForEach(AppColorScheme.allCases, id: \.self) { scheme in
                            Text(scheme.rawValue).tag(scheme)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Profile Settings", displayMode: .inline)
            .navigationBarItems(trailing: saveButton)
            .background(ColorSchemeBackground(colorScheme: selectedColorScheme))
        }
    }
    
    private var saveButton: some View {
        Button("Save") {
            // Здесь вы можете сохранить изменения в профиле
            saveProfileChanges()
        }
        .foregroundColor(Color.init("lightYellow"))
        .font(.headline)
        .padding()
    }
    
    private func saveProfileChanges() {
        // Здесь вы можете выполнить сохранение изменений профиля
        // Например, отправить данные на сервер или сохранить их локально
    }
}

struct ColorSchemeBackground: View {
    let colorScheme: AppColorScheme
    
    var body: some View {
        switch colorScheme {
        case .lightGreen:
            return Color.init("lightGreen").ignoresSafeArea()
        case .lightBlue:
            return Color.init("lightBlue").ignoresSafeArea()
        case .lightPink:
            return Color.init("lightPink").ignoresSafeArea()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedColorScheme: .constant(.lightGreen))
    }
}
