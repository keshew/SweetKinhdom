import SwiftUI

struct ProfileView: View {
    @StateObject var profileModel =  ProfileViewModel()
    @State var coin = UserDefaultsManager.shared.coins
    @State var isSet = false
    @State private var showingNameAlert = false
    @State private var playerNameInput = ""
    @State private var profileImageData: Data?
    @State private var showingImagePicker = false
    @ObservedObject private var soundManager = SoundManager.shared
    let stats = UserDefaultsManager.shared
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    HStack {
                        Button(action: {
                            isSet = true
                        }) {
                            Image("settings")
                                .resizable()
                                .frame(width: 43, height: 43)
                        }
                        
                        Color.clear.frame(width: 35)
                        
                        Spacer()
                        
                        Text("SWEET\nKINGDOM")
                            .font(.custom("BAMEWPersonalUse", size: 30))
                            .foregroundStyle(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                                                     Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
                            .multilineTextAlignment(.center)
                            .outlineText(color: .white, width: 0.7)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 10) {
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                                                  Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .top, endPoint: .bottom))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 4)
                                            .overlay {
                                                Text("\(coin)")
                                                    .font(.custom("Chubby Rounded", size: 7))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                    .offset(x: 6)
                                            }
                                    }
                                    .frame(width: 78, height: 26)
                                    .cornerRadius(13)
                                
                                Image("coin")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .offset(x: -10)
                            }
                            
                            Button(action: {
                                soundManager.toggleMusic()
                            }) {
                                Image(systemName: soundManager.isMusicEnabled ? "speaker.wave.3.fill" : "speaker.fill")
                                    .foregroundStyle(.white)
                            }

                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    VStack {
                        Text("Profile")
                            .font(.custom("BAMEWPersonalUse", size: 35))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                        
                        Button(action: {
                            showingImagePicker = true
                        }) {
                            if let data = UserDefaultsManager.shared.profileImageData ?? profileImageData,
                               let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 240, height: 210)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            } else {
                                Image("pickImg")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 240, height: 210)
                            }
                        }
                        .sheet(isPresented: $showingImagePicker) {
                            PhotoPicker(imageData: $profileImageData)
                                .ignoresSafeArea()
                        }
                        .onChange(of: profileImageData) { newData in
                            if let data = newData {
                                UserDefaultsManager.shared.profileImageData = data
                            }
                        }
                    }
                    
                    VStack {
                        HStack {
                            Text(UserDefaultsManager.shared.playerName)
                                .font(.custom("BAMEWPersonalUse", size: 32))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                            
                            Button(action:{
                                playerNameInput = UserDefaultsManager.shared.playerName
                                                               showingNameAlert = true
                            }) {
                                Image("edit")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            .alert("Edit Player Name", isPresented: $showingNameAlert) {
                                                      TextField("Enter name", text: $playerNameInput)
                                                          .textInputAutocapitalization(.words)
                                                      
                                                      Button("Save") {
                                                          UserDefaultsManager.shared.playerName = playerNameInput
                                                          showingNameAlert = false
                                                      }
                                                      .disabled(playerNameInput.trimmingCharacters(in: .whitespaces).isEmpty)
                                                      
                                                      Button("Cancel", role: .cancel) { }
                                                  }
                        }
                        
                        VStack {
                            
                            HStack(spacing: 20) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                                                  Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 6)
                                            .overlay {
                                                VStack(spacing: 20) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                                                                      Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .top, endPoint: .bottom))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 4)
                                                                .overlay {
                                                                    Text("TOTAL WINS")
                                                                        .font(.custom("BAMEWPersonalUse", size: 20))
                                                                        .foregroundStyle(.white)
                                                                        .multilineTextAlignment(.center)
                                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                                }
                                                        }
                                                        .frame(width: 133, height: 43)
                                                        .cornerRadius(12)
                                                    
                                                    Text("\(stats.totalWins)")
                                                        .font(.custom("Chubby Rounded", size: 13))
                                                        .foregroundStyle(.white)
                                                        .multilineTextAlignment(.center)
                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                }
                                            }
                                    }
                                    .frame(width: 150, height: 138)
                                    .cornerRadius(20)
                                
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                                                  Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 6)
                                            .overlay {
                                                VStack(spacing: 20) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                                                                      Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .top, endPoint: .bottom))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 4)
                                                                .overlay {
                                                                    Text("BALANCE")
                                                                        .font(.custom("BAMEWPersonalUse", size: 20))
                                                                        .foregroundStyle(.white)
                                                                        .multilineTextAlignment(.center)
                                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                                }
                                                        }
                                                        .frame(width: 133, height: 43)
                                                        .cornerRadius(12)
                                                    
                                                    Text("\(coin)")
                                                        .font(.custom("Chubby Rounded", size: 13))
                                                        .foregroundStyle(.white)
                                                        .multilineTextAlignment(.center)
                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                }
                                            }
                                    }
                                    .frame(width: 150, height: 138)
                                    .cornerRadius(20)
                            }
                            
                            HStack(spacing: 20) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                                                  Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 6)
                                            .overlay {
                                                VStack(spacing: 20) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                                                                      Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .top, endPoint: .bottom))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 4)
                                                                .overlay {
                                                                    Text("BIGGEST WINS")
                                                                        .font(.custom("BAMEWPersonalUse", size: 18))
                                                                        .foregroundStyle(.white)
                                                                        .multilineTextAlignment(.center)
                                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                                        .offset(y: 3)
                                                                }
                                                        }
                                                        .frame(width: 133, height: 43)
                                                        .cornerRadius(12)
                                                    
                                                    Text("\(stats.maxWinAmount)$")
                                                        .font(.custom("Chubby Rounded", size: 13))
                                                        .foregroundStyle(.white)
                                                        .multilineTextAlignment(.center)
                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                }
                                            }
                                    }
                                    .frame(width: 150, height: 138)
                                    .cornerRadius(20)
                                
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                                                  Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 6)
                                            .overlay {
                                                VStack(spacing: 20) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                                                                      Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .top, endPoint: .bottom))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 4)
                                                                .overlay {
                                                                    Text("WIN RATE")
                                                                        .font(.custom("BAMEWPersonalUse", size: 20))
                                                                        .foregroundStyle(.white)
                                                                        .multilineTextAlignment(.center)
                                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                                }
                                                        }
                                                        .frame(width: 133, height: 43)
                                                        .cornerRadius(12)
                                                    
                                                    Text(String(format: "%.0f%%", stats.winRate))
                                                        .font(.custom("Chubby Rounded", size: 13))
                                                        .foregroundStyle(.white)
                                                        .multilineTextAlignment(.center)
                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                }
                                            }
                                    }
                                    .frame(width: 150, height: 138)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    
                    Color.clear.frame(height: 60)
                }
            }
        }
        .fullScreenCover(isPresented: $isSet) {
            SettingsView()
        }
    }
}

#Preview {
    ProfileView()
}


extension UserDefaultsManager {
    var playerName: String {
        get { defaults.string(forKey: "playerName") ?? "Player name" }
        set {
            defaults.set(newValue.trimmingCharacters(in: .whitespaces), forKey: "playerName")
            objectWillChange.send()
        }
    }
}

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var imageData: Data?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let item = results.first else { return }
            
            item.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    guard let image = image as? UIImage,
                          let data = image.jpegData(compressionQuality: 0.8) else { return }
                    self.parent.imageData = data
                }
            }
        }
    }
}
