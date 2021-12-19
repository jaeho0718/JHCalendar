//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/12/03.
//

import SwiftUI

#if os(iOS)
struct ExampleView: View {
    
    @StateObject var manager = CalendarManager()
    
    var body: some View {
        NavigationView{
            VStack(spacing:0){
                JHWeekBar()
                JHCalendar(cellHeight:60){ component in
                    DefaultCalendarCell(component: component)
                }
                .showTitle(show: false)
                .showWeekBar(show: false)
                .environmentObject(manager)
                Text("Selected day : \(String(manager.selectedComponent.year)) \(String(manager.selectedComponent.month)) \(String(manager.selectedComponent.day))")
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItemGroup(placement:.navigationBarTrailing) {
                    Button(action:{
                        withAnimation(.easeInOut(duration: 1)) {
                            manager.setMode(mode: nil)
                        }
                    }){
                        Label("Change Mode", systemImage: manager.mode == .Month ? "arrow.down.forward.and.arrow.up.backward" : "arrow.up.backward.and.arrow.down.forward")
                            .imageScale(.medium)
                            .foregroundColor(.red)
                    }
                }
                ToolbarItem(placement:.navigationBarLeading) {
                    Text(Calendar.current.monthSymbols[manager.page.current.month - 1])
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
#endif
