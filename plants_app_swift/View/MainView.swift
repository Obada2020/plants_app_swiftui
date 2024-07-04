//
//  MainView.swift
//  plants_app_swift
//
//  Created by Obada Alhalabi on 24/06/2024.
//

import SwiftUI
@_exported import Inject

struct MainView: View {
    @ObserveInjection var inject
    
    @State var currentTab : Tab = .home
    @Namespace var animation
    init() {
        UITabBar.appearance().isHidden = true
    }
    @State var showTabbar: Bool = true
    var body: some View {
        
        ZStack(alignment: .bottom){
            TabView(selection:$currentTab){
                Home()
                    .setTabBarBackgroud(color: Color("BG"))
                    .tag(Tab.home)
                Text("Scan")
                    .setTabBarBackgroud(color: Color("BG"))
                    .tag(Tab.scan)
                Text("Fiels")
                    .setTabBarBackgroud(color: Color("BG"))
                    .tag(Tab.folder)
                Text("Cart")
                    .setTabBarBackgroud(color: Color("BG"))
                    .tag(Tab.cart)
            }
            
            TabBar()
                .offset(y: showTabbar ? 0 : 130)
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: showTabbar)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .onReceive(NotificationCenter.default.publisher(for: .init("SHOWTABBAR"))){
                    _ in
                    showTabbar = true
                }
                .onReceive(NotificationCenter.default.publisher(for: .init("HIDETABBAR"))){
                    _ in
                    showTabbar = false
                }
            
            .enableInjection()
        }
    }
    //
    @ViewBuilder
    func TabBar()-> some View{
        HStack(spacing:0){
            ForEach(Tab.allCases, id: \.rawValue){tab in
                Image(tab.rawValue)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24 , height: 24)
                    .foregroundColor(currentTab == tab ? .white : .gray.opacity(0.5))
                    .offset(y:currentTab == tab ? -30 : 0)
                    .background(
                        content: {
                            if currentTab == tab {
                                Circle()
                                    .fill(.black)
                                    .scaleEffect(2.5)
                                    .shadow(color:.black.opacity(0.3), radius: 8, x:5, y:10)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                    .offset(y:currentTab == tab ? -30 : 0)
                            }
                        }
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.top,15)
                    .padding(.bottom, 10)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        currentTab = tab
                    }
            }
        }
        .padding(.horizontal, 15)
        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.65, blendDuration: 0.65), value: currentTab)
        .background {
            CustomCorner(corners:[.topLeft , .topRight], radius:25)
                .fill(.gray.opacity(0.3))
            .ignoresSafeArea()
        
        }
    }
}

extension View{
    
    func showTabBar(){
        NotificationCenter.default.post(name:NSNotification.Name("SHOWTABBAR"), object: nil)
    }
    
    func hideabBar(){
        NotificationCenter.default.post(name:NSNotification.Name("HIDETABBAR"), object: nil)
    }
    
    @ViewBuilder
    func setTabBarBackgroud(color: Color)-> some View{
        self
            .frame(maxWidth:.infinity, maxHeight:.infinity)
            .background{color.ignoresSafeArea()}
    }
}



#Preview {
    MainView()
}
