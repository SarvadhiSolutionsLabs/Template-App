//
//  NotificationManager.swift
//  Template
//
//  Created by Avadh on 12/07/22.
//

import Foundation
import UserNotifications

enum NotificationManagerConstants {
  static let timeBasedNotificationThreadId =
    "TimeBasedNotificationThreadId"
  static let calendarBasedNotificationThreadId =
    "CalendarBasedNotificationThreadId"
  static let locationBasedNotificationThreadId =
    "LocationBasedNotificationThreadId"
}

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func removeScheduledNotification(task: UserTask?) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [(task?.id ?? 0).toString])
    }
    
    // 1
    func scheduleNotification(task: UserTask?) {
        // 2
        let content = UNMutableNotificationContent()
        content.title = task?.task_name ?? ""
        content.body = task?.task_description ?? ""
        content.categoryIdentifier = "TaskCategory"
        let taskData = task?.toJSON()
        if let taskData = taskData {
            content.userInfo = ["Task": taskData]
        }
        
        // 3
        var trigger: UNNotificationTrigger?
        if let timeInterval = task?.reminder_time?.toDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ") {
            trigger = UNCalendarNotificationTrigger(
                dateMatching: Calendar.current.dateComponents(
                    [.day, .month, .year, .hour, .minute],
                    from: timeInterval),
                repeats: false)
        }
        content.threadIdentifier = NotificationManagerConstants.calendarBasedNotificationThreadId
        
        if let trigger = trigger {
            let request = UNNotificationRequest(
                identifier: (task?.id ?? 0).toString,
                content: content,
                trigger: trigger)
            // 5
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print(error)
                }
            }
        }
    }
}
