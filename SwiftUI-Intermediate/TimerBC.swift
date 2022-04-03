//
//  TimerBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 03.04.2022.
//

import SwiftUI

struct TimerBC: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    
    //    Current Time
    /*
     @State private var currentDate = Date()
     var dateFormatter: DateFormatter {
     let formatter = DateFormatter()
     //        formatter.dateStyle = .medium //optional
     formatter.timeStyle = .medium //optional
     return formatter
     }
     */
    //    Countdown
    /*
     @State private var count = 10
     @State private var finishedText: String? = nil
     */
    //    Countdown to date
    /*
     @State private var timerRemainig = ""
     let futureDate = Calendar.current.date(byAdding: .hour, value: 5, to: Date())
     
     
     func updateTimerRemainig() {
     let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate ?? Date())
     let minute = remaining.minute ?? 0
     let second = remaining.second ?? 0
     timerRemainig = "\(minute) min and \(second) secs"
     }
     
     //    func updateTimerRemainig() {
     //        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate ?? Date())
     //        let hour = remaining.hour ?? 0
     //        let minute = remaining.minute ?? 0
     //        let second = remaining.second ?? 0
     //        timerRemainig = "\(hour):\(minute):\(second)"
     //    }
     */
//    Animation counter
    @State private var count = 0
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [Color("ColorGInner"), Color("ColorGOutter")],
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            //            Text(dateFormatter.string(from: currentDate)) //Current time
            //            Text(finishedText ?? "\(count)") //Countdown
            //       //    Countdown to date
            //             Text(timerRemainig)
            HStack(spacing: 15) {
                Circle()
                    .offset(y: count == 1 ? 150 : 0)
                Circle()
                    .offset(y: count == 2 ? -150 : 0)
                Circle()
                    .offset(y: count == 3 ? 150 : 0)
                Circle()
                    .offset(y: count == 4 ? -150 : 0)
                Circle()
                    .offset(y: count == 5 ? 150 : 0)
                Circle()
                    .offset(y: count == 6 ? -150 : 0)
            }
//            .frame(width: 150)
            .padding()
            .foregroundColor(.white)
        }
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 1.0)) {
                count = count == 6 ? 1 : count + 1
            }
        }
            //    Countdown to date
            /*
             .onReceive(timer) { _ in
             updateTimerRemainig()
             }
             */
            // Countdown
            /*
             //        .onReceive(timer) { _ in
             //            if count <= 1 {
             //                finishedText = "Wow!"
             //            } else {
             //                count -= 1
             //            }
             //        }
             */
            //current time
            /*
             //        .onReceive(timer) { value in
             //            currentDate = value
             //        }
             */
    }
}

struct TimerBC_Previews: PreviewProvider {
    static var previews: some View {
        TimerBC()
    }
}
