//
//  File.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import SwiftUI

/// 캘린더의 데이터를 관리하는 Viewmodel 입니다.
public class CalendarManger : ObservableObject {
    
    /// 현재 페이지의 년,월 정보입니다.
    @Published public var currentPage : YearMonthComponent
    
    /// 사용자가 선택한 날짜의 컴포넌트 정보입니다.
    @Published public var selectedComponent : CalendarComponent
    
    /// 캘린더의 시작 날짜 컴포넌트
    var startComponent : CalendarComponent
    
    /// 캘린더의 마지막 날짜 컴포넌트
    var endComponent : CalendarComponent
    
    var point : CalendarComponent

    /// 캘린더의 데이터를 관리하는 Viewmodel 입니다.
    /// - Parameter start : 캘린더의 시작 컴포넌트
    /// - Parameter end : 캘린더의 마지막 컴포넌트
    /// - Parameter point : 캘린더의 초기 선택될 날짜 값
    public init(start : CalendarComponent = .startDefault,
         end : CalendarComponent = .endDefault,
         point : CalendarComponent = .currentDefault) {
        
        self.startComponent = start
        self.endComponent = end
        self.selectedComponent = point
        self.point = point
        var index = 0
        
        for year in startComponent.year ..< point.year + 1 {
            if year == startComponent.year {
                if year == point.year {
                    for _ in startComponent.month ..< point.month + 1 {
                        index += 1
                    }
                } else {
                    for _ in startComponent.month ..< 13 {
                        index += 1
                    }
                }
            } else if year == point.year {
                for _ in 1 ..< point.month + 1 {
                    index += 1
                }
            } else {
                for _ in 1 ..< 13 {
                    index += 1
                }
            }
        }
        
        self.currentPage = YearMonthComponent(index: index - 1,
                                              data: CalendarComponent(year: point.year,
                                                                      month: point.month,
                                                                      day: 1))
    }
    
    /// 지정된 날짜로 페이지를 되돌립니다.
    public func resetPage(resetDate : CalendarComponent ) {
        let index = getComponentIndex(pointComponent: resetDate)
        selectedComponent = resetDate
        currentPage = YearMonthComponent(index: index - 1,
                                         data: CalendarComponent(year: selectedComponent.year,
                                                                 month: selectedComponent.month,
                                                                 day: 1))
    }
    
}

extension CalendarManger {
    
    /// 현재 달의 날짜 컴포넌트를 생성합니다.
    func generateDayComponents( page : CalendarComponent ) -> [MonthDayComponent] {
        var components = [MonthDayComponent]()
        if page.startWeek != 0 {
            guard let lastMonth = Calendar.current.date(byAdding: .day , value: -1, to: page.date)
                else {return components}
            for week in 0 ..< page.startWeek - 1 {
                components.append(MonthDayComponent(index: components.count, isCurrentMonth: false,
                                                    data: CalendarComponent(year: lastMonth.year, month: lastMonth.month, day: lastMonth.day - page.startWeek + week + 1)))
            }
        }
        
        for day in 0 ..< page.endDay {
            components.append(MonthDayComponent(index: components.count, isCurrentMonth: true,
                                                data: CalendarComponent(year: page.year, month: page.month, day: day + 1)))
        }
        
        if components.count < 42 {
            guard let nextMonth = Calendar.current.date(byAdding: .month , value: +1, to: page.date)
                else {return components}
            for day in 0 ..< 42 - components.count {
                components.append(MonthDayComponent(index: components.count, isCurrentMonth: false,
                                                    data: CalendarComponent(year: nextMonth.year , month: nextMonth.month, day: nextMonth.day + day)))
            }
        }
        
        return components
    }
    
    /// 월과 관련된 컴포넌트를 생성합니다.
    func generateMonthComponents() -> [YearMonthComponent] {
        var components = [YearMonthComponent]()
        for year in startComponent.year ..< endComponent.year + 1 {
            if year == startComponent.year {
                for month in startComponent.month ..< 13 {
                    components.append(YearMonthComponent(index: components.count,
                                                         data: CalendarComponent(year: year, month: month, day: 1)))
                }
            } else if year == endComponent.year {
                for month in 1 ..< endComponent.month + 1 {
                    components.append(YearMonthComponent(index: components.count,
                                                         data: CalendarComponent(year: year, month: month, day: 1)))
                }
            } else {
                for month in 1 ..< 13 {
                    components.append(YearMonthComponent(index: components.count,
                                                         data: CalendarComponent(year: year, month: month, day: 1)))
                }
            }
        }
        return components
    }
    
    func getComponentIndex(pointComponent : CalendarComponent) -> Int {
        var index = 0
        
        for year in startComponent.year ..< pointComponent.year + 1 {
            if year == startComponent.year {
                if year == pointComponent.year {
                    for _ in startComponent.month ..< pointComponent.month + 1 {
                        index += 1
                    }
                } else {
                    for _ in startComponent.month ..< 13 {
                        index += 1
                    }
                }
            } else if year == pointComponent.year {
                for _ in 1 ..< pointComponent.month + 1 {
                    index += 1
                }
            } else {
                for _ in 1 ..< 13 {
                    index += 1
                }
            }
        }
        
        return index
    }
}
