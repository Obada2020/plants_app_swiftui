//
//  Home.swift
//  plants_app_swift
//
//  Created by Obada Alhalabi on 26/06/2024.
//

import SwiftUI
import Lottie

struct Home: View {
    @ObserveInjection var inject
    @State var currentIndex: Int = 0
    // details state
    @State var showDetailView: Bool = false
    @State var currentDetailPlant: Plant?
    @Namespace var animation
    //
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing:15) {
                HeaderView()
                SearchView()
                PlantsView()
//                CarouselSlider()
//                                .frame(height: 300)
                CustomCarousel(index: $currentIndex, items: plants, spacing: 25, cardPadding: 90, id: \.id){
                    plant,  size in PlantCardView(plant:plant ,Size: size )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            hideabBar()
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)){
                                currentDetailPlant = plant
                                showDetailView = true
                               
                            }
                        }
                }
                .frame(height: 380)
                .padding(.top, 20)
                .padding(.horizontal, 10)
            }
            .padding(15)
            .padding(.bottom, 50)
           
        }
        .overlay{
            if let currentDetailPlant,showDetailView{
                DetailView(showView: $showDetailView, animation: animation, plant: currentDetailPlant)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(x:0.1)))
            }
        }
        .enableInjection()
    }
    
    @ViewBuilder
    func PlantCardView(plant:Plant, Size:CGSize)-> some View{
        ZStack{
            LinearGradient(colors: [Color(.gray.opacity(0.3)), Color(.green.opacity(0.3))], startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            
            VStack{
                Button{
                    
                } label: {
                    Image("favorite")
                        .font(.title3)
                        .foregroundColor(Color(.green))
                        .frame(width: 50, height: 50)
                        .background{
                            RoundedRectangle(cornerRadius:12, style: .continuous)
                                .fill(.white)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .padding(15)
                
                Image(plant.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: plant.id, in: animation)
                    .padding(.bottom, -45)
                    .padding(.top, -40)
                    .zIndex(1)
                
                HStack{
                    VStack (alignment: .leading,spacing:7){
                        Text(plant.plantName)
                            .font(.callout)
                            .fontWeight(.bold)
                        
                        Text(plant.price)
                            .font(.title3)
                            .fontWeight(.black)
                    }
                    .lineLimit(1)
                    .frame(maxWidth: .infinity , alignment: .leading)
                    
                    Button{
                        
                    }label: {
                        Image("Cart")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height:22)
                            .foregroundColor(.white)
                            .frame(width: 45, height:45)
                            .background{
                                RoundedRectangle(cornerRadius: 12, style: .continuous).fill(.black)
                            }
                    }
                    
                }
                .padding([.horizontal, .top], 15)
                .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .background{
                        RoundedRectangle(cornerRadius:25, style: .continuous).fill(.white)
                    }
                    .padding(10)
                    
            }
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack{
            VStack(alignment: .leading, spacing: 8) {
                HStack{
                    Text("Welcome Swift UI")
                        .font(.title)
                    
                    LottieEmptyStateView(fileName: "fire")
                        .frame(width: 45, height: 45)
                        .clipped().padding(.bottom, 10)
                               
                }
                
                Text("Obada Alhalabi")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
            Button(action: {
                
            }, label: {
                Image(systemName: "bell")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(17)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                    }
                    .overlay(alignment:.topTrailing){
                        Text("1")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(6)
                            .background(){
                                Circle()
                                    .fill(Color(.green))
                            }
                            .offset(x:-5, y:-5)
                    }
                
            }).foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    func SearchView() -> some View {
        HStack{
            TextField("Search", text: .constant("") )
                .padding(10)
                .padding(.horizontal, 40)
                .foregroundColor(.white)
                .background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .foregroundColor(.gray.opacity(0.15))
                }
                .overlay(alignment:.leading){
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(10)
                }
            Button(action: {
                
            }, label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 7, style: .continuous)
                    }
            }).foregroundColor(.black)
        }
    }
    
    @ViewBuilder
    func PlantsView()->some View{
        VStack(alignment: .leading, spacing: 15){
            HStack(alignment: .center, spacing: 15){
                Image("grid")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15, height: 15)
                
                Text("Most Popular")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button("Show All"){
                    
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            .padding(.leading,5)
        }
        .padding(.top, 18)
    }
        
    
}

struct CarouselSlider: View {
    let images = ["plant1", "plant2", "plant3", "plant4"]

    var body: some View {
        TabView {
            ForEach(images, id: \.self) { imageName in
                ZStack{
                            LinearGradient(colors: [Color(.gray.opacity(0.3)), Color(.green.opacity(0.3))], startPoint: .topLeading, endPoint: .bottomTrailing)
                                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            
                            VStack{
                                Button{
                                    
                                } label: {
                                    Image("favorite")
                                        .font(.title3)
                                        .foregroundColor(Color(.green))
                                        .frame(width: 50, height: 50)
                                        .background{
                                            RoundedRectangle(cornerRadius:12, style: .continuous)
                                                .fill(.white)
                                        }
                                }
                                .frame(maxWidth: .infinity, alignment: .topTrailing)
                                .padding(15)
                                
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit
                                    )
                            }
                        }
                .padding(.horizontal, 20)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: UIScreen.main.bounds.height / 3)
    }
}


#Preview {
    MainView()
}
