//
//  File.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import Foundation

public struct CalendarComponents : Hashable,Strideable{
    
    public var year : Int
    public var month : Int
    public var day : Int
    
    public var date : Date {
        let comp = DateComponents(year:year,month: month,day: day,hour: 0,minute: 0)
        return Calendar.current.date(from: comp) ?? Date()
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(year)
        hasher.combine(month)
        hasher.combine(day)
    }
    
    public static func == (lhs: CalendarComponents, rhs: CalendarComponents) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }
    
    public func advanced(by n: Int) -> CalendarComponents {
        let value = self
        guard let next = Calendar.current.date(byAdding: .day, value: n, to: value.date)  else {return value}
        return CalendarComponents(year: next.year, month: next.month, day: next.day)
    }
    
    public func distance(to other: CalendarComponents) -> Int {
        let current = self
        return Int(other.date.timeIntervalSince(current.date))
    }
}

extension CalendarComponents {
    
    /// 1 : Sunday , 2 : Monday , 3 : Tuesday , 4 :  Wednesday, 5 : Thursday , 6 : Friday , 7: Saturday
    var startWeek : Int {
        let monthDate = CalendarComponents(year: year, month: month, day: 1).date
        return monthDate.weekday
    }
    
    var endDay : Int {
        let monthDate = CalendarComponents(year: year, month: month, day: 1).date
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: monthDate)
                       else { return 1 }
        guard let lastDate = Calendar.current.date(byAdding: .day, value: -1, to: nextMonth)
                       else { return 1 }
        return lastDate.day
    }
}

public extension CalendarComponents {
    
    static let startDefault : CalendarComponents = CalendarComponents(year: Date.current.fourYearBefore.year,
                                                                      month: Date.current.fourYearBefore.month,
                                                                      day: Date.current.fourYearBefore.day)
    static let endDefault : CalendarComponents = CalendarComponents(year: Date.current.fourYearLater.year,
                                                                    month: Date.current.fourYearLater.month,
                                                                    day: Date.current.fourYearLater.day)
    static let current : CalendarComponents = CalendarComponents(year: Date.current.year,
                                                                 month: Date.current.month,
                                                                 day: Date.current.day)
}

struct DayComponent : Identifiable {
    var id : Int
    var component : CalendarComponents
}

public struct CalendarPage {
    var monthPage : CalendarComponents
    var weekPage : CalendarComponents
    var mode : CalendarMode
    
    public var current : CalendarComponents {
        switch mode {
        case .Week :
            return weekPage
        case .Month :
            return monthPage
        }
    }
}

public enum CalendarMode {
    case Month
    case Week
}

public enum CalendarSymbolType {
    case veryshort
    case short
}

public enum CalendarDisplayMode {
    case page
    case scroll
}
