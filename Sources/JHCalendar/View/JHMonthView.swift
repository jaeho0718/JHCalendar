//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import SwiftUI

/// Month View
struct JHMonthView<MonthContent : View>: View {
    
    @Environment(\.calendarHeight) var calendarHeight
     
    @EnvironmentObject var manger : CalendarManger
    
    var content : (CalendarComponent) -> MonthContent
    
    var page : CalendarComponent
    
    let columns : [GridItem]
    
    init(page : CalendarComponent, @ViewBuilder content : @escaping
                                                    (CalendarComponent) -> MonthContent ) {
        self.page = page
        self.columns = Array(repeating: GridItem( .flexible(minimum: 20, maximum: .infinity),
                                                  spacing: 0, alignment: .center),
                             count: 7)
        self.content = content
    }
    
    var body: some View {
        LazyVGrid(columns:columns,spacing: 0){
            ForEach(manger.generateDayComponents(page: page)){ component in
                content(component.data).frame(height : calendarHeight,alignment:.top)
                    .foregroundColor(component.isCurrentMonth ? .primary : .secondary)
                    .accentColor(component.isCurrentMonth ? .primary : .secondary)
            }
        }
    }
    
}

struct JHMonthView_Previews: PreviewProvider {
    static var previews: some View {
        JHMonthView(page: .init(year: 2021, month: 7, day: 1),content: { component in
            Text("\(component.day)")
        })
        .environmentObject(CalendarManger())
    }
}

