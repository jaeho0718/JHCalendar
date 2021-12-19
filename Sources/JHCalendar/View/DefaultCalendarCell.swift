//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/12/19.
//

import SwiftUI

///Default DayView
///
///If you don't want to define CustomDayView, use DefaultCalendarCell view.
public struct DefaultCalendarCell: View {
    @EnvironmentObject var manager : CalendarManager
    var component : CalendarComponents
    var isSelected : Bool {
        manager.selectedComponent == component
    }
    public var body: some View {
        Button(action:{
            withAnimation(.easeInOut) {
                manager.selectedComponent = component
            }
        }){
            Text(String(component.day))
                .foregroundColor(isSelected ? .blue : .accentColor)
                .frame(maxWidth:.infinity,maxHeight: .infinity)
        }
        .buttonStyle(.borderless)
    }
}

struct DefaultCalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        DefaultCalendarCell(component: CalendarComponents(year: 2021, month: 12, day: 4))
            .environmentObject(CalendarManager())
    }
}
