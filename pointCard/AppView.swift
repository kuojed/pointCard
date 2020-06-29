//
//  AppView.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/6/28.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        
        TabView{
            
            
            StopWatchView()
                .tabItem{
                    Image(systemName: "stopwatch")
                    Text("開始唱題")
            }
            
            WordPictureView()
                .tabItem{
                    Image(systemName: "doc.text.magnifyingglass")
                    Text("目前累積")
            }
            
            HistoryInfo()
                .tabItem{
                    Image(systemName: "map")
                    Text("歷史紀錄")
            }
            
            
        }
        
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
