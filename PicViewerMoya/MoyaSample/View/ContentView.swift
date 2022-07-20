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
            ScrollView {
                Image(data: viewModel.imageModel.rawImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Group {
                    HStack {
                        Text("About")
                            .font(.headline)
                        .padding(.bottom)
                        Spacer()
                    }
                
                    HStack {
                        Text("Created: \(viewModel.imageModel.info.created_at)")
                        Spacer()
                    }

                    HStack {
                        let author = viewModel.imageModel.info.user?.name ?? ""
                        Text("Author: \(author)")
                        Spacer()
                    }
                }
                .font(.subheadline)
                .padding(.leading, 10)
            }
//            ZStack {
                Button {
                    viewModel.requestImage()
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                    else {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                .frame(width: 50, height: 50, alignment: .center)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.red, .indigo]), startPoint: .topLeading, endPoint: .bottom)
                )
                .foregroundColor(Color.white)
                .cornerRadius(25)
                .padding(10)
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
