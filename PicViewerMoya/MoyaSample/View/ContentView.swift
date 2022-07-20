//
//  ContentView.swift
//  MoyaSample
//
//  Created by Илья Аникин on 14.07.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var state = ViewState()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    VStack {
                        Image(data: state.imageModel.rawImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Group {
                            HStack {
                                Text("About")
                                    .font(.headline)
                                Spacer()
                                Button {
                                    state.like()
                                } label: {
                                    Image(systemName: state.isLiked ? "suit.heart.fill" : "suit.heart")
                                        .foregroundLinearGradient(
                                            colors: [.purple, .red],
                                            startPoint: .topLeading,
                                            endPoint: .bottom
                                        )
                                }
                                .frame(width: 30, height: 30)
                                .font(.system(size: 23))
                                .cornerRadius(15)
                                .padding(5)
                            }
                            .padding(.bottom)
                        
                            HStack {
                                Text("Created: \(state.imageModel.info.created_at)")
                                Spacer()
                            }

                            HStack {
                                let author = state.imageModel.info.user?.name ?? ""
                                Text("Author: \(author)")
                                Spacer()
                            }
                        }
                        .font(.subheadline)
                        .padding(.leading, 10)
                    }
                    .padding(.bottom, 70)
                }
                
                //footer panel
                VStack {
                    Spacer()
                    
                    Group {
                        Image(uiImage: UIImage())
                    }
                    .frame(width: geometry.size.width, height: 60)
                    .background(.ultraThinMaterial)
                }
                
                //button
                VStack {
                    Spacer()
                    
                    Button {
                        state.requestImage()
                    } label: {
                        if state.isLoading {
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
                    .padding(5)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
