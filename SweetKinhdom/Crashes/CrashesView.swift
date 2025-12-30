import SwiftUI

struct CrashesView: View {
    @StateObject var crashesModel =  CrashesViewModel()
    @State var isSet = false
    @State var game1 = false
    @State var game2 = false
    @State var coin = UserDefaultsManager.shared.coins
    var games = [Game(image: "crash1", name: "Candy Fortune"),
                 Game(image: "crash2", name: "Chocolate Melt"),
                 Game(image: "lock2", name: "Sweet Jackpot"),
                 Game(image: "lock1", name: "Chocolate Reels"),
                 Game(image: "lock2", name: "Candy Rush Casino"),
                 Game(image: "lock1", name: "Golden Sweets"),
                 Game(image: "lock2", name: "Sugar Boom Slots"),
                 Game(image: "lock1", name: "Sweet Treat Reels"),
                 Game(image: "lock2", name: "Honey Jackpot")]
    @ObservedObject private var soundManager = SoundManager.shared
    @State var showAlert = false
    
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
                        Image("backSlots")
                            .resizable()
                            .overlay {
                                Text("CRash\nGames")
                                    .font(.custom("BAMEWPersonalUse", size: 35))
                                    .foregroundStyle(Color(red: 255/255, green: 235/255, blue: 163/255))
                                    .multilineTextAlignment(.center)
                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                            }
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 240, height: 90)
                    }
                    
                    ForEach(0..<9, id: \.self) { index in
                        let item = games[index]
                        
                        VStack {
                            Text(item.name)
                                .font(.custom("BAMEWPersonalUse", size: 30))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                            
                            if index >= 2 {
                                Button(action: {
                                    showAlert = true
                                }) {
                                    ZStack {
                                        Image(item.image)
                                            .resizable()
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color(red: 226/255, green: 132/255, blue: 7/255), lineWidth: 5)
                                            }
                                            .frame(width: 350, height: 240)
                                            .cornerRadius(20)
                                        
                                        ZStack(alignment: .leading) {
                                            Rectangle()
                                                .fill(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                                                              Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .top, endPoint: .bottom))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 4)
                                                        .overlay {
                                                            Text("1000000")
                                                                .font(.custom("Chubby Rounded", size: 11))
                                                                .foregroundStyle(.white)
                                                                .multilineTextAlignment(.center)
                                                                .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                                .offset(x: 20)
                                                        }
                                                }
                                                .frame(width: 164, height: 54)
                                                .cornerRadius(20)
                                            
                                            Image("coin")
                                                .resizable()
                                                .frame(width: 62, height: 62)
                                                .offset(x: -10)
                                        }
                                    }
                                }
                                .alert("You don't have enough coins", isPresented: $showAlert) {
                                    Button("OK") {}
                                }
                            } else {
                                Button(action: {
                                    switch index {
                                    case 0 : game1 = true
                                    case 1: game2 = true
                                    default:
                                        game1 = true
                                    }
                                }) {
                                    Image(item.image)
                                        .resizable()
                                        .frame(width: 350, height: 240)
                                }
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
        .fullScreenCover(isPresented: $game1) {
            CandyFortuneView()
        }
        .fullScreenCover(isPresented: $game2) {
            ChocolateMeltView()
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("RefreshData"), object: nil, queue: .main) { _ in
                coin = UserDefaultsManager.shared.coins
            }
        }
    }
}

#Preview {
    CrashesView()
}

