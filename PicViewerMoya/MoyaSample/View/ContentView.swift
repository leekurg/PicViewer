//
//  ContentView.swift
//  MoyaSample
//
//  Created by Илья Аникин on 14.07.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Image(data: viewModel.imageModel.data)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(viewModel.infoModel.id)
                .fontWeight(.bold)
            Spacer()
            
            Button {
                viewModel.requestImage()
            } label: {
                Text("Refresh")
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
