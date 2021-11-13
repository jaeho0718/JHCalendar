import SwiftUI

/// JHCalendar뷰
public struct JHCalendar<DayContent : View>: View {
    @Environment(\.calendarHeight) var calendarHeight
    @Environment(\.calendarShowTitle) var showTitle
    
    @EnvironmentObject var manager : CalendarManger
    
    var content : ((CalendarComponent) -> DayContent)
    
    /// JHCalendar뷰
    /// - Parameter content : 날짜를 나타낼 뷰입니다.
    /// CalendarComponent를 뷰에 전달합니다.
    /// 기본으로 사용하고 싶으면 DefaultCalendarDayView를 사용하세요.
    public init(@ViewBuilder content : @escaping (CalendarComponent) -> DayContent ){
        self.content = content
    }
    
    public var body: some View {
        VStack(spacing:0){
            if showTitle {
                CalendarTitle()
                    .padding(.bottom,20)
            }
            WeekBar()
            TabView(selection: $manager.currentPage ){
                ForEach(manager.generateMonthComponents()){ component in
                    JHMonthView(page: component.data, content: { day in
                        content(day)
                    }).tag(component)
                }
            }.tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: calendarHeight * 6)
        }
    }
}

struct JHCalendar_Previews: PreviewProvider {
    static var previews: some View {
        JHCalendar(content: {
            DefaultCalendarDayView(component: $0)
        })
        .environmentObject(CalendarManger(start: .startDefault, end: .endDefault, point: .currentDefault))
    }
}
