# ``JHCalendar``

SwiftUI Customizable Calendar Library

## Overview

SwiftUI에서 사용할 수 있는 커스텀 가능한 캘린더 라이브러리입니다.

## 기본 사용

```swift
    import SwiftUI

    struct ContentView : View {

        @StateObject var calendarManager = CalendarManger(start: .startDefault, 
                                                          end: .endDefault, 
                                                          point: .currentDefault)

        var body : some View {
            JHCalendar(content: { component in 
                DefaultCalendarDayView(component: component)
            })
            .environmentObject(calendarManager)
        }
    }
```

## 가이드라인

- CalendarManager 선언하기

    - CalendarManager는 캘린더의 데이터를 관리하는 ObservableObject를 채택한 클래스입니다. (**필수**)
    
    ```swift
        CalendarManger(start: .startDefault, end: .endDefault, point: .currentDefault)
    ```
    
    - start : 캘린더의 첫 페이지 (startDefault는 현재날짜를 기준으로부터 2년 전을 첫 페이지로 합니다.)
    - end : 캘린더의 마지막 페이지 (endDefault는 현재날짜를 기준으로부터 2년 후를 마지막 페이지로 합니다.)
    - point : 캘린더 시작 위치 (currentDefault는 현재날짜를 캘린더 시작위치로 합니다.)

- JHCalendar 선언하기

    - 캘린더뷰입니다.

    ```swift
        JHCalendar(content: { component in 
            DefaultCalendarDayView(component: component)
        })
    ```

    - content : 캘린더의 요일을 표시하는데 쓰일 뷰입니다. (사전정의된 DefaultCalendarDayView를 이용할 수 있습니다.)

    - component : 표시될 요일에 대한 구체적인 정보가 담긴 구조체입니다.

        ```swift
            struct CalendarComponent {
                var year : Int
                var month : Int
                var day : Int
            }
        ```

- EnvironmentKey

    - 캘린더의 세팅값을 변경할 수 있는 EnvironmentKey 입니다.

    ```swift
        JHCalendar(content: { component in 
            DefaultCalendarDayView(component: component)
        })
        .environment(\.calendarHeight, 60)
        .environment(\.calendarWeekSymbols, ["월요일","화요일","수요일","목요일","금요일","토요일","일요일"])
        .environment(\.calendarShowTitle, true)
        .environment(\.calendarWeekFont, .callout)
        .environment(\.calendarWeekColor, .secondary)
    ```

    - calendarHeight : 캘린더 요일셀의 기본 높이입니다. 기본값은 50 입니다.
    
    - calendarWeekSymbols : 캘린더의 주일을 나타내는 심볼입니다. 기본적으로 지역화된 요일값이 들어갑니다.

    - calendarShowTitle : 캘린더의 년/월 타이틀 표시여부

    - calendarWeekFont : 캘린더의 표시된 주일 폰트

    - calendarWeekColor : 캘린더에 표시된 주일 색상
