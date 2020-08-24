//
//  CalendarView.swift
//  pointCard
//
//  Created by 郭冠杰 on 2020/8/9.
//  Copyright © 2020 郭冠杰. All rights reserved.
//

import SwiftUI
import ElegantCalendar


struct CalendarView: View, ElegantCalendarDataSource, ElegantCalendarDelegate {
    
    let screenH = UIScreen.main.bounds.height // 讀取螢幕高度
    
    @ObservedObject var monthDataManager = MonthDataManager()
    
    @ObservedObject var calendarManager = MonthlyCalendarManager(
        configuration: CalendarConfiguration(startDate: Date().addingTimeInterval(-60*60*24*300), endDate: Date().addingTimeInterval(60*60*24*300)), initialMonth: .daysFromToday(0))
    
    init() {
        calendarManager.datasource = self
        calendarManager.delegate = self
    }
    
    @State private var calendarTheme: CalendarTheme = .brilliantViolet
    
    var body: some View {
        
        NavigationView{
            // ScrollView(.vertical) {
            //            ZStack(alignment: .bottom){
            MonthlyCalendarView(calendarManager: calendarManager)
                .horizontal()
                .theme(calendarTheme)
                .allowsHaptics(false)
                //                        .frame(height: 250)
                //                        .frame(width: 350)
                .offset(x: 0, y: screenH > 800 ? 100 : 28)
                
                //                    // 頁面月數
                //                    Text(monthDataManager.message)
                //                        .offset(x: 0, y: -30)
                
                //            }
                
                // }
                .navigationBarTitle(Text("統計資料"), displayMode: .inline)
            
        }
        
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

public extension View {
    
    var erased: AnyView {
        AnyView(self)
    }
    
}

extension Date {
    
    static func daysFromToday(_ days: Int) -> Date {
        Date().addingTimeInterval(TimeInterval(60*60*24*days))
    }
    
}

extension CalendarView{
    
    func calendar(willDisplayMonth date: Date) {
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        monthDataManager.month = "\(month)"
        monthDataManager.year = "\(year)"
//        print("show", month, year)
    
    }
    
    func calendar(backgroundColorOpacityForDate date: Date) -> Double {
        
        //        if self.calendarManager.selectedDate != nil  {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateString = formatter.string(from: date)
        
        if UserDefaults.standard.integer(forKey: dateString) != 0 {
            return 0.5
        }
        else{
            return 0
        }
        //        }
        //
        //        return 0
        
    }
    
    func calendar(canSelectDate date: Date) -> Bool {
        
        //        let formatter = DateFormatter()
        //        formatter.dateStyle = .short
        //        let dateString = formatter.string(from: date)
        //
        //        if UserDefaults.standard.integer(forKey: dateString) != 0{
        //            return true
        //        }
        //        else {
        //            return true
        //        }
        
        let month = Calendar.current.component(.month, from: date)
        let currentMonth = Calendar.current.component(.month, from: calendarManager.currentMonth)
        
        return currentMonth == month
        
    }
    
    func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateString = formatter.string(from: date)
        
        return TodayInfoView(searchKey: dateString).erased
    }
    
    func calendarViewForMonthData() -> AnyView {
        
//        let year = monthDataManager.year
//        let month = monthDataManager.month
        
//        print(year, month)
//        return Text("\(year), \(month)").erased
        
        return MonthInfoView(monthInfo: monthDataManager).erased
    }
    
}
