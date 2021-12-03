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
    @Published public var currentPage : PageComponent
    
    /// 사용자가 선택한 날짜의 컴포넌트 정보입니다.
    @Published public var selectedComponent : CalendarComponent
    
    @Published public var calendarMode : CalendarMode = .Month {
        willSet(newValue){
            setPage(newValue: newValue)
        }
    }
    
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
        self.currentPage = PageComponent(year: point.year, month: point.month, day: 1)
        
    }
    
    /// 지정된 날짜로 페이지를 되돌립니다.
    public func resetPage(resetDate : CalendarComponent ) {
        selectedComponent = resetDate
        currentPage = PageComponent(year: resetDate.year, month: resetDate.month, day: 1)
    }
    
}

extension CalendarManger {
    
    /// 현재 달의 날짜 컴포넌트를 생성합니다.
    func generateDayComponents(page : CalendarComponent) -> [MonthDayComponent] {
        var components = [MonthDayComponent]()
        if page.startWeek != 0 {
            guard let lastMonth = Calendar.current.date(byAdding: .day , value: -1, to: page.date)
                else {return components}
            for week in 1 ..< page.startWeek {
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
                                                         data: CalendarComponent(year: year, month: month, day: 1),
                                                         tag: PageComponent(year: year, month: month, day: 1)))
                }
            } else if year == endComponent.year {
                for month in 1 ..< endComponent.month + 1 {
                    components.append(YearMonthComponent(index: components.count,
                                                         data: CalendarComponent(year: year, month: month, day: 1),
                                                         tag: PageComponent(year: year, month: month, day: 1)))
                }
            } else {
                for month in 1 ..< 13 {
                    components.append(YearMonthComponent(index: components.count,
                                                         data:  CalendarComponent(year: year, month: month, day: 1),
                                                         tag: PageComponent(year: year, month: month, day: 1)))
                }
            }
        }
        return components
    }
    
    /// 주와 관련된 컴포넌트를 생성합니다.
    func generateWeekComponents() -> [WeekComponent] {
        
        let monthComponents = generateMonthComponents()
        var temporaryComponent = [WeekDayComponent]()
        var weekComponents = [WeekComponent]()
        var temporaryWeek = WeekComponent(index: 0,data: [],
                                          tag: PageComponent(year: 0, month: 0, day: 0))
        
        for month in monthComponents {
            
            if month.id == monthComponents.first?.id {
                
                guard let lastMonth = Calendar.current.date(byAdding: .day, value: -1,
                                                            to: month.data.date) else {return []}
                
                for week in 0 ..< month.data.startWeek - 1 {
                    temporaryComponent.append(WeekDayComponent(index: temporaryComponent.count,
                                                               isCurrentMonth: false,
                                                               data: CalendarComponent(year: lastMonth.year,
                                                                                       month: lastMonth.month,
                                                                                       day: lastMonth.day - month.data.startWeek + week + 1)))
                }
            }
            
            for day in 0 ..< month.data.endDay {
                temporaryComponent.append(WeekDayComponent(index: temporaryComponent.count,
                                                           isCurrentMonth: true,
                                                           data: CalendarComponent(year: month.data.year,
                                                                                   month: month.data.month,
                                                                                   day: day + 1)))
            }
            
            if month.id == monthComponents.last?.id {
                guard let nextMonth = Calendar.current.date(byAdding: .month, value: +1,
                                                            to: month.data.date) else {return []}
                for week in 0 ..< 7 - month.data.lastWeek {
                    temporaryComponent.append(WeekDayComponent(index: temporaryComponent.count,
                                                               isCurrentMonth: false,
                                                               data: CalendarComponent(year: nextMonth.year,
                                                                                       month: nextMonth.month,
                                                                                       day: week + 1)))
                }
            }
        }
        
        for dayComponent in temporaryComponent {
            temporaryWeek.data.append(dayComponent)
            if temporaryWeek.data.count == 7 {
                temporaryWeek.index = weekComponents.count
                if temporaryWeek.data.contains(where: {$0.isCurrentMonth && $0.data.day == 1}) {
                    guard let firstDay = temporaryWeek.data.first(where: {$0.data.day == 1})
                                                                                    else {return[]}
                    temporaryWeek.tag = PageComponent(year: firstDay.data.year,
                                                      month: firstDay.data.month,
                                                      day: 1)
                } else {
                    guard let firstDay = temporaryWeek.data.first else {return []}
                    temporaryWeek.tag = PageComponent(year: dayComponent.data.year,
                                                      month: dayComponent.data.month,
                                                      day: firstDay.data.day)
                }
                weekComponents.append(temporaryWeek)
                temporaryWeek.data.removeAll()
            }
        }
        
        return weekComponents
    }
    
    /// 캘린더 모드가 month -> week로 변경될 때 페이지를 계산합니다.
    func setPage(newValue : CalendarMode) {
        let oldPage = currentPage
        var component = PageComponent(year: oldPage.year, month: oldPage.month, day: 1)
        if newValue == .Week {
            if selectedComponent.year == oldPage.year && selectedComponent.month == oldPage.month {
                
                if let newDay = Calendar.current.date(byAdding: .day,
                                                         value: -(selectedComponent.date.weekday - 1),
                                                      to: selectedComponent.date) {
                    if newDay.month == selectedComponent.month && newDay.year == selectedComponent.year {
                        component.day = newDay.day
                    }
                }
                if let newDay = Calendar.current.date(byAdding: .day, value: 7-selectedComponent.date.weekday, to: selectedComponent.date){
                    if newDay.month != selectedComponent.month || newDay.year != selectedComponent.year {
                        component.day = 1
                        component.year = newDay.year
                        component.month = newDay.month
                    }
                }
            }
        }
        self.currentPage = component
    }
}
