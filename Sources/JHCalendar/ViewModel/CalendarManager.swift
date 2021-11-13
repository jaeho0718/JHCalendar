//
//  File.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import SwiftUI

/// 캘린더의 데이터를 관리하는 Viewmodel 입니다.
class CalendarManger : ObservableObject {
    
    /// 현재 페이지의 년,월 정보입니다.
    @Published var currentPage : YearMonthComponent
    
    /// 사용자가 선택한 날짜의 컴포넌트 정보입니다.
    @Published var selectedComponent : CalendarComponent
    
    /// 캘린더의 시작 날짜 컴포넌트
    var startComponent : CalendarComponent
    
    /// 캘린더의 마지막 날짜 컴포넌트
    var endComponent : CalendarComponent

    /// 캘린더의 데이터를 관리하는 Viewmodel 입니다.
    /// - Parameter start : 캘린더의 시작 컴포넌트
    /// - Parameter end : 캘린더의 마지막 컴포넌트
    /// - Parameter point : 캘린더의 초기 선택될 날짜 값
    init(start : CalendarComponent = .startDefault,
         end : CalendarComponent = .endDefault,
         point : CalendarComponent = .currentDefault) {
        
        self.startComponent = start
        self.endComponent = end
        self.selectedComponent = point
        
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
    
    /// 현재 날짜로 페이지를 되돌립니다.
    func resetPage() {
        let current = Date()
        let index = getComponentIndex(componentYear: current.year, componentMonth: current.month)
        currentPage = YearMonthComponent(index: index,
                                         data: CalendarComponent(year: current.year,
                                                                 month: current.month,
                                                                 day: 1))
        
        selectedComponent = CalendarComponent(year: current.year,
                                              month: current.month,
                                              day: current.day)
    }
    
}

extension CalendarManger {
    
    /// 현재 달의 날짜 컴포넌트를 생성합니다.
    func generateDayComponents( page : CalendarComponent ) -> [MonthDayComponent] {
        var components = [MonthDayComponent]()
        if page.startWeek != 0 {
            guard let lastMonth = Calendar.current.date(byAdding: .day , value: -1, to: page.date)
                else {return components}
            for week in 0 ..< page.startWeek {
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
    
    func getComponentIndex(componentYear : Int, componentMonth : Int) -> Int {
        var index = 0
        
        for year in startComponent.year ..< componentYear + 1 {
            if year == startComponent.year {
                if year == componentYear {
                    for _ in startComponent.month ..< componentMonth + 1 {
                        index += 1
                    }
                } else {
                    for _ in startComponent.month ..< 13 {
                        index += 1
                    }
                }
            } else if year == componentYear {
                for _ in 1 ..< componentMonth + 1 {
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
