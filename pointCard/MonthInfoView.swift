//
//  MonthInfoView.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/8/23.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI

struct MonthInfoView: View {
    
    @ObservedObject var monthInfo: MonthDataManager
    
    func monthCount(Y: String, M: String) -> Int {
        
        //        let MDY_split = MDY.split(separator: Character("/"))
        //
        //        let Y = String(MDY_split[0])
        //        let M = String(MDY_split[1])
        //        let D = String(MDY_split[2])
        
        var countResult = 0
        
        var key: String
        
        for i in 1...31{
            
            
            
            if Int(M)! > 9 {
                
                if i > 9{
                    key = Y + "/" + M + "/" + String(i)
                } else {
                    key = Y + "/" + M + "/0" + String(i)
                }
                
                
            } else {
                if i > 9{
                    key = Y + "/0" + M + "/" + String(i)
                } else {
                    key = Y + "/0" + M + "/0" + String(i)
                }
                
            }
            
//            print(key)
            countResult = countResult + UserDefaults.standard.integer(forKey: key)
        }
        
        return countResult
        
    }
    
    var body: some View {
        
        //        let screenH = UIScreen.main.bounds.height // 讀取螢幕高度
        let screenW = UIScreen.main.bounds.width // 讀取螢幕高度
        
        let totalMonthSec = monthCount(Y: monthInfo.year, M: monthInfo.month)
        
        let record_month_sec = totalMonthSec % 60
        let record_month_min = (totalMonthSec / 60) % 60
        let record_month_hour = totalMonthSec / 60 / 60
        
        return ZStack {
            
            Rectangle()
                .foregroundColor(Color(red: 240/255, green: 240/255, blue: 240/255))
                .frame(width: screenW - 10, height: 40)
            
            HStack(){
                
                Text("     \(monthInfo.month)月累積:")
                    .font(.custom("jf-openhuninn-1.1", size: 20))
                    .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))
                
                Spacer()
                
                Text("\(record_month_hour)時\(record_month_min)分\(record_month_sec)秒     ")
                    .font(.custom("jf-openhuninn-1.1", size: 20))
                    .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))
            }
            
        }
        
        
        
    }
}

//struct MonthInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        MonthInfoView()
//    }
//}
