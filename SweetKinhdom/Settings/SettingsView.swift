import SwiftUI

struct SettingsView: View {
    @StateObject var settingsModel =  SettingsViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var coin = UserDefaultsManager.shared.coins
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    HStack {
                        Button(action: {
                            NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .foregroundStyle(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                                                         Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
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
                                settingsModel.soundManager.toggleMusic()
                            }) {
                                Image(systemName: settingsModel.soundManager.isMusicEnabled ? "speaker.wave.3.fill" : "speaker.fill")
                                    .foregroundStyle(.white)
                            }

                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    VStack {
                        Text("SETTINGS")
                            .font(.custom("BAMEWPersonalUse", size: 35))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                    }
                    
                    VStack(spacing: 15) {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                                          Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 6)
                                    .overlay {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text("SOUND EFFECT")
                                                    .font(.custom("BAMEWPersonalUse", size: 27))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                
                                                Text("GAME SOUNDS AND AUDIO")
                                                    .font(.custom("Chubby Rounded", size: 8))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                            }
                                            
                                            Spacer()
                                            
                                            Toggle("", isOn: $settingsModel.isSoundOn)
                                                .toggleStyle(CustomToggleStyle())
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                            .frame(height: 104)
                            .cornerRadius(20)
                            .padding(.horizontal)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                                          Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 6)
                                    .overlay {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text("NOTIFICATIONS")
                                                    .font(.custom("BAMEWPersonalUse", size: 27))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                
                                                Text("DAILY REWARDS / UPDATES")
                                                    .font(.custom("Chubby Rounded", size: 8))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                            }
                                            
                                            Spacer()
                                            
                                            Toggle("", isOn: $settingsModel.isNotification)
                                                .toggleStyle(CustomToggleStyle())
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                            .frame(height: 104)
                            .cornerRadius(20)
                            .padding(.horizontal)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                                          Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 6)
                                    .overlay {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text("HAPTIC FEEDBACK")
                                                    .font(.custom("BAMEWPersonalUse", size: 27))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                
                                                Text("VIBRATION ON ACTIONS")
                                                    .font(.custom("Chubby Rounded", size: 8))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                            }
                                            
                                            Spacer()
                                            
                                            Toggle("", isOn: $settingsModel.isVib)
                                                .toggleStyle(CustomToggleStyle())
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                            .frame(height: 104)
                            .cornerRadius(20)
                            .padding(.horizontal)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                                          Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 6)
                                    .overlay {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text("TECHNICAL SUPPORT")
                                                    .font(.custom("BAMEWPersonalUse", size: 27))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                
                                                Text("DESCRIBE YOUR PROBLEM")
                                                    .font(.custom("Chubby Rounded", size: 8))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                            }
                                            
                                            Spacer()
                                        }
                                        .padding(.horizontal)
                                    }
                            }
                            .frame(height: 104)
                            .cornerRadius(20)
                            .padding(.horizontal)
                    }
                    
                    Color.clear.frame(height: 60)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}



struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                              Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .top, endPoint: .bottom))
                .frame(width: 42, height: 22)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 240/255, green: 155/255, blue: 38/255), lineWidth: 2)
                        .overlay {
                            Circle()
                                .fill(Color(red: 240/255, green: 155/255, blue: 38/255))
                                .frame(width: 20, height: 20)
                                .offset(x: configuration.isOn ? 11 : -11)
                                .animation(.easeInOut, value: configuration.isOn)
                        }
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

