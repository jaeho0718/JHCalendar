//
//  File.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//
import SwiftUI

struct WeekBar: View {
    @Environment(\.calendarWeekFont) var weekdayFont
    @Environment(\.calendarWeekSymbols) var weekdaySymbols
    @Environment(\.calendarWeekColor) var weekdayColor
    
    var body: some View {
        HStack{
            if weekdaySymbols.count != 7 {
                ForEach(Calendar.current.shortWeekdaySymbols, id : \.self){ symbol in
                    Text(symbol).frame(maxWidth:.infinity)
                        .font(weekdayFont).foregroundColor(weekdayColor)
                }
            } else {
                ForEach(weekdaySymbols, id : \.self){ symbol in
                    Text(symbol).frame(maxWidth:.infinity)
                        .font(weekdayFont).foregroundColor(weekdayColor)
                }
            }
        }
    }
}

struct WeekBar_Previews: PreviewProvider {
    static var previews: some View {
        WeekBar()
    }
}
