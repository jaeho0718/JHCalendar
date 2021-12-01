//
//  File.swift
//  
//
//  Created by Lee Jaeho on 2021/11/13.
//

import Foundation

extension Date {
    
    var year : Int {
        Calendar.current.component(.year, from: self)
    }
    
    var month : Int {
        Calendar.current.component(.month, from: self)
    }
    
    var day : Int {
        Calendar.current.component(.day, from: self)
    }
    
    /// 0 : 일 , 1 : 월 , 2 : 화 , 3 :  수, 4 : 목 , 5 : 금 , 6: 토
    var weekday : Int {
        Calendar.current.component(.weekday, from: self)
    }
    
    /// 현재로부터 4년 전 Date값
    var fourYearLater : Date {
        Calendar.current.date(byAdding: .year, value: 4, to: self) ?? Date()
    }
    
    /// 현재로부터 4년 후 Date값
    var fourYearBefore : Date {
        Calendar.current.date(byAdding: .year, value: -4, to: self) ?? Date()
    }
    
}
