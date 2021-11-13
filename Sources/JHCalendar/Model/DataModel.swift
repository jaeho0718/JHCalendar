//
//  File.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import Foundation

public struct CalendarComponent {
    var year : Int
    var month : Int
    var day : Int
    
    ///DateComponts
    var component : DateComponents {
        return .init(calendar:.current,year: year, month: month, day: day,hour: 0,minute: 0)
    }
    
    var date : Date {
        guard let result = component.date else { return Date() }
        return result
    }
    
    /// 0 : 일 , 1 : 월 , 2 : 화 , 3 :  수, 4 : 목 , 5 : 금 , 6: 토
    var startWeek : Int {
        return date.weekday
    }
    
    var lastWeek : Int {
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: date)
                else { return 1 }
        guard let lastDate = Calendar.current.date(byAdding: .day, value: -1, to: nextMonth)
                else { return 1 }
        return lastDate.weekday
    }
    
    var endDay : Int {
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: date)
                else { return 1 }
        guard let lastDate = Calendar.current.date(byAdding: .day, value: -1, to: nextMonth)
                else { return 1 }
        return lastDate.day
    }
    
}

extension CalendarComponent {
    
    /// 현재 날짜로부터 2년전까지 시간
    static let startDefault : CalendarComponent = .init(year: Date().twoYearBefore.year,
                                                        month: Date().twoYearBefore.month,
                                                        day: Date().twoYearBefore.day)
    
    /// 현재 날짜로부터 2년후까지 시간
    static let endDefault : CalendarComponent = .init(year: Date().twoYearLater.year,
                                                        month: Date().twoYearLater.month,
                                                        day: Date().twoYearLater.day)
    
    static let currentDefault : CalendarComponent = .init(year: Date().year,
                                                          month: Date().month,
                                                          day: Date().day)
}

extension CalendarComponent {
    
    /// 입력받은 컴포넌트와 비교하여 작으면 음수, 같으면 0, 크면 양수를 반환합니다.
    func compareComponent(_ component : CalendarComponent) -> TimeInterval {
        guard let selfDate = self.component.date else { return 0 }
        guard let compareDate = component.component.date else { return 0 }
        return selfDate.timeIntervalSince(compareDate)
    }
    
}

struct MonthDayComponent : Identifiable {
    var index : Int
    var isCurrentMonth : Bool
    var data : CalendarComponent
    var id : Int {
        index
    }
}

struct YearMonthComponent : Identifiable, Hashable {
    
    static func == (lhs: YearMonthComponent, rhs: YearMonthComponent) -> Bool {
        lhs.index == rhs.index
    }
    
    var index : Int
    var data : CalendarComponent
    var id : Int {
        index
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }
}
