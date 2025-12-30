import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: CustomTabBar.TabType = .Menu
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Menu {
                    MenuView(selectedTab: $selectedTab)
                } else if selectedTab == .Slots {
                    SlotsView()
                } else if selectedTab == .Crash {
                    CrashesView()
                } else if selectedTab == .Profile {
                    ProfileView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Menu
        case Slots
        case Crash
        case Profile
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
     
            
            HStack(alignment: .top, spacing: -10) {
                TabBarItem(imageName: "tab", tab: .Menu, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab", tab: .Slots, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab", tab: .Crash, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab", tab: .Profile, selectedTab: $selectedTab)
            }
            .padding(.top, 10)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: -10) {
                Image(selectedTab == tab ? imageName + "Picked" : imageName)
                    .resizable()
                    .overlay {
                        Text("\(tab)".uppercased())
                            .font(.custom("BAMEWPersonalUse", size: 16))
                            
                            .foregroundStyle(.white)
                    }
//                    .aspectRatio(contentMode: .fit)
                    .frame(width: 82, height: tab == .Slots ? 95 : tab == .Crash ? 95 : 80)
                
                
            }
            .frame(maxWidth: .infinity)
            .offset(y: -5)
        }
    }
}
