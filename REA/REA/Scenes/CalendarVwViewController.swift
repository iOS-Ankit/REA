//
//  CalendarVwViewController.swift
//  REA
//
//  Created by Ankit on 30/01/21.
//

import UIKit
import CalendarKit

class CalendarVwViewController: DayViewController {
    
    // MARK: Interface Builder Properties
    
    var eventList = [MyEvents]()
    var colors = [UIColor.blue, UIColor.yellow, UIColor.green, UIColor.red]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayView.autoScrollToFirstEvent = true
        dayView.isHeaderViewVisible = true
    }
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        let models = eventList
        var events = [Event]()
        for model in models {
            let event = Event()
            event.startDate = model.eventStart ?? Date()
            event.endDate = model.eventEnd ?? Date()
            event.text = "\(model.title ?? "") \n \(model.subtitle ?? "")"
            event.color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
            event.backgroundColor = event.color.withAlphaComponent(0.9)
            event.textColor = UIColor.brown
            events.append(event)
        }
        return events
    }
}
