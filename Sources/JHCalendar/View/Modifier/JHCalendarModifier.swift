//
//  File.swift
//  
//
//  Created by Lee Jaeho on 2021/12/19.
//

import SwiftUI

public extension JHCalendar {
    
    func customWeekdaySymbols(symbols : [String]) -> JHCalendar {
        var view = self
        view.customWeekdaySymbols = symbols
        return view
    }
    
    func weekdaySymbolType(type : CalendarSymbolType) -> JHCalendar {
        var view = self
        view.weekdaySymbolType = type
        return view
    }
    
    func weekdaySymbolColor(color : Color) -> JHCalendar {
        var view = self
        view.weekdayBarColor = color
        return view
    }
    
    func weekdayFont(font : Font?) -> JHCalendar {
        var view = self
        view.weekdayFont = font
        return view
    }
    
    func calendarCellAccentColor(primary : Color,secondary : Color) -> JHCalendar {
        var view = self
        view.dayPrimaryColor = primary
        view.daySecondaryColor = secondary
        return view
    }
    
    func showTitle(show : Bool) -> JHCalendar {
        var view = self
        view.showTitle = show
        return view
    }
    
    func showWeekBar(show : Bool) -> JHCalendar {
        var view = self
        view.showWeekBar = show
        return view
    }
    
    @available(iOS 14.0,*)
    func calendarDisplayMode(mode : CalendarDisplayMode) -> JHCalendar {
        var view = self
        #if os(iOS)
        view.displayMode = mode
        #endif
        return view
    }
}
