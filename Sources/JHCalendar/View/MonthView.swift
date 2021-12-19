//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/12/18.
//

import SwiftUI

struct MonthView<Content : View> : View {
    @EnvironmentObject var manager : CalendarManager
    
    var displayMode : CalendarDisplayMode
    let height : CGFloat
    var month : CalendarComponents
    let columns : [GridItem]
    let components : [DayComponent]
    let content : (CalendarComponents) -> Content
    var dayPrimaryColor : Color
    var daySecondaryColor : Color
    
    init(displayMode : CalendarDisplayMode,
         month : CalendarComponents ,
         height : CGFloat = 50,
         dayPrimaryColor : Color = .primary,
         daySecondaryColor : Color = .secondary,
         @ViewBuilder content : @escaping (CalendarComponents) -> Content) {
        let endDay = month.endDay
        let startWeek = month.startWeek
        let item = GridItem(.flexible(minimum: 10, maximum: .infinity),
                            spacing: 0, alignment: .center)
        var comps = [DayComponent]()
        let prDate = Calendar.current.date(byAdding: .month, value: -1, to: month.date) ?? Date()
        let prComp = CalendarComponents(year: prDate.year, month: prDate.month, day: 1)
        for day in 1 ..< startWeek {
            comps.append(DayComponent(id: comps.count,
                                      component: CalendarComponents(year: prComp.year, month: prComp.month, day: prComp.endDay - startWeek + day + 1)))
        }
        for day in 1 ..< endDay + 1 {
            comps.append(DayComponent(id: comps.count,
                                      component: CalendarComponents(year: month.year, month: month.month, day: day)))
        }
        let count = comps.count
        let nxDate = Calendar.current.date(byAdding: .month, value: 1, to: month.date) ?? Date()
        for nxDay in 1 ..< 42 - count + 1 {
            comps.append(DayComponent(id: comps.count,
                                      component: CalendarComponents(year: nxDate.year, month: nxDate.month, day: nxDay)))
        }
        self.displayMode = displayMode
        self.month = month
        self.components = comps
        self.columns = Array(repeating: item, count: 7)
        self.dayPrimaryColor = dayPrimaryColor
        self.daySecondaryColor = daySecondaryColor
        self.height = height
        self.content = content
    }
    
    var monthView : some View {
        LazyVGrid(columns: columns,spacing: 0) {
            ForEach(components){ comp in
                content(comp.component)
                    .frame(minHeight:height,maxHeight: .infinity)
                    .foregroundColor(isEqual(component: comp.component) ? dayPrimaryColor : daySecondaryColor)
                    .accentColor(isEqual(component: comp.component) ? dayPrimaryColor : daySecondaryColor)
            }
        }
    }
    
    var body: some View {
        switch displayMode {
        case .page:
            monthView
        case .scroll:
            GeometryReader{ geometry in
                monthView
                    .onChange(of: geometry.frame(in: .named("ScrollView")).minY , perform: { value in
                        if value < height * 2 {
                            DispatchQueue.main.async {
                                manager.setPage(component: month)
                            }
                        }
                    })
            }
            .frame(height:height*6)
        }
    }
    
    private func isEqual(component : CalendarComponents) -> Bool {
        return month.year == component.year && month.month == component.month
    }
}



struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(displayMode: .page,
                  month: CalendarComponents(year: 2021, month: 12, day: 4)) {
            DefaultCalendarCell(component: $0)
        }
        .environmentObject(CalendarManager())
    }
}
