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
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var resetStatus = true
    
    @Binding var showStopWatchView: Bool
    
    func updateUI(value: Date) {
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
            
        } else {
            
            totalTime = initialTime
            
        }
    }
    
    var body: some View {
//        print("totalTime", totalTime)
        
        return ZStack{
            
            Color(red: 52/255, green: 84/255, blue: 100/255)
                .overlay(Button(action: {
                    
                    self.showStopWatchView = false
                    
                }) {
                    
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .foregroundColor(Color(red: 220/255, green: 220/255, blue: 220/255))
                        .frame(width: 30, height: 30)
                        .padding()
                    
                }, alignment: .topTrailing)
            
            
            VStack(spacing: 80){
                
                {Text((totalTime.hour ?? 0) < 10 ? "0\(totalTime.hour!)" : "\(totalTime.hour!)") + Text(":") + Text((totalTime.minute ?? 0) < 10 ? "0\(totalTime.minute!)" : "\(totalTime.minute!)") + Text(":") + Text((totalTime.second ?? 0) < 10 ? "0\(totalTime.second!)" : "\(totalTime.second!)")}()
                    .foregroundColor(.white)
                    //  .font(.system(size: 65))
                    .font(.custom("jf-openhuninn-1.1", size: 65))
            
                
                HStack(spacing: 35){
                    
                    Button(action: {
                        
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
                
                if ((initialTime.second != 0) || (initialTime.minute != 0) || (initialTime.hour != 0)) && self.startTime == nil {
                    self.resetStatus = false
                }
                
                
            }
            
        }
        .onDisappear {
            
            //            print("disappear")
            
            //            initialTime = self.totalTime
            //
            //            UserDefaults.standard.set(initialTime.hour, forKey: "hour_ini")
            //
            //            UserDefaults.standard.set(initialTime.minute, forKey: "min_ini")
            //
            //            UserDefaults.standard.set(initialTime.second, forKey: "sec_ini")
        }
        
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView(showStopWatchView: .constant(true))
    }
}
