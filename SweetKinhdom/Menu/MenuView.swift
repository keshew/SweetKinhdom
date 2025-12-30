import SwiftUI

struct MenuView: View {
    @StateObject var menuModel =  MenuViewModel()
    @State var coin = UserDefaultsManager.shared.coins
    @State var isSet = false
    @Binding var selectedTab: CustomTabBar.TabType
    @ObservedObject private var soundManager = SoundManager.shared
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
                        Text("SLOTS GAMES")
                            .font(.custom("BAMEWPersonalUse", size: 35))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                        
                        Button(action: {
                            selectedTab = .Slots
                        }) {
                            Image("slots")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350, height: 240)
                        }
                    }
                    
                    VStack {
                        Text("CRASH GAMES")
                            .font(.custom("BAMEWPersonalUse", size: 35))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                        
                        Button(action: {
                            selectedTab = .Crash
                        }) {
                            Image("crash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350, height: 240)
                        }
                    }
                    
                    Color.clear.frame(height: 60)
                }
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("RefreshData"), object: nil, queue: .main) { _ in
                coin = UserDefaultsManager.shared.coins
            }
        }
        .fullScreenCover(isPresented: $isSet) {
            SettingsView()
        }
    }
}

#Preview {
    MenuView(selectedTab: .constant(.Menu))
}

