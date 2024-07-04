//
//  ContentView.swift
//  plants_app_swift
//
//  Created by Obada Alhalabi on 24/06/2024.
//

import SwiftUI

import Inject

struct ContentView: View {
    @ObserveInjection var inject
    var body: some View {
        MainView()
        .enableInjection()
    }
    
}

#Preview {
    ContentView()
}
