//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/12/03.
//

import SwiftUI

struct ExampleView: View {
    
    @StateObject var manager = CalendarManger(mode: .Month, start: .startDefault,
                                              end: .endDefault, point: .currentDefault)
    
    var body: some View {
        VStack{
            HStack{
                Button(action:{
                    manager.resetPage(resetDate: .currentDefault)
                }){
                    Text("Reset")
                }
                Spacer()
                Button(action:{
                    withAnimation(.easeInOut){
                        if manager.calendarMode == .Month {
                            manager.calendarMode = .Week
                        } else {
                            manager.calendarMode = .Month
                        }
                    }
                }){
                    Text("Change Mode")
                }
            }.padding(.horizontal)
            JHCalendar(titleHeight: 40, weekbarHeight: 40, content: { component in
                DefaultCalendarDayView(component: component)
            }).environmentObject(manager)
            //set weekday symbols
            .environment(\.calendarWeekSymbols, Calendar.current.veryShortWeekdaySymbols)
            
            Text("Selected day : \(String(manager.selectedComponent.year)) \(String(manager.selectedComponent.month)) \(String(manager.selectedComponent.day))")
            
            Spacer()
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
