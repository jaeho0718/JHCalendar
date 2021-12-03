//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/12/02.
//

import SwiftUI

struct JHWeekView<DayContent : View>: View {
    @Environment(\.calendarHeight) var calendarHeight
    
    var data : WeekComponent
    var content : (CalendarComponent) -> DayContent
    
    init(data : WeekComponent,
         @ViewBuilder content : @escaping (CalendarComponent) -> DayContent){
        self.data = data
        self.content = content
    }
    
    var body: some View {
        HStack(spacing:0){
            ForEach(data.data) { day in
                content(day.data)
                    .frame(maxWidth:.infinity,minHeight: calendarHeight)
                    .foregroundColor(day.isCurrentMonth ? .primary : .secondary)
                    .accentColor(day.isCurrentMonth ? .primary : .secondary)
            }
        }
    }
}
