import SwiftUI

struct ChocolateMeltView: View {
    @StateObject var viewModel = ChocolateMeltViewModel()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Image("bgChocolate")
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    HStack {
                        VStack {
                            Button(action: {
                                NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "arrow.left")
                                    .foregroundStyle(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                        Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
                            }
                        }
                        
                        Color.clear.frame(width: 35)
                        Spacer()
                        
                        Text("CHOCOLATE\nMELT")
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
                                                Text("\(viewModel.coin)")
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
                    
                    Text("x \(viewModel.multiplier, specifier: "%.2f")")
                        .font(.custom("Chubby Rounded", size: 17))
                        .foregroundStyle(LinearGradient(colors: [Color(red: 242/255, green: 103/255, blue: 0/255),
                            Color(red: 254/255, green: 237/255, blue: 35/255)], startPoint: .leading, endPoint: .trailing))
                        .padding(.top)
                        .outlineText(color: .red, width: 0.7)
                    
                    Image(viewModel.currentChocolateImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .padding(.top)
                        .scaleEffect(viewModel.isMelting ? 1.05 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.currentChocolateImage)
                    
                    HStack {
                        VStack {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                    Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 226/255, green: 131/255, blue: 4/255), lineWidth: 5)
                                        .overlay {
                                            HStack(spacing: 20) {
                                                Text("\(viewModel.bet)")
                                                    .font(.custom("Chubby Rounded", size: 7))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                
                                                Spacer()
                                                
                                                Button(action: {
                                                    if viewModel.bet >= 100 {
                                                        viewModel.bet -= 50
                                                    }
                                                }) {
                                                    Text("-")
                                                        .font(.custom("Chubby Rounded", size: 12))
                                                        .foregroundStyle(.white)
                                                        .multilineTextAlignment(.center)
                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                }
                                                
                                                Button(action: {
                                                    if (viewModel.bet + 50) <= viewModel.coin {
                                                        viewModel.bet += 50
                                                    }
                                                }) {
                                                    Text("+")
                                                        .font(.custom("Chubby Rounded", size: 12))
                                                        .foregroundStyle(.white)
                                                        .multilineTextAlignment(.center)
                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                }
                                .frame(width: 197, height: 34)
                                .cornerRadius(20)
                            
                            HStack(spacing: 5) {
                                Button(action: {
                                    if viewModel.coin >= 5 {
                                        viewModel.bet = 5
                                    }
                                }) {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                            Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color(red: 226/255, green: 131/255, blue: 4/255), lineWidth: 5)
                                                .overlay {
                                                    Text("5$")
                                                        .font(.custom("Chubby Rounded", size: 7))
                                                        .foregroundStyle(.white)
                                                        .multilineTextAlignment(.center)
                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                }
                                        }
                                        .frame(width: 95, height: 28)
                                        .cornerRadius(20)
                                }
                                
                                Button(action: {
                                    if viewModel.coin >= 10 {
                                        viewModel.bet = 10
                                    }
                                }) {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                            Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color(red: 226/255, green: 131/255, blue: 4/255), lineWidth: 5)
                                                .overlay {
                                                    Text("10$")
                                                        .font(.custom("Chubby Rounded", size: 7))
                                                        .foregroundStyle(.white)
                                                        .multilineTextAlignment(.center)
                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                }
                                        }
                                        .frame(width: 95, height: 28)
                                        .cornerRadius(20)
                                }
                            }
                            
                            HStack(spacing: 5) {
                                Button(action: {
                                    if viewModel.coin >= 50 {
                                        viewModel.bet = 50
                                    }
                                }) {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                            Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color(red: 226/255, green: 131/255, blue: 4/255), lineWidth: 5)
                                                .overlay {
                                                    Text("50$")
                                                        .font(.custom("Chubby Rounded", size: 7))
                                                        .foregroundStyle(.white)
                                                        .multilineTextAlignment(.center)
                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                }
                                        }
                                        .frame(width: 95, height: 28)
                                        .cornerRadius(20)
                                }
                                
                                Button(action: {
                                    if viewModel.coin >= 100 {
                                        viewModel.bet = 100
                                    }
                                }) {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                            Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color(red: 226/255, green: 131/255, blue: 4/255), lineWidth: 5)
                                                .overlay {
                                                    Text("100$")
                                                        .font(.custom("Chubby Rounded", size: 7))
                                                        .foregroundStyle(.white)
                                                        .multilineTextAlignment(.center)
                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                }
                                        }
                                        .frame(width: 95, height: 28)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        
                        VStack {
                            Button(action: {
                                if viewModel.isMelting {
                                    viewModel.withdraw()
                                } else {
                                    if viewModel.bet <= viewModel.coin {
                                        viewModel.startGame()
                                    }
                                }
                            }) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                        Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(red: 226/255, green: 131/255, blue: 4/255), lineWidth: 5)
                                            .overlay {
                                                Text(viewModel.isMelting ? "WITHDRAW" : "START")
                                                    .font(.custom("Chubby Rounded", size: 9))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                            }
                                    }
                                    .frame(width: 170, height: 54)
                                    .cornerRadius(20)
                            }
                            
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                    Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 226/255, green: 131/255, blue: 4/255), lineWidth: 5)
                                        .overlay {
                                            Text("WIN: \(viewModel.win)")
                                                .font(.custom("Chubby Rounded", size: 9))
                                                .foregroundStyle(.white)
                                                .multilineTextAlignment(.center)
                                                .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                        }
                                }
                                .frame(width: 170, height: 54)
                                .cornerRadius(20)
                        }
                    }
                    
                    Color.clear.frame(height: 60)
                }
            }
            
            if viewModel.showResult {
                Image(viewModel.gameResult == .win ? "win" : "lose")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 160)
                    .scaleEffect(1.2)
                    .animation(.easeInOut(duration: 0.5).repeatCount(3), value: viewModel.showResult)
            }
        }
    }
}

#Preview {
    ChocolateMeltView()
}
