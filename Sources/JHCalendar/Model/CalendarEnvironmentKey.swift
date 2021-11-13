//
//  File.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import SwiftUI

public struct CalendarHeight : EnvironmentKey {
    public static var defaultValue : CGFloat = 50
}

public struct CalendarWeekSymbols : EnvironmentKey {
    public static var defaultValue : [String] = Calendar.current.shortWeekdaySymbols
}

public struct CalendarShowTitle : EnvironmentKey {
    public static var defaultValue : Bool = true
}

public struct CalendarWeekFont : EnvironmentKey {
    public static var defaultValue : Font = .callout
}

public struct CalendarWeekColor : EnvironmentKey {
    public static var defaultValue : Color = .secondary
}

extension EnvironmentValues {
    
    /// 캘린덜 요일 셀의 기본 높이입니다.
    public var calendarHeight : CGFloat {
        get { self[CalendarHeight.self] }
        set { self[CalendarHeight.self] = newValue }
    }
    
    /// 캘린더에 표시된 요일값입니다. 기본적으로 지역화된 요일값이 들어갑니다.
    public var calendarWeekSymbols : [String] {
        get { self[CalendarWeekSymbols.self] }
        set { self[CalendarWeekSymbols.self] = newValue }
    }
    
    /// 캘린더의 년/월 타이틀 표시여부
    public var calendarShowTitle : Bool {
        get { self[CalendarShowTitle.self] }
        set { self[CalendarShowTitle.self] = newValue }
    }
    
    /// 캘린더의 표시된 주일 폰트
    public var calendarWeekFont : Font {
        get { self[CalendarWeekFont.self] }
        set { self[CalendarWeekFont.self] = newValue }
    }
    
    /// 캘린더에 표시된 주일 색상
    public var calendarWeekColor : Color {
        get { self[CalendarWeekColor.self] }
        set { self[CalendarWeekColor.self] = newValue }
    }
    
}
