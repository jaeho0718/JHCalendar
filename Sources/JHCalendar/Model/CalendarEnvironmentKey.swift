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
    
    /// Calendar weekday height.
    public var calendarHeight : CGFloat {
        get { self[CalendarHeight.self] }
        set { self[CalendarHeight.self] = newValue }
    }
    
    /// Calendar weekday symbol.
    public var calendarWeekSymbols : [String] {
        get { self[CalendarWeekSymbols.self] }
        set { self[CalendarWeekSymbols.self] = newValue }
    }
    
    /// Calendar title. If you want to hide title, set false.
    public var calendarShowTitle : Bool {
        get { self[CalendarShowTitle.self] }
        set { self[CalendarShowTitle.self] = newValue }
    }
    
    /// Calendar weekday font.
    public var calendarWeekFont : Font {
        get { self[CalendarWeekFont.self] }
        set { self[CalendarWeekFont.self] = newValue }
    }
    
    /// Calendar weekday font color.
    public var calendarWeekColor : Color {
        get { self[CalendarWeekColor.self] }
        set { self[CalendarWeekColor.self] = newValue }
    }
    
}
