//
//  File.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import SwiftUI

struct CalendarHeight : EnvironmentKey {
    static var defaultValue : CGFloat = 50
}

struct CalendarWeekSymbols : EnvironmentKey {
    static var defaultValue : [String] = Calendar.current.shortWeekdaySymbols
}

struct CalendarShowTitle : EnvironmentKey {
    static var defaultValue : Bool = true
}

struct CalendarWeekFont : EnvironmentKey {
    static var defaultValue : Font = .callout
}

struct CalendarWeekColor : EnvironmentKey {
    static var defaultValue : Color = .secondary
}

extension EnvironmentValues {
    
    /// 캘린덜 요일 셀의 기본 높이입니다.
    var calendarHeight : CGFloat {
        get { self[CalendarHeight.self] }
        set { self[CalendarHeight.self] = newValue }
    }
    
    /// 캘린더에 표시된 요일값입니다. 기본적으로 지역화된 요일값이 들어갑니다.
    var calendarWeekSymbols : [String] {
        get { self[CalendarWeekSymbols.self] }
        set { self[CalendarWeekSymbols.self] = newValue }
    }
    
    /// 캘린더의 년/월 타이틀 표시여부
    var calendarShowTitle : Bool {
        get { self[CalendarShowTitle.self] }
        set { self[CalendarShowTitle.self] = newValue }
    }
    
    /// 캘린더의 표시된 주일 폰트
    var calendarWeekFont : Font {
        get { self[CalendarWeekFont.self] }
        set { self[CalendarWeekFont.self] = newValue }
    }
    
    /// 캘린더에 표시된 주일 색상
    var calendarWeekColor : Color {
        get { self[CalendarWeekColor.self] }
        set { self[CalendarWeekColor.self] = newValue }
    }
    
}
