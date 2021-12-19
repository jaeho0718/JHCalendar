//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/12/18.
//

import SwiftUI

public struct JHCalendar<Content : View> : View {
    
    @EnvironmentObject var manager : CalendarManager
    @Namespace var transitionID
    private var cellHeight : CGFloat
    private var content : (CalendarComponents) -> Content
    #if os(iOS)
    var displayMode : CalendarDisplayMode = .page
    #else
    let displayMode : CalendarDisplayMode = .scroll
    #endif
    var customWeekdaySymbols = [String]()
    var weekdaySymbolType : CalendarSymbolType = .short
    var weekdayBarColor : Color = .primary
    var dayPrimaryColor : Color = .primary
    var daySecondaryColor : Color = .secondary
    var weekdayFont : Font? = nil
    var showTitle : Bool = true
    var showWeekBar : Bool = true
    
    public init(cellHeight : CGFloat = 50,
                @ViewBuilder content : @escaping (CalendarComponents) -> Content) {
        self.cellHeight = cellHeight
        self.content = content
    }
    
    #if os(iOS)
    var pageMode : some View {
        Group{
            switch manager.mode {
            case .Month :
                TabView(selection: $manager.page.monthPage){
                    ForEach(manager.monthComponents){ month in
                        MonthView(displayMode: .page, month: month.component,
                                  height: cellHeight,
                                  dayPrimaryColor: dayPrimaryColor,
                                  daySecondaryColor: daySecondaryColor,
                                  content: { comp in
                            content(comp)
                        })
                        .tag(month.component)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .matchedGeometryEffect(id: "View", in: transitionID,anchor: .top)
            case .Week :
                TabView(selection:$manager.page.weekPage){
                    ForEach(manager.weekComponents) { week in
                        WeekView(week: week.component,
                                 height: cellHeight,
                                 dayPrimaryColor: dayPrimaryColor,
                                 daySecondaryColor: daySecondaryColor,
                                 content: { comp in
                            content(comp)
                        })
                        .tag(week.component)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .matchedGeometryEffect(id: "View", in: transitionID,anchor: .top)
            }
        }
        .frame(height:manager.mode == .Month ? cellHeight * 6 : cellHeight,alignment: .top)
    }
    #endif
    
    var scrollMode : some View {
        ScrollViewReader{ proxy in
            ScrollView(.vertical,showsIndicators: false){
                LazyVStack{
                    ForEach(manager.monthComponents){ month in
                        VStack{
                            MonthView(displayMode: .scroll,
                                      month: month.component,
                                      height: cellHeight,
                                      dayPrimaryColor: dayPrimaryColor,
                                      daySecondaryColor: daySecondaryColor,
                                      content: { comp in
                                content(comp)
                            })
                            Divider()
                        }.id(month.component)
                    }
                }
            }
            .coordinateSpace(name: "ScrollView")
            .onAppear{
                proxy.scrollTo(manager.page.monthPage, anchor: .top)
            }
        }
        
    }
    
    public var body: some View {
        VStack(spacing:0){
            if showTitle {
                CalendarTitle(comp: manager.page.current)
                    .padding(.bottom)
            }
            if showWeekBar {
                JHWeekBar(weeks: customWeekdaySymbols,
                        symbolType: weekdaySymbolType,
                        font: weekdayFont)
                    .foregroundColor(weekdayBarColor)
            }
            
            #if os(iOS)
            switch displayMode {
            case .page:
                pageMode
            case .scroll:
                scrollMode
            }
            #else
            scrollMode
            #endif
        }
    }
}

struct JHCalendar_Previews: PreviewProvider {
    static var previews: some View {
        JHCalendar{ comp in
            DefaultCalendarCell(component: comp)
        }
        .calendarDisplayMode(mode: .scroll)
        .environmentObject(CalendarManager())
    }
}
