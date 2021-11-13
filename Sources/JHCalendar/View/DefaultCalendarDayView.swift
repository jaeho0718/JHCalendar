//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import SwiftUI

/// Default day content
public struct DefaultCalendarDayView: View {
    @EnvironmentObject var manager : CalendarManger
    @Environment(\.calendarHeight) var calendarHeight
    var component : CalendarComponent
    
    public init (component : CalendarComponent) {
        self.component = component
    }
    
    var body: some View {
        Button(action:{
            withAnimation(.easeInOut){
                manager.selectedComponent = component
            }
        }){
            Text(String(component.day))
                .fontWeight(isEqual() ? .semibold : .medium)
                .frame(width:calendarHeight,height: calendarHeight,alignment: .top)
                .foregroundColor(isEqual() ? .red : .accentColor)
        }
        .buttonStyle(.plain)
    }
    
    func isEqual() -> Bool {
        manager.selectedComponent.year == component.year
        && manager.selectedComponent.month == component.month
        && manager.selectedComponent.day == component.day
    }
}

struct DefaultCalendarDayView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultCalendarDayView(component: .currentDefault)
            .environmentObject(CalendarManger())
    }
}

