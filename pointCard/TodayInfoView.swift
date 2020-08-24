//
//  TodayInfoView.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/8/9.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI

struct TodayInfoView: View {
    
    let searchKey: String
    let screenH = UIScreen.main.bounds.height // 讀取螢幕高度
    
    var body: some View {
        
        //        print(searchKey)
        
        let totalSec = UserDefaults.standard.integer(forKey: searchKey)
        
        let record_sec = totalSec % 60
        let record_min = (totalSec / 60) % 60
        let record_hour = totalSec / 60 / 60
        
        return HStack{
            //            RoundedRectangle(cornerRadius: 8)
            //                .fill(Color.lightBlue)
            //                .frame(width: 5, height: 30)
            
            Circle()
                .fill(Color(red: 66/255, green: 62/255, blue: 141/255))
                .frame(width: 10, height: 10)
            
            
            Text("當日累積: ")
                .font(.custom("jf-openhuninn-1.1", size: 20))
                .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))
                
                + Text("\(record_hour)時")
                    .font(.custom("jf-openhuninn-1.1", size: 20))
                    .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))
                
                + Text("\(record_min)分")
                    .font(.custom("jf-openhuninn-1.1", size: 20))
                    .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))
                
                + Text("\(record_sec)秒")
                    .font(.custom("jf-openhuninn-1.1", size: 20))
                    .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))
            
            Spacer()
            
            if totalSec == 0 {
                
                Image("pig_empty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 52, height: 52)
                    .offset(x: -30, y: 0)
                
            } else {
                
                Image("economy")
                .resizable()
                .scaledToFit()
                .frame(width: 52, height: 52)
                .offset(x: -30, y: 0)
                
            }
            
            
            
        }
        
        
        //        return VStack{
        //            HStack{
        //                RoundedRectangle(cornerRadius: 8)
        //                    .fill(Color.lightBlue)
        //                    .frame(width: 5, height: 30)
        //
        //                Text("當日累積: ")
        //                    .font(.custom("jf-openhuninn-1.1", size: 20))
        //
        //                    + Text(record_hour < 10 ? "0\(record_hour):" : "\(record_hour):")
        //                        .font(.custom("jf-openhuninn-1.1", size: 20))
        //
        //                    + Text(record_min < 10 ? "0\(record_min):" : "\(record_min):")
        //                        .font(.custom("jf-openhuninn-1.1", size: 20))
        //
        //                    + Text(record_sec < 10 ? "0\(record_sec)" : "\(record_sec)")
        //                        .font(.custom("jf-openhuninn-1.1", size: 20))
        //
        //                Spacer()
        //
        //            }
        //
        //            HStack{
        //                RoundedRectangle(cornerRadius: 8)
        //                    .fill(Color.darkPink)
        //                    .frame(width: 5, height: 30)
        //
        //                Text("當月累積: ")
        //                    .font(.custom("jf-openhuninn-1.1", size: 20))
        //
        //                    + Text(record_month_hour < 10 ? "0\(record_month_hour):" : "\(record_month_hour):")
        //                        .font(.custom("jf-openhuninn-1.1", size: 20))
        //
        //                    + Text(record_month_min < 10 ? "0\(record_month_min):" : "\(record_month_min):")
        //                        .font(.custom("jf-openhuninn-1.1", size: 20))
        //
        //                    + Text(record_month_sec < 10 ? "0\(record_month_sec)" : "\(record_month_sec)")
        //                        .font(.custom("jf-openhuninn-1.1", size: 20))
        //
        //                Spacer()
        //
        //            }
        //
        //        }
        
    }
}

//struct TodayInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodayInfoView()
//    }
//}

private extension Color {
    
    static let turquoise = Color(red: 24/255, green: 147/255, blue: 120/255)
    static let forestGreen = Color(red: 22/255, green: 128/255, blue: 83/255)
    static let darkPink = Color(red: 179/255, green: 102/255, blue: 159/255)
    static let darkRed = Color(red: 185/255, green: 22/255, blue: 77/255)
    static let lightBlue = Color(red: 72/255, green: 147/255, blue: 175/255)
    static let salmon = Color(red: 219/255, green: 135/255, blue: 41/255)
    static let military = Color(red: 117/255, green: 142/255, blue: 41/255)
    
}
