//
//  ContentView.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/6/6.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showStopWatchView = false
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                
                //                Color(red: 245/255, green: 245/255, blue: 245/255)
                
                
                LinearGradient(gradient: Gradient(colors: [Color(red: 220/255, green: 160/255, blue: 200/255), Color(red: 120/255, green: 180/255, blue: 220/255)]), startPoint: .top, endPoint: .bottom)
                
                VStack(spacing: 25){
                    
                    Button(action: {
                        self.showStopWatchView = true
                    }) {
                        ZStack{
                            
                            Rectangle()
                                .frame(width: 320, height: 280)
                                //                                .foregroundColor(Color(red: 245/255, green: 245/255, blue: 245/255))
                                .foregroundColor(.white)
                                .cornerRadius(25)
                                .shadow(radius: 5)
                            
                            VStack(spacing: 20){
                                Image(systemName: "stopwatch")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height: 160)
                                    .foregroundColor(Color.black)
                                
                                Text("開始計時")
                                    .font(.custom("jf-openhuninn-1.1", size: 30))
//                                    .font(.system(size: 30))
                                    .foregroundColor(Color.black)
                            }
                            
                        }
                        
                        
                    }
                    
                    HStack(spacing: 20){
                        
                        NavigationLink(destination: WordPictureView()) {
                            
                            
                            ZStack{
                                Rectangle()
                                    .frame(width: 150, height: 150)
                                    //                                    .foregroundColor(Color(red: 245/255, green: 245/255, blue: 245/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(25)
                                    .shadow(radius: 5)
                                
                                
                                VStack(spacing: 10){
                                    Image(systemName: "doc.text.magnifyingglass")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(Color.black)
                                    
                                    Text("目前累積")
                                        .font(.custom("jf-openhuninn-1.1", size: 25))
//                                        .font(.system(size: 25))
                                        .foregroundColor(Color.black)
                                }
                                
                            }
                            
                            
                        }
                        
                        NavigationLink(destination: HistoryInfo()) {
                            
                            ZStack{
                                Rectangle()
                                    .frame(width: 150, height: 150)
                                    //                                .foregroundColor(Color(red: 245/255, green: 245/255, blue: 245/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(25)
                                    .shadow(radius: 5)
                                
                                
                                VStack(spacing: 10){
                                    Image(systemName: "map")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(Color.black)
                                    
                                    Text("歷史紀錄")
                                        .font(.custom("jf-openhuninn-1.1", size: 25))
//                                        .font(.system(size: 25))
                                        .foregroundColor(Color.black)
                                }
                                
                            }
                        }
                    }
                    
                }
                .navigationBarTitle(Text("首頁"),   displayMode: .inline)
                .sheet(isPresented: $showStopWatchView) {
                    StopWatchView(showStopWatchView: self.$showStopWatchView)
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

