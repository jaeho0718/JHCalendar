//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/12/18.
//

import SwiftUI

struct WeekView<Content : View> : View {
    
    let height : CGFloat
    let week : CalendarComponents
    let components : [DayComponent]
    let content : (CalendarComponents) -> Content
    let columns : [GridItem]
    var dayPrimaryColor : Color
    var daySecondaryColor : Color
    
    init(week : CalendarComponents,
         height : CGFloat = 50,
         dayPrimaryColor : Color = .primary,
         daySecondaryColor : Color = .secondary,
         @ViewBuilder content : @escaping (CalendarComponents) -> Content) {
        var comps = [DayComponent]()
        for day in 0 ..< 7 {
            let date = Calendar.current.date(byAdding: .day, value: -6 + day, to: week.date) ?? Date()
            comps.append(DayComponent(id: comps.count,
                                      component: CalendarComponents(year: date.year,
                                                                    month: date.month,
                                                                    day: date.day)))
        }
        let item = GridItem(.flexible(minimum: 10, maximum: .infinity),
                            spacing: 0, alignment: .center)
        self.columns = Array(repeating: item, count: 7)
        self.components = comps
        self.dayPrimaryColor = dayPrimaryColor
        self.daySecondaryColor = daySecondaryColor
        self.week = week
        self.content = content
        self.height = height
    }
    
    var body: some View {
        LazyVGrid(columns:columns){
            ForEach(components) { comp in
                content(comp.component)
                    .frame(minHeight:height,maxHeight: .infinity)
                    .foregroundColor(isEqual(component: comp.component) ? dayPrimaryColor : daySecondaryColor)
                    .accentColor(isEqual(component: comp.component) ? dayPrimaryColor : daySecondaryColor)
            }
        }
    }
    
    private func isEqual(component : CalendarComponents) -> Bool {
        return week.year == component.year && week.month == component.month
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView(week: CalendarComponents(year: 2021, month: 12, day: 4)) { comp in
            Text(String(comp.day))
        }
    }
}
