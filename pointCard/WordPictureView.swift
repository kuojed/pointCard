//
//  WordPictureView.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/6/6.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI

struct WordPictureView: View {
    
    @ObservedObject var wordInfoData = WordInfoData()
    
    @State private var showNewPageView = false
    @State var buttonOff = true
    
    let step = 25 // 一格 分鐘
    
    let screenH = UIScreen.main.bounds.height // 讀取螢幕高度
    
    func daimokuCount (h: Int, m: Int, s: Int) -> Int {
        
        return (h * 3600 + m * 60 + s) * 50 / 60
        
    } // 計算題目數
    
    func checkCount (h: Int, m: Int, s: Int) -> Int {
        
        return (h * 60 + m) / step
//                        return (m * 60 + s) / step
        
    } // 計算格數
    
    func differenceCount (h_in: Int, m_in: Int, s_in: Int) -> (h_out: Int, m_out: Int, s_out: Int) {
        
        let d = h_in * 3600 + m_in * 60 + s_in - 80 * step * 60
//                let d = h_in * 3600 + m_in * 60 + s_in - 80 * step
        
        let s_out = d % 60
        let m_out = (d / 60) % 60
        let h_out = d / 60 / 60
        
        return (h_out, m_out, s_out)
        
    } // 計算超過最大值的部分
    
    var body: some View {
        
        NavigationView{
            
            NavigationLink(destination: NewPageView(showNewPageView: self.$showNewPageView, ButtonStatus: self.$buttonOff)) {
                
                ZStack(alignment: .bottom){
                    
                    ZStack{
                        
                        
                        ZStack(alignment: .top){
                            
                            Rectangle()
                                .foregroundColor(colorType[userCardColor ?? "綠"])
                            
                            if buttonOff == true {
                                Text("目前累積: \(daimokuCount(h: systemTime.hour ?? 0, m: systemTime.minute ?? 0, s: systemTime.second ?? 0)) 遍")
                                    .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                                    .font(.custom("jf-openhuninn-1.1", size: 25))
                                    .offset(x: 0, y: screenH > 800 ? 20 : 40)
                            } else {
                                
                                HStack{
                                    Text("恭喜達成!")
                                        .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                                        .font(.custom("jf-openhuninn-1.1", size: 25))
                                        .offset(x: 0, y: screenH > 800 ? 20 : 40)
                                    
                                    
                                    
                                    Image(systemName: "smiley")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                                        .frame(width: 25, height: 25)
                                        .rotationEffect(.degrees(0))
                                        .offset(x: 0, y: screenH > 800 ? 20 : 40)
                                    
                                    Text("(點選下張)")
                                        .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                                        .font(.custom("jf-openhuninn-1.1", size: 25))
                                        .offset(x: 0, y: screenH > 800 ? 20 : 40)
                                }
                                
                                
                            }
                            
                        }
                        
                        
                        
                        
                        VStack{
                            
                            WordView(wordInfo: wordInfoData.wordInfos[userCardWord[0]]!)
                                .scaleEffect(screenH > 800 ? 1 : 0.85)
                                .offset(x: 0, y: screenH > 800 ? 0 : 40)
                            
                            WordView(wordInfo: wordInfoData.wordInfos[userCardWord[1]]!)
                                .scaleEffect(screenH > 800 ? 1 : 0.85)
                                .offset(x: 0, y: screenH > 800 ? 10 : -30)
                            
                        }
                        
                        
                        
                    }
                    
                    Text("一格: 25分鐘, 共計十萬遍")
                        .font(.custom("jf-openhuninn-1.1", size: 20))
                        .foregroundColor(Color(red: 100/255, green: 100/255, blue: 100/255))
                        .offset(x: 0, y: screenH > 800 ? -20 : -40)
                    
                }
                .navigationBarTitle(Text("題目數"), displayMode: .inline)
            }
            .disabled(buttonOff)
            .onAppear {
                
                for i in self.wordInfoData.wordInfos[userCardWord[0]]!.circleInfos.indices {
                    self.wordInfoData.wordInfos[userCardWord[0]]!.circleInfos[i].isFill = false
                    self.wordInfoData.wordInfos[userCardWord[1]]!.circleInfos[i].isFill = false
                }
                
                var count = self.checkCount(h: systemTime.hour ?? 0, m: systemTime.minute ?? 0, s: systemTime.second ?? 0)
                
                //                60 * (systemTime.minute ?? 0) + (systemTime.second ?? 0)
                
                //            print(count)
                
                if count >= 80 {
                    
                    let result = self.differenceCount(h_in: systemTime.hour ?? 0, m_in: systemTime.minute ?? 0, s_in: systemTime.second ?? 0)
                    
                    residualTime_hour = result.h_out
                    residualTime_minute = result.m_out
                    residualTime_second = result.s_out
                    
                    count = 80
                    
                    //                print("剩餘: \(result)")
                }
                
                for i in 0 ..< count {
                    
                    if i < 40 {
                        self.wordInfoData.wordInfos[userCardWord[0]]!.circleInfos[i].isFill = true
                        
                    } else if i < 79 {
                        self.wordInfoData.wordInfos[userCardWord[1]]!.circleInfos[i-40].isFill = true
                    } else if i == 79 {
                        self.wordInfoData.wordInfos[userCardWord[1]]!.circleInfos[i-40].isFill = true
                        self.buttonOff = false
                    }
                    
                }
            }
            
        }
        //       .sheet(isPresented: $showNewPageView) {
        //            NewPageView(showNewPageView: self.$showNewPageView)
        //         NewPageView(showNewPageView: self.$showNewPageView, ButtonStatus: self.$buttonOff)
        //   }
        
        
    }
}

struct PointCardView_Previews: PreviewProvider {
    static var previews: some View {
        WordPictureView()
    }
}

struct WordView: View {
    
    var wordInfo: WordInfo
    
    var body: some View {
        ZStack {
            
            Text(wordInfo.word)
                .font(.custom("jf-openhuninn-1.1", size: 300))
                .foregroundColor(Color.white)
            
            ForEach(wordInfo.circleInfos) { (circleInfo)  in
                
                if circleInfo.isFill {
                    
                    FillCircle(offsetSize: circleInfo.offsetSize)
                    
                } else {
                    
                    EmptyCircle(offsetSize: circleInfo.offsetSize)
                    
                }
                
            }
            
        }
        
    }
}

struct FillCircle: View {
    
    let offsetSize: CGSize
    
    var body: some View {
        Circle()
            .fill()
            .frame(width: 10, height: 10)
            .foregroundColor(.blue)
            .offset(offsetSize)
    }
}

struct EmptyCircle: View {
    
    let offsetSize: CGSize
    
    var body: some View {
        Circle()
            .stroke()
            .frame(width: 10, height: 10)
            .foregroundColor(.black)
            .offset(offsetSize)
    }
}

