//
//  File.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import Foundation

public struct CalendarComponent {
    public var year : Int
    public var month : Int
    public var day : Int
    
    ///DateComponts
    public var component : DateComponents {
        return .init(calendar:.current,year: year, month: month, day: day,hour: 0,minute: 0)
    }
    
    public var date : Date {
        guard let result = component.date else { return Date() }
        return result
    }
    
    /// 0 : 일 , 1 : 월 , 2 : 화 , 3 :  수, 4 : 목 , 5 : 금 , 6: 토
    public var startWeek : Int {
        return date.weekday
    }
    
    public var lastWeek : Int {
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: date)
                else { return 1 }
        guard let lastDate = Calendar.current.date(byAdding: .day, value: -1, to: nextMonth)
                else { return 1 }
        return lastDate.weekday
    }
    
    public var endDay : Int {
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: date)
                else { return 1 }
        guard let lastDate = Calendar.current.date(byAdding: .day, value: -1, to: nextMonth)
                else { return 1 }
        return lastDate.day
    }
    
}

extension CalendarComponent {
    
    /// 현재 날짜로부터 4년전까지 시간
    public static let startDefault : CalendarComponent = .init(year: Date().fourYearBefore.year,
                                                        month: Date().fourYearBefore.month,
                                                        day: Date().fourYearBefore.day)
    
    /// 현재 날짜로부터 4년후까지 시간
    public static let endDefault : CalendarComponent = .init(year: Date().fourYearLater.year,
                                                        month: Date().fourYearLater.month,
                                                        day: Date().fourYearLater.day)
    
    /// 현재 날짜
    public static let currentDefault : CalendarComponent = .init(year: Date().year,
                                                          month: Date().month,
                                                          day: Date().day)
}

extension CalendarComponent {
    
    /// 입력받은 컴포넌트와 비교하여 작으면 음수, 같으면 0, 크면 양수를 반환합니다.
    public func compareComponent(_ component : CalendarComponent) -> TimeInterval {
        guard let selfDate = self.component.date else { return 0 }
        guard let compareDate = component.component.date else { return 0 }
        return selfDate.timeIntervalSince(compareDate)
    }
    
}

public struct MonthDayComponent : Identifiable {
    public var index : Int
    public var isCurrentMonth : Bool
    public var data : CalendarComponent
    public var id : Int {
        index
    }
}

public struct YearMonthComponent : Identifiable {
    public var index : Int
    public var data : CalendarComponent
    public var tag : PageComponent
    public var id : Int {
        index
    }
}

public struct WeekComponent : Identifiable {
    public var index : Int
    public var data : [WeekDayComponent]
    public var tag : PageComponent
    public var id : Int {
        index
    }
}

public struct WeekDayComponent : Identifiable {
    public var index : Int
    public var isCurrentMonth : Bool
    public var data : CalendarComponent
    public var id : Int {
        index
    }
}

public struct PageComponent : Hashable {
    
    public var year : Int
    public var month : Int
    public var day : Int
    
    public static func == (lhs: PageComponent, rhs: PageComponent) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(year)
        hasher.combine(month)
        hasher.combine(day)
    }
}

public enum CalendarMode {
    case Month,Week
}
