//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import SwiftUI

struct CalendarTitle: View {
    
    @EnvironmentObject var manager : CalendarManger
    
    var body: some View {
        HStack{
            Text(String(manager.currentPage.year))
            Text("\( Calendar.current.monthSymbols[manager.currentPage.month - 1])")
        }.font(.title3.weight(.semibold))
    }
    
}

struct CalendarTitle_Previews: PreviewProvider {
    static var previews: some View {
        CalendarTitle()
            .environmentObject(CalendarManger())
    }
}

