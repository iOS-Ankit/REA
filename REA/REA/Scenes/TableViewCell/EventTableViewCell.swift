//
//  EventTableViewCell.swift
//  REA
//
//  Created by MSS on 30/01/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    // MARK: Interface Builder Outlets
    
    @IBOutlet weak var eventTitleLbl: UILabel!
    @IBOutlet weak var eventStatusLbl: UILabel!
    @IBOutlet weak var eventStartDateLbl: UILabel!
    @IBOutlet weak var eventEndDateLbl: UILabel!
    @IBOutlet weak var eventSubTitleLbl: UILabel!
    
    // MARK: Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Display Cell Data
    
    func displayCellData(event: MyEvents) {
        eventTitleLbl.text = event.title
        eventSubTitleLbl.text = event.subtitle
        eventStartDateLbl.text = CommonFunctions.sharedInstance.formatedDate(DateFormats.format2.rawValue, event.eventStart ?? Date())
        eventEndDateLbl.text = CommonFunctions.sharedInstance.formatedDate(DateFormats.format2.rawValue, event.eventEnd ?? Date())
        
        if (event.eventStart ?? Date()) > Date() && (event.eventEnd ?? Date() > Date()) {
            eventStatusLbl.text = "Upcomming"
            eventStatusLbl.textColor = .cyan
        } else if (event.eventEnd ?? Date() < Date()) {
            eventStatusLbl.text = "Expired"
            eventStatusLbl.textColor = .gray
        } else {
            eventStatusLbl.text = "Going On"
            eventStatusLbl.textColor = .green
        }
    }
}
