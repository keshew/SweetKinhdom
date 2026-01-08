import SwiftUI

struct LoadingView: View {
    @State private var progress: Double = 0.0
    @State private var displayedProgress: Double = 0.0
    @State private var isLoadingComplete = false
    
    private let totalDuration: Double = 3.5
    
    var body: some View {
        ZStack {
            Image("loadingbg")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("SWEET\nKINGDOM")
                    .font(.custom("BAMEWPersonalUse", size: 50))
                    .foregroundStyle(LinearGradient(colors: [Color(red: 255/255, green: 2/255, blue: 216/255),
                        Color(red: 255/255, green: 0/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
                    .multilineTextAlignment(.center)
                    .outlineText(color: .white, width: 0.7)
                    .scaleEffect(isLoadingComplete ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.5), value: isLoadingComplete)
                
                Spacer()
                
                VStack(spacing: 15) {
                    Text("Loading...")
                        .font(.custom("Chubby Rounded", size: 10))
                        .foregroundStyle(LinearGradient(colors: [Color(red: 254/255, green: 219/255, blue: 180/255)], startPoint: .leading, endPoint: .trailing))
                        .multilineTextAlignment(.center)
                        .outlineText(color: .white, width: 0.5)
                        .opacity(isLoadingComplete ? 0 : 1)
                        .animation(.easeInOut(duration: 0.3), value: isLoadingComplete)
                    
                    ZStack(alignment: .leading) {
                        GeometryReader { geometry in
                            Rectangle()
                                .fill(Color(red: 255/255, green: 2/255, blue: 217/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.white.opacity(0.5), lineWidth: 2)
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                        .frame(width: 300, height: 15)
                        
                        GeometryReader { geometry in
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color(red: 3/255, green: 139/255, blue: 253/255)
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.white, lineWidth: 2)
                                }
                                .frame(width: geometry.size.width * displayedProgress, height: geometry.size.height)
                                .cornerRadius(20)
                        }
                        .frame(width: 300, height: 15)
                    }
                    .cornerRadius(20)
                    
                    Text("\(Int(displayedProgress * 100))%")
                        .font(.custom("Chubby Rounded", size: 10))
                        .foregroundStyle(LinearGradient(colors: [Color(red: 254/255, green: 219/255, blue: 180/255)], startPoint: .leading, endPoint: .trailing))
                        .multilineTextAlignment(.center)
                        .outlineText(color: .white, width: 0.5)
                        .scaleEffect(isLoadingComplete ? 1.2 : 1.0)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isLoadingComplete)
                }
                .padding(.bottom)
            }
        }
        .fullScreenCover(isPresented: $isLoadingComplete) {
            TabBarView()
        }
        .onAppear {
            startLoadingAnimation()
        }
    }
    
    private func startLoadingAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            progress += 0.01
            displayedProgress = min(progress, 1.0)
            
            if progress >= 1.0 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isLoadingComplete = true
                    }
                }
            }
        }
    }
}

#Preview {
    LoadingView()
}


extension View {
    func outlineText(color: Color, width: CGFloat) -> some View {
        modifier(StrokeModifier(strokeSize: width, strokeColor: color))
    }
}

struct StrokeModifier: ViewModifier {
    private let id = UUID()
    var strokeSize: CGFloat = 1
    var strokeColor: Color = .blue
    
    func body(content: Content) -> some View {
        content
            .padding(strokeSize*2)
            .background (Rectangle()
                .foregroundStyle(strokeColor)
                .mask({
                    outline(context: content)
                })
            )}
    
    func outline(context:Content) -> some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.01))
            context.drawLayer { layer in
                if let text = context.resolveSymbol(id: id) {
                    layer.draw(text, at: .init(x: size.width/2, y: size.height/2))
                }
            }
        } symbols: {
            context.tag(id)
                .blur(radius: strokeSize)
        }
    }
}
