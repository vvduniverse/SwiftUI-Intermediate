//
//  LocalNotificationBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 25.03.2022.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationsManager {
    static let instance = NotificationsManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!"
        content.subtitle = "This was soooo easy!"
        content.sound = .default
        content.badge = 1
        
        // time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 12
//        dateComponents.minute = 3
//        dateComponents.weekday = 5
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location
        let coordinates = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
        
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationBC: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationsManager.instance.requestAuthorization()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Schedule notification") {
                NotificationsManager.instance.scheduleNotification()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Cancel notification") {
                NotificationsManager.instance.cancelNotification()
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationBC_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBC()
    }
}
