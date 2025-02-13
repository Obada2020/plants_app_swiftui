//
//  DetailView.swift
//  plants_app_swift
//
//  Created by Obada Alhalabi on 28/06/2024.
//

import SwiftUI

struct DetailView: View {
    
    @Binding var showView: Bool
    var animation: Namespace.ID
    var plant: Plant
    @ObserveInjection var inject
    //
    @State var showContent: Bool = false
    //
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack(spacing: -30) {
                Image (plant.imageName)
                    .resizable ()
                    .aspectRatio (contentMode: . fit)
                    .matchedGeometryEffect(id: plant.id,in: animation)
                    .frame(width: size.width - 50, height: size.height / 1.6)
                    .zIndex(1)
                VStack(spacing: 20) {
                    
                    HStack {
                        Text(plant.plantName)
                            .font(.title)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        //
                        Text(plant.price)
                            .font(.title3.bold())
                            .padding(.horizontal,12)
                            .padding(.vertical,8)
                            .background{
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.green.opacity(0.1))
                            }
                    }
                    
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    
                    Button {
                        
                    } label: {
                        Text("Buy Now")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .overlay(alignment: .leading){
                                Image("Cart")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 26, height: 26)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background{
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(.black)
                            }
            
                    }
                    
                        
                }
                .padding(.top, 25)
                .padding(.bottom,15)
                .padding(15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(content:{
                    CustomCorner(corners: [.topLeft, .topRight], radius: 25)
                        .fill(.white)
                        .ignoresSafeArea()
                })
                .offset(y: showContent ? 0 : (size.height/1.5))
                .zIndex(0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment:.top){
                    HeaderView().opacity(showContent ? 1 : 0)
                }
                .background{
                    Rectangle()
                        .fill(Color(.green).gradient)
                        .ignoresSafeArea()
                        .opacity(showView ? 1 : 0)
                }
                .onAppear{
                    withAnimation(.easeInOut(duration: 0.35).delay((0.05))){
                        showContent = true
                    }
                }
                
                .enableInjection()
            }
        
    
    @ViewBuilder
    func HeaderView()->some View{
        Button {
            
            withAnimation(.easeInOut(duration: 0.3)){
                showContent = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                showTabBar()
                withAnimation(.easeInOut(duration: 0.35)){
                    showView = false
                }
            }
        } label: {
            Image("arrow-left")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding(15)
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

