//
//  CardRow.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/6/6.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI

struct CardRow: View {
    
    let data: HistoryData
    let screenH = UIScreen.main.bounds.height // 讀取螢幕高度
    
    var body: some View {
        
        ZStack{
            
            Rectangle()
                .foregroundColor(.white)
                .frame(width: screenH > 800 ? 360 : 330, height: screenH > 800 ? 210 : 200)
                .cornerRadius(25)
            
            HStack(alignment: .center, spacing: 40){
                
                ZStack{
                    
                    Rectangle()
                        .fill(colorType[data.cardColor]!)
                        .frame(width: screenH > 800 ? 120 : 110, height: screenH > 800 ? 190 : 180)
                    
                    VStack(spacing: 15){
                        Text(data.word[0])
                            .foregroundColor(data.endTime != nil ? .blue : .white)
                            .font(.custom("jf-openhuninn-1.1", size: screenH > 800 ? 65 : 60))

                        Text(data.word[1])
                            .foregroundColor(data.endTime != nil ? .blue : .white)
                            .font(.custom("jf-openhuninn-1.1", size: screenH > 800 ? 65 : 60))
                    }
                }
                
                VStack(alignment: .center, spacing: 15){
                    
                    Text("開始")
                        .font(.custom("jf-openhuninn-1.1", size: 30))
                    
                    Text("\(data.startTime[0])/ \(data.startTime[1])/ \(data.startTime[2])")
                        .font(.custom("jf-openhuninn-1.1", size: 20))
                    
                    Text("完成")
                        .font(.custom("jf-openhuninn-1.1", size: 30))
                    
                    if data.endTime != nil{
                        
                        Text("\(data.endTime![0])/ \(data.endTime![1])/ \(data.endTime![2])")
                            .font(.custom("jf-openhuninn-1.1", size: 20))
                    } else {
                        Text("尚未完成")
                            .font(.custom("jf-openhuninn-1.1", size: 20))
                            .foregroundColor(.red)
                    }
                    
                    
                }
                
            }
        }
        .overlay(Text(data.num).offset(x: screenH > 800 ? 15 : 10, y: 0).font(.system(size: 20)), alignment: .leading)
        
        
        
        
    }
}

//struct CardRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CardRow(data: historydata[0])
//    }
//}
