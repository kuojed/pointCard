//
//  NewPageView.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/6/6.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI

struct NewPageView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var showNewPageView: Bool
    
    @State var chooseStatus1 = false
    @State var chooseStatus2 = false
    @State var chooseStatus3 = false
    @State var chooseStatus4 = false
    
    @State var randomWordSquence = [Int](0...4).shuffled()
    @State var randomColorSquence = ["紅", "黃", "綠", "藍", "紫"].shuffled()
    
    var choosable = true
    @State var checkOn = false
    
    @Binding var ButtonStatus: Bool
    
    var body: some View {
        
        ZStack{
            
            Color(red: 250/255, green: 250/255, blue: 250/255)
            
            VStack(spacing: 30) {
                HStack(spacing: 30) {
                    NewCardView(word: wordType[randomWordSquence[0]], backgroundColor: colorType[randomColorSquence[0]]!, chooseStatus: chooseStatus1)
                        .onTapGesture{
                            
                            self.chooseStatus1.toggle()
                            self.chooseStatus2 = false
                            self.chooseStatus3 = false
                            self.chooseStatus4 = false
                            
                            self.checkOn = (self.chooseStatus1 || self.chooseStatus2) || (self.chooseStatus3 || self.chooseStatus4)
                    }
                    
                    
                    NewCardView(word: wordType[randomWordSquence[1]], backgroundColor: colorType[randomColorSquence[1]]!, chooseStatus: chooseStatus2)
                        .onTapGesture{
                            self.chooseStatus2.toggle()
                            self.chooseStatus1 = false
                            self.chooseStatus3 = false
                            self.chooseStatus4 = false
                            
                            self.checkOn = (self.chooseStatus1 || self.chooseStatus2) || (self.chooseStatus3 || self.chooseStatus4)
                    }
                    
                }
                HStack(spacing: 30) {
                    NewCardView(word: wordType[randomWordSquence[2]], backgroundColor: colorType[randomColorSquence[2]]!, chooseStatus: chooseStatus3)
                        .onTapGesture{
                            self.chooseStatus3.toggle()
                            self.chooseStatus1 = false
                            self.chooseStatus2 = false
                            self.chooseStatus4 = false
                            
                            self.checkOn = (self.chooseStatus1 || self.chooseStatus2) || (self.chooseStatus3 || self.chooseStatus4)
                    }
                    
                    NewCardView(word: wordType[randomWordSquence[3]], backgroundColor: colorType[randomColorSquence[3]]!, chooseStatus: chooseStatus4)
                        .onTapGesture{
                            self.chooseStatus4.toggle()
                            self.chooseStatus1 = false
                            self.chooseStatus2 = false
                            self.chooseStatus3 = false
                            
                            self.checkOn = (self.chooseStatus1 || self.chooseStatus2) || (self.chooseStatus3 || self.chooseStatus4)
                    }
                    
                }
                
                HStack(spacing: 90){
                    
                    Button(action: {
                        
                        self.randomWordSquence.shuffle()
                        self.randomColorSquence.shuffle()
                        
                        self.chooseStatus1 = false
                        self.chooseStatus2 = false
                        self.chooseStatus3 = false
                        self.chooseStatus4 = false
                        
                    }) {
                        
                        VStack{
                            ZStack{
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color(red: 230/255, green: 230/255, blue: 230/255))
                                
                                Image(systemName: "arrow.clockwise")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                            }
                            
                            
                            
                            
                            Text("重新產生")
                                .foregroundColor(.black)
//                                .font(.system(size: 20))
                            .font(.custom("jf-openhuninn-1.1", size: 20))
                            
                        }
                        
                        
                    }
                    
                    Button(action: {
                        
                        if self.chooseStatus1 == true {
//                            print(wordType[self.randomWordSquence[0]])
//                            print(self.randomColorSquence[0])
                            
                            userCardColor = self.randomColorSquence[0]
                            userCardWord = wordType[self.randomWordSquence[0]]
                            
                        }
                        
                        if self.chooseStatus2 == true {
//                            print(wordType[self.randomWordSquence[1]])
//                            print(self.randomColorSquence[1])
                            
                            userCardColor = self.randomColorSquence[1]
                            userCardWord = wordType[self.randomWordSquence[1]]
                            
                        }
                        
                        if self.chooseStatus3 == true {
//                            print(wordType[self.randomWordSquence[2]])
//                            print(self.randomColorSquence[2])
                            
                            userCardColor = self.randomColorSquence[2]
                            userCardWord = wordType[self.randomWordSquence[2]]
                            
                        }
                        
                        if self.chooseStatus4 == true {
//                            print(wordType[self.randomWordSquence[3]])
//                            print(self.randomColorSquence[3])
                            
                            userCardColor = self.randomColorSquence[3]
                            userCardWord = wordType[self.randomWordSquence[3]]
                            
                        }
                        
                        systemTime = DateComponents(hour: 0, minute: 0, second: 0)
                        
                        systemTime.second = residualTime_second
                        systemTime.minute = residualTime_minute
                        systemTime.hour = residualTime_hour
                        
                        
//                        print("下次開始小時\(systemTime.hour!)")
//                        print("下次開始分鐘\(systemTime.minute!)")
//                        print("下次開始秒\(systemTime.second!)")
                        
                        UserDefaults.standard.set(systemTime.hour, forKey: "hour_sys")
                        UserDefaults.standard.set(systemTime.minute, forKey: "min_sys")
                        UserDefaults.standard.set(systemTime.second, forKey: "sec_sys")
                                               
                        self.showNewPageView = false
                        
                        self.ButtonStatus = true
                        
                        let now = Date()
                        
                        let formatter = DateFormatter()

                        formatter.timeZone = TimeZone.current

                        formatter.dateFormat = "yyyy-MM-dd-HH-mm"

                        let dateString = formatter.string(from: now)

                        let dateString_split = dateString.split(separator: Character("-"))
                        
                        let finishTimeYear = String(dateString_split[0])
                        let finishTimeMonth = String(dateString_split[1])
                        let finishTimelDay = String(dateString_split[2])
                        
                        
//                        let finishTime = Calendar.current.dateComponents([.year, .month, .day], from: Date())
//
//                        let finishTimeYear = String(finishTime.year!)
//                        let finishTimeMonth = String(finishTime.month!)
//                        let finishTimelDay = String(finishTime.day!)
                        
                        let cardCount = historydata.count
                        
//                        print(cardCount)
                        
                        historydata[0].endTime = [finishTimeYear, finishTimeMonth, finishTimelDay]
                        
                        historydata.insert(HistoryData(word: userCardWord , num: String(cardCount + 1), cardColor: userCardColor ?? "綠", startTime: [finishTimeYear, finishTimeMonth, finishTimelDay], endTime: nil), at: 0)
                        
                        UserDefaults.standard.set(userCardColor, forKey: "color")
                        
                        UserDefaults.standard.set(userCardWord, forKey: "word")
                        
                        saveHistorydata()
                        
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }) {
                        VStack{
                            ZStack{
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color(red: 230/255, green: 230/255, blue: 230/255))
                                
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(checkOn == true ? Color.black : Color.white)
                            }
                            
                            
                            Text("確認")
                                .foregroundColor(checkOn == true ? Color.black : Color.gray)
//                                .font(.system(size: 20))
                            .font(.custom("jf-openhuninn-1.1", size: 20))
                            
                        }
                    }
                    .disabled(!checkOn)
                    
                    
                    
                }
                
                
            }
            .padding()
        }
        
    }
}

struct NewPageView_Previews: PreviewProvider {
    static var previews: some View {
        NewPageView(showNewPageView: .constant(true), ButtonStatus: .constant(true))
    }
}
