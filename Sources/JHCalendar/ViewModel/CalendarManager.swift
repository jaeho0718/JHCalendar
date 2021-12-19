//
//  File.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import Foundation

public class CalendarManager : ObservableObject {
    
    @Published var mode : CalendarMode {
        willSet(newValue){
            changeMode(newValue: newValue)
        }
    }
    @Published var page : CalendarPage
    @Published var selectedComponent : CalendarComponents
    
    let weekComponents : [DayComponent]
    let monthComponents : [DayComponent]
    let startDate : CalendarComponents
    let endDate : CalendarComponents
    
    public init(mode : CalendarMode = .Month,
                startDate : CalendarComponents = .startDefault,
                endDate : CalendarComponents = .endDefault,
                startPoint : CalendarComponents = .current) {
        var comps = [DayComponent]()
        
        for comp in startDate ..< endDate {
            if comp.date.weekday == 7 {
                //saturday
                comps.append(DayComponent(id: comps.count,
                                          component: comp))
            }
        }
        
        var monthComps = [DayComponent]()
        for comp in comps {
            if !monthComps.contains(where: {$0.component.year == comp.component.year
                && $0.component.month == comp.component.month}) {
                monthComps.append(comp)
            }
        }
        
        var pg = CalendarPage(monthPage: startPoint, weekPage: startPoint, mode: mode)
        
        if let monthPage = monthComps.first(where: {$0.component.year == startPoint.year
            && $0.component.month == startPoint.month}) ,mode == .Month{
            pg.monthPage = monthPage.component
        } else if mode == .Week {
            let cWeek = startPoint.date.weekday
            let cDate = Calendar.current.date(byAdding: .day,
                                              value: 7-cWeek,
                                              to: startPoint.date) ?? Date()
            pg.weekPage = CalendarComponents(year: cDate.year, month: cDate.month, day: cDate.day)
        }
        
        self.startDate = startDate
        self.endDate = endDate
        self.weekComponents = comps
        self.monthComponents = monthComps
        self.selectedComponent = startPoint
        self.mode = mode
        self.page = pg
    }
    
    public func changeMode(mode newValue : CalendarMode? = nil) {
        if let newValue = newValue {
            mode = newValue
        } else {
            switch mode {
            case .Week :
                mode = .Month
            case .Month :
                mode = .Week
            }
        }
    }
    
    public func setPage(component : CalendarComponents) {
        switch mode {
        case .Month:
            let currentDate = CalendarComponents(year: component.year, month: component.month, day: 1).date
            let newDate = Calendar.current.date(byAdding: .day, value: 7-currentDate.weekday, to: currentDate) ?? Date()
            page.monthPage = CalendarComponents(year: newDate.year, month: newDate.month, day: newDate.day)
        case .Week:
            let week = component.date.weekday
            let newDate = Calendar.current.date(byAdding: .day, value: 7-week, to: component.date) ?? Date()
            page.weekPage = CalendarComponents(year: newDate.year, month: newDate.month, day: newDate.day)
        }
    }
    
    func changeMode(newValue : CalendarMode) {
        switch newValue {
        case .Month:
            if let newpg = weekComponents.first(where: {$0.component.month == page.weekPage.month
                && $0.component.year == page.weekPage.year}) {
                page.monthPage = newpg.component
            }
        case .Week:
            if selectedComponent.year == page.monthPage.year
                && selectedComponent.month == page.monthPage.month {
                // same page
                let slweek = selectedComponent.date.weekday
                let wkDate = Calendar.current.date(byAdding: .day, value: 7 - slweek,
                                                   to: selectedComponent.date) ?? Date()
                page.weekPage = CalendarComponents(year: wkDate.year, month: wkDate.month, day: wkDate.day)
            } else {
                if let newpg = weekComponents.first(where: {$0.component.month == page.monthPage.month
                    && $0.component.year == page.monthPage.year}) {
                    page.weekPage = newpg.component
                }
            }
        }
        page.mode = newValue
    }
}
