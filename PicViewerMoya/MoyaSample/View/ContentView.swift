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
        ScrollView {
            Image(data: viewModel.imageModel.rawImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("About")
                .font(.headline)
                .padding(.bottom)
            
            Group {
                Text("Created: \(viewModel.imageModel.info.created_at)")
                
                if let author = viewModel.imageModel.info.user?.name {
                    Text("Author: \(author)")
                }
                else {
                    Text("Author: ass")
                }
            }
            .font(.subheadline)
            
            
            Button {
                viewModel.requestImage()
            } label: {
                Text("REFRESH")
                    .font(.subheadline)
            }
            .frame(width: 100, height: 50, alignment: .center)
            .background(
                LinearGradient(gradient: Gradient(colors: [.red, .indigo]), startPoint: .topLeading, endPoint: .bottom)
                )
            .foregroundColor(Color.white)
            .cornerRadius(25)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
