import SwiftUI

struct CandyBakeryView: View {
    @StateObject var viewModel =  CandyBakeryViewModel()
    @State var isPay = false
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Image("sweetSpinsbg")
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        HStack {
                            VStack(spacing: 10) {
                                Button(action: {
                                    NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Image(systemName: "arrow.left")
                                        .foregroundStyle(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                                                                 Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
                                }
                                
                                Button(action: {
                                    isPay.toggle()
                                }) {
                                    Image("info")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                }
                            }
                            
                            Color.clear.frame(width: 35)
                            
                            Spacer()
                            
                            Text("CANDY\nBAKERY")
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
                        
                        if !isPay {
                            VStack(spacing: -20) {
                                ZStack {
                                    Rectangle()
                                        .fill(LinearGradient(colors: [Color(red: 212/255, green: 157/255, blue: 112/255),
                                                                      Color(red: 205/255, green: 109/255, blue: 40/255)], startPoint: .top, endPoint: .bottom))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color(red: 243/255, green: 156/255, blue: 43/255), lineWidth: 5)
                                                .overlay {
                                                    VStack(spacing: 10) {
                                                        ForEach(0..<4, id: \.self) { row in
                                                            HStack(spacing: 7) {
                                                                ForEach(0..<5, id: \.self) { col in
                                                                    Image(viewModel.slots[row][col])
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: 45, height: 45)
                                                                        .padding(.horizontal, 5)
                                                                        .padding(.vertical, 8)
                                                                        .cornerRadius(10)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                        }
                                        .frame(width: 330, height: 308)
                                        .cornerRadius(20)
                                    
                                    HStack(spacing: 60) {
                                        ForEach(0..<4, id: \.self) { index in
                                            Rectangle()
                                                .fill(Color(red: 243/255, green: 156/255, blue: 43/255))
                                                .frame(width: 3, height: 308)
                                        }
                                    }
                                }
                                
                                Button(action: {
                                    if viewModel.coin >= viewModel.bet {
                                        viewModel.spin()
                                    }
                                }) {
                                    Image("spin")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 120, height: 90)
                                }
                                .disabled(viewModel.isSpinning)
                            }
                            
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 80/255, green: 0/255, blue: 253/255),
                                                          Color(red: 53/255, green: 1/255, blue: 82/255)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 226/255, green: 131/255, blue: 4/255), lineWidth: 5)
                                    .overlay {
                                        HStack(spacing: 30) {
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
                                            
                                            VStack(spacing: 5) {
                                                Text("SELECT BET")
                                                    .font(.custom("BAMEWPersonalUse", size: 16))
                                                    .foregroundStyle(.white)
                                                    .multilineTextAlignment(.center)
                                                    .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                
                                                ZStack(alignment: .leading) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                                                                                      Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .top, endPoint: .bottom))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 20)
                                                                .stroke(Color(red: 231/255, green: 148/255, blue: 38/255), lineWidth: 4)
                                                                .overlay {
                                                                    Text("\(viewModel.bet)")
                                                                        .font(.custom("Chubby Rounded", size: 7))
                                                                        .foregroundStyle(.white)
                                                                        .multilineTextAlignment(.center)
                                                                        .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                                                        .offset(x: 6)
                                                                }
                                                        }
                                                        .frame(width: 102, height: 24)
                                                        .cornerRadius(13)
                                                    
                                                    Image("coin")
                                                        .resizable()
                                                        .frame(width: 38, height: 38)
                                                        .offset(x: -10)
                                                }
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
                                    }
                            }
                            .frame(width: 330, height: 90)
                            .cornerRadius(20)
                        
                        Color.clear.frame(height: 60)
                    }  else {
                        Text("PAY TABLE")
                            .font(.custom("BAMEWPersonalUse", size: 35))
                            .foregroundStyle(LinearGradient(colors: [Color(red: 255/255, green: 128/255, blue: 246/255),
                                                                     Color(red: 129/255, green: 47/255, blue: 178/255)], startPoint: .leading, endPoint: .trailing))
                            .multilineTextAlignment(.center)
                            .outlineText(color: .white, width: 0.7)
                        
                        Image("paytab")
                            .resizable()
                            .overlay {
                                LazyVGrid(columns: [GridItem(.flexible(minimum: 80, maximum: 100)),
                                                    GridItem(.flexible(minimum: 80, maximum: 100)),
                                                    GridItem(.flexible(minimum: 80, maximum: 100))]) {
                                    
                                    ForEach(viewModel.symbolArray, id: \.id) { item in
                                        VStack {
                                            Image(item.image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 64, height: 64)
                                            
                                            Text("\(item.value)X")
                                                .font(.custom("Chubby Rounded", size: 10))
                                                .foregroundStyle(.white)
                                                .multilineTextAlignment(.center)
                                                .outlineText(color: Color(red: 231/255, green: 148/255, blue: 38/255), width: 0.5)
                                        }
                                    }
                                }
                            }
                            .frame(height: 302)
                    }
                }
            }
            
            if viewModel.win > 0 {
                Color.clear.ignoresSafeArea()
                
                Image("win")
                    .resizable()
                    .frame(width: 300, height: 160)
                    .onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            viewModel.win = 0
                        }
                    }
            }
        }
    }
}

#Preview {
    CandyBakeryView()
}

