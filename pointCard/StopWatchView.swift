//
//  StopWatchView.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/6/6.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI

struct StopWatchView: View {
    
    @State var startTime = UserDefaults.standard.value(forKey: "startTime") as? Date
    
    //    @State var startTime: Date?
    //    @State var isTrigger = false
    @State var components = DateComponents(hour: 0, minute: 0, second: 0)
    
    //    @State var initialTime = DateComponents(minute: 0, second: 0)
    @State var totalTime = DateComponents(hour: 0, minute: 0, second: 0)
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var resetStatus = true
    
    @State var totalTime_today = DateComponents(hour: 0, minute: 0, second: 0)
    
    @State var recordDate: String?
    
    //    @Binding var showStopWatchView: Bool
    
    func updateUI(value: Date) {
        
        let now = Date()
        
        let formatter = DateFormatter()

        formatter.timeZone = TimeZone.current

        formatter.dateFormat = "yyyy-MM-dd"

        let dateString = formatter.string(from: now)
        
        var recordDate = UserDefaults.standard.string(forKey: "recordDate")
        
        if recordDate == nil {
            
            recordDate = dateString
            
            UserDefaults.standard.set(recordDate, forKey: "recordDate")
            
            
        } else if recordDate != dateString {
            
            self.totalTime_today = self.totalTime
            
            tempTime_today = DateComponents(hour: 0, minute: 0, second: 0)
            
            UserDefaults.standard.set(tempTime_today.hour, forKey: "hour_temp")
            
            UserDefaults.standard.set(tempTime_today.minute, forKey: "min_temp")
            
            UserDefaults.standard.set(tempTime_today.second, forKey: "sec_temp")
            
            recordDate = dateString
            
            UserDefaults.standard.set(recordDate, forKey: "recordDate")
        }
        
        
        if let startTime = self.startTime {
            
            //print("value = \(value)")
            //            print("initialTime", initialTime)
            
            self.components = Calendar.current.dateComponents([.hour, .minute, .second], from: startTime, to: value)
            
            self.totalTime.second! = initialTime.second! + self.components.second!
            
            self.totalTime.minute! = initialTime.minute! + self.components.minute!
            
            self.totalTime.hour! = initialTime.hour! + self.components.hour!
            
            if self.totalTime.second! >= 60 {
                self.totalTime.second! = self.totalTime.second! % 60
                self.totalTime.minute! = self.totalTime.minute! + 1
            }
            
            if self.totalTime.minute! >= 60 {
                self.totalTime.minute! = self.totalTime.minute! % 60
                self.totalTime.hour! = self.totalTime.hour! + 1
            }
            //            print("updaet totalTime", self.totalTime)
            
            
            self.totalTime_today.second = tempTime_today.second! + self.totalTime.second!
            
            self.totalTime_today.minute = tempTime_today.minute! + self.totalTime.minute!
            
            self.totalTime_today.hour = tempTime_today.hour! + self.totalTime.hour!
            
            if self.totalTime_today.second! >= 60 {
                self.totalTime_today.second! = self.totalTime_today.second! % 60
                self.totalTime_today.minute! = self.totalTime_today.minute! + 1
            }
            
            if self.totalTime_today.minute! >= 60 {
                self.totalTime_today.minute! = self.totalTime_today.minute! % 60
                self.totalTime_today.hour! = self.totalTime_today.hour! + 1
            }
            
            
        } else {
            
            self.totalTime = initialTime
            
            self.totalTime_today.second! = tempTime_today.second! + self.totalTime.second!
            
            self.totalTime_today.minute! = tempTime_today.minute! + self.totalTime.minute!
            
            self.totalTime_today.hour! = tempTime_today.hour! + self.totalTime.hour!
            
            if self.totalTime_today.second! >= 60 {
                self.totalTime_today.second! = self.totalTime_today.second! % 60
                self.totalTime_today.minute! = self.totalTime_today.minute! + 1
            }
            
            if self.totalTime_today.minute! >= 60 {
                self.totalTime_today.minute! = self.totalTime_today.minute! % 60
                self.totalTime_today.hour! = self.totalTime_today.hour! + 1
            }

        }
    }
    
