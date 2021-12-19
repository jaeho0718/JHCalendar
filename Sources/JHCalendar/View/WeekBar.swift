//
//  SwiftUIView.swift
//  
//
//  Created by Lee Jaeho on 2021/12/19.
//

import SwiftUI

public struct JHWeekBar : View {
    
    var weeks = [String]()
    var symbolType : CalendarSymbolType = .short
    var font : Font? = nil
    
    public var body: some View {
        HStack(spacing:0){
            Group{
                if weeks.count == 7 {
                    ForEach(weeks,id:\.self) { week in
                        Text(week)
                    }
                } else {
                    switch symbolType {
                    case .veryshort:
                        ForEach(Calendar.current.veryShortWeekdaySymbols,id : \.self) { week in
                            Text(week)
                        }
                    case .short:
                        ForEach(Calendar.current.shortWeekdaySymbols,id : \.self) { week in
                            Text(week)
                        }
                    }
                }
            }
            .frame(maxWidth:.infinity)
            .font(font)
        }
    }
}

struct WeekBar_Previews: PreviewProvider {
    static var previews: some View {
        JHWeekBar()
    }
}
