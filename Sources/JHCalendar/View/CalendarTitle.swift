//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/12/19.
//

import SwiftUI

struct CalendarTitle : View {
    
    var comp : CalendarComponents
    
    var body: some View {
        HStack{
            Text(String(comp.year))
            Text(Calendar.current.monthSymbols[comp.month - 1])
        }
        .font(.title2.bold())
    }
}

struct CalendarTitle_Previews: PreviewProvider {
    static var previews: some View {
        CalendarTitle(comp: CalendarComponents(year: 2021, month: 12, day: 4))
    }
}
