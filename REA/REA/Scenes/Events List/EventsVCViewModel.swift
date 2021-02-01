//
//  Extensions.swift
//  REA
//
//  Created by MSS on 30/01/21.
//

import Foundation
import CoreData

class EventsVCViewModel {
    
    func fetchEvents(completion : @escaping ([MyEvents]?, String?) -> ()){
        let fetchedEvents: NSFetchRequest<MyEvents> = MyEvents.fetchRequest()
        do {
            let events = try PresistanceService.context.fetch(fetchedEvents)
            completion(events, nil)
        } catch {
            completion(nil, "There is no event found. Please add and try again.")
        }
    }
}