    var body: some View {
        //        print("totalTime", totalTime)
        
        NavigationView{
            
            ZStack{
                
                Color(red: 52/255, green: 84/255, blue: 100/255)
                //                .overlay(Button(action: {
                //
                //                    self.showStopWatchView = false
                //
                //                }) {
                //
                //                    Image(systemName: "xmark.circle")
                //                        .resizable()
                //                        .foregroundColor(Color(red: 220/255, green: 220/255, blue: 220/255))
                //                        .frame(width: 30, height: 30)
                //                        .padding()
                //
                //                }, alignment: .topTrailing)
                
                
                VStack(spacing: 50){
                    
                    
                    ZStack{
                        
                        VStack(spacing: 20){
                            
                            HStack{
                                Text("今日累積:")
                                    .font(.custom("jf-openhuninn-1.1", size: 20))
                                    .foregroundColor(Color(red: 210/255, green: 210/255, blue: 210/255))
                                
                                Text((totalTime_today.hour ?? 0) < 10 ? "0\(totalTime_today.hour!):" : "\(totalTime_today.hour!):")
                                    .font(.custom("jf-openhuninn-1.1", size: 20))
                                    .foregroundColor(Color(red: 210/255, green: 210/255, blue: 210/255)) +
                                    
                                    Text((totalTime_today.minute ?? 0) < 10 ? "0\(totalTime_today.minute!):" : "\(totalTime_today.minute!):")
                                        .font(.custom("jf-openhuninn-1.1", size: 20))
                                        .foregroundColor(Color(red: 210/255, green: 210/255, blue: 210/255)) +
                                    
                                    Text((totalTime_today.second ?? 0) < 10 ? "0\(totalTime_today.second!)" : "\(totalTime_today.second!)")
                                        .font(.custom("jf-openhuninn-1.1", size: 20))
                                        .foregroundColor(Color(red: 210/255, green: 210/255, blue: 210/255))
                                
                            }
                            
                            
                            {Text((totalTime.hour ?? 0) < 10 ? "0\(totalTime.hour!)" : "\(totalTime.hour!)") + Text(":") + Text((totalTime.minute ?? 0) < 10 ? "0\(totalTime.minute!)" : "\(totalTime.minute!)") + Text(":") + Text((totalTime.second ?? 0) < 10 ? "0\(totalTime.second!)" : "\(totalTime.second!)")}()
                                .foregroundColor(.white)
                                //  .font(.system(size: 65))
                                .font(.custom("jf-openhuninn-1.1", size: 55))
                        }
                        
                        Circle()
                            .stroke(lineWidth: 8)
                            .frame(width: 290, height: 290)
                            .foregroundColor(Color(red: 150/255, green: 150/255, blue: 150/255))
                        
                        
                    }
                    
                    
                    HStack(spacing: 35){
                        
                        Button(action: {
                            
                            initialTime = DateComponents(hour: 0, minute: 0, second: 0)
                            self.totalTime = DateComponents(hour: 0, minute: 0, second: 0)
                            
                            self.totalTime_today = tempTime_today
                            
                            UserDefaults.standard.set(initialTime.hour, forKey: "hour_ini")
                            
                            UserDefaults.standard.set(initialTime.minute, forKey: "min_ini")
                            
                            UserDefaults.standard.set(initialTime.second, forKey: "sec_ini")
                            
                            self.resetStatus = true
                            
                        }){
                            
                            
                            Circle()
                                .fill(resetStatus == true ? Color.gray : Color.green)
                                .overlay(
                                    
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.white)
                                        .padding(4)
                                    
                            )
                                .overlay(
                                    Text("重置")
                                        .font(.custom("jf-openhuninn-1.1", size: 16))
                                        .foregroundColor(.white)
                                    
                            )
                                .frame(width: 70, height: 70)
                            
                            
                        }
                        .disabled(resetStatus)
                        
                        Button(action: {
                            
                            //                        self.isTrigger.toggle()
                            
                            if self.startTime == nil {
                                
                                self.startTime = Date()
                                
                                UserDefaults.standard.set(self.startTime, forKey: "startTime")
                                
                                //                            print(self.startTime!)
                                
                                if self.resetStatus == false {
                                    self.resetStatus = true
                                }
                                
                            } else {
                                
                                UserDefaults.standard.set(systemTime.hour, forKey: "hour_sys")
                                
                                UserDefaults.standard.set(systemTime.minute, forKey: "min_sys")
                                
                                UserDefaults.standard.set(systemTime.second, forKey: "sec_sys")
                                
                                self.startTime = nil
                                UserDefaults.standard.removeObject(forKey: "startTime")
                                
                                initialTime = self.totalTime
                                
                                UserDefaults.standard.set(initialTime.hour, forKey: "hour_ini")
                                
                                UserDefaults.standard.set(initialTime.minute, forKey: "min_ini")
                                
                                UserDefaults.standard.set(initialTime.second, forKey: "sec_ini")
                                
                                self.resetStatus = false
                                
                            }
                            
                        }){
                            
                            
                            Circle()
                                .fill(startTime != nil ? Color.red : Color.green)
                                .overlay(
                                    
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.white)
                                        .padding(4)
                                    
                            )
                                .overlay(
                                    Text(startTime != nil ? "停止" : "開始")
                                        .font(.custom("jf-openhuninn-1.1", size: 20))
                                        .foregroundColor(.white)
                                    
                            )
                                .frame(width: 90, height: 90)
                            
                            
                        }
                        
                        Button(action: {
                            
                            let totalTime_today_sec = (self.totalTime.hour! + tempTime_today.hour!) * 3600 + (self.totalTime.minute! + tempTime_today.minute!) * 60 + (self.totalTime.second! + tempTime_today.second!)
                            
                            let now = Date()
                            
                            let formatter = DateFormatter()

                            formatter.timeZone = TimeZone.current

//                            formatter.dateStyle = .short
                            formatter.dateFormat = "yyyy/MM/dd"

                            let dateString = formatter.string(from: now)
                            
//                            print(dateString)
                            
                            UserDefaults.standard.set(totalTime_today_sec, forKey: dateString)
                            
                            systemTime.hour = self.totalTime.hour! + systemTime.hour!
                            systemTime.minute = self.totalTime.minute! + systemTime.minute!
                            systemTime.second = self.totalTime.second! + systemTime.second!
                            
                            if systemTime.second! >= 60 {
                                systemTime.second! = systemTime.second! % 60
                                systemTime.minute! = systemTime.minute! + 1
                            }
                            
                            if systemTime.minute! >= 60 {
                                systemTime.minute! = systemTime.minute! % 60
                                systemTime.hour! = systemTime.hour! + 1
                            }
                            
                            UserDefaults.standard.set(systemTime.hour, forKey: "hour_sys")
                            
                            UserDefaults.standard.set(systemTime.minute, forKey: "min_sys")
                            
                            UserDefaults.standard.set(systemTime.second, forKey: "sec_sys")
                            
                            //                        print(systemTime)
                            
                            
                            tempTime_today.second! = tempTime_today.second! + self.totalTime.second!
                            
                            tempTime_today.minute! = tempTime_today.minute! + self.totalTime.minute!
                            
                            tempTime_today.hour! = tempTime_today.hour! + self.totalTime.hour!
                            
                            if tempTime_today.second! >= 60 {
                                tempTime_today.second! = tempTime_today.second! % 60
                                tempTime_today.minute! = tempTime_today.minute! + 1
                            }
                            
                            if tempTime_today.minute! >= 60 {
                                tempTime_today.minute! = tempTime_today.minute! % 60
                                tempTime_today.hour! = tempTime_today.hour! + 1
                            }
                            
                            UserDefaults.standard.set(tempTime_today.hour, forKey: "hour_temp")
                            
                            UserDefaults.standard.set(tempTime_today.minute, forKey: "min_temp")
                            
                            UserDefaults.standard.set(tempTime_today.second, forKey: "sec_temp")
                            
                            initialTime = DateComponents(hour: 0, minute: 0, second: 0)
                            self.totalTime = DateComponents(hour: 0, minute: 0, second: 0)
                            
                            UserDefaults.standard.set(initialTime.hour, forKey: "hour_ini")
                            
                            UserDefaults.standard.set(initialTime.minute, forKey: "min_ini")
                            
                            UserDefaults.standard.set(initialTime.second, forKey: "sec_ini")
                            
                            self.resetStatus = true
                            
                        }){
                            
                            
                            Circle()
                                .fill(resetStatus == true ? Color.gray : Color.green)
                                .overlay(
                                    
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(.white)
                                        .padding(4)
                                    
                            )
                                .overlay(
                                    Text("儲存")
                                        .font(.custom("jf-openhuninn-1.1", size: 16))
                                        .foregroundColor(.white)
                                    
                            )
                                .frame(width: 70, height: 70)
                            
                            
                        }
                        .disabled(resetStatus)
                        
                    }
                    
                }
                .onReceive(timer) { (value) in
                    self.updateUI(value: value)
                }
                .onAppear{
                    
                    //                print("appear")
                    
                    //                self.totalTime = initialTime
                    
                    self.updateUI(value: Date())
                    
                    self.timer = Timer.publish (every: 1, on: .main, in: .common).autoconnect()
                    
                    if ((initialTime.second != 0) || (initialTime.minute != 0) || (initialTime.hour != 0)) && self.startTime == nil {
                        self.resetStatus = false
                    }
                     
                }
                .onDisappear {
                    
                    self.timer.upstream.connect().cancel()
                    
                    //            print("disappear")
                    
                    //            initialTime = self.totalTime
                    //
                    //            UserDefaults.standard.set(initialTime.hour, forKey: "hour_ini")
                    //
                    //            UserDefaults.standard.set(initialTime.minute, forKey: "min_ini")
                    //
                    //            UserDefaults.standard.set(initialTime.second, forKey: "sec_ini")
                }
                
            } // ZStack
                .navigationBarTitle(Text("計時器"), displayMode: .inline)
            
        } // NavigationView
        
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}
