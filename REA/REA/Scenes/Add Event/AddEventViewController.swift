//
//  AddEventViewController.swift
//  REA
//
//  Created by MSS on 30/01/21.
//

import UIKit
import EventKit

enum DateFormats: String {
    
    /**
     "hh:mm a"
     */
    case format1 = "hh:mm a"
    
    /**
     "dd MMM Y  hh:mm a"
     */
    case format2 = "dd MMM Y  hh:mm a"
}

class AddEventViewController: UIViewController {
    
    // MARK: Interface Builder Outlets
    
    @IBOutlet weak var eventTitleTxtf: UITextField!
    @IBOutlet weak var eventSubTTxtVw: UITextView!
    @IBOutlet weak var eventStartTxtf: UITextField!
    @IBOutlet weak var eventEndTxtf: UITextField!
    @IBOutlet weak var saveEventBtn: UIButton!
    
    // MARK: Interface Builder Properties
    
    var startDate: Date?
    var endDate: Date?
    let datePicker = UIDatePicker()
    var eventStore = EKEventStore()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        eventSubTTxtVw.layer.borderWidth = 1
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        eventStartTxtf.inputView = datePicker
        eventEndTxtf.inputView = datePicker
    }
    
    func addReminder() {
     eventStore.requestAccess(to: EKEntityType.reminder, completion: {
      granted, error in
      if (granted) && (error == nil) {
        print("granted \(granted)")

        let reminder:EKReminder = EKReminder(eventStore: self.eventStore)
        reminder.title = self.eventTitleTxtf.text_Trimmed()
        reminder.priority = 2

        if let reminderDate = Calendar.current.date(byAdding: .minute, value: -15, to: self.startDate ?? Date()) {
            let alarm = EKAlarm(absoluteDate: reminderDate)
            reminder.addAlarm(alarm)
        }

        reminder.calendar = self.eventStore.defaultCalendarForNewReminders()

        do {
          try self.eventStore.save(reminder, commit: true)
        } catch {
          print("Cannot save")
          return
        }
        print("Reminder saved")
      }
     })

    }
    
    // MARK: Validate
    
    func validateTextfields() -> Bool {
        let isValid = true
        if !self.validateRequired(eventTitleTxtf.text ?? "") {
            CommonFunctions.sharedInstance.showAlert("Please add event title", vc: self)
            return false
        } else if !self.validateRequired(eventStartTxtf.text ?? "") {
            CommonFunctions.sharedInstance.showAlert("Please select event start date", vc: self)
            return false
        } else if !self.validateRequired(eventEndTxtf.text ?? "") {
            CommonFunctions.sharedInstance.showAlert("Please select event end date", vc: self)
            return false
        }
        return isValid
    }
    
    
    // MARK: Validator
    
    func validateRequired(_ text: String) -> Bool {
        if text.trimmingCharacters(in: .whitespaces) == "" {
            return false
        }
        return true
    }
    
    //  MARK: Handel Date Picker
    
    @objc func selectDate(_ sender: UIDatePicker) {
        let dateStr = CommonFunctions.sharedInstance.formatedDate(DateFormats.format2.rawValue, sender.date)
        if sender.tag == 1 {
            startDate = sender.date
            eventStartTxtf.text = dateStr
        } else {
            endDate = sender.date
            eventEndTxtf.text = dateStr
        }
    }
    
    // MARK: Interface Builder Actions
    
    @IBAction func saveEventBtnAction(sender: UIButton) {
        if validateTextfields() {
            let event = MyEvents(context: PresistanceService.context)
            event.title = eventTitleTxtf.text_Trimmed()
            event.subtitle = eventSubTTxtVw.text_Trimmed()
            event.eventStart = startDate
            event.eventEnd = endDate
            PresistanceService.saveContext()
            addReminder()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension AddEventViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == eventEndTxtf {
            datePicker.tag = 2
            if eventStartTxtf.text == "" || startDate == nil {
                CommonFunctions.sharedInstance.showAlert("Please select event start date first", vc: self)
                return false
            } else {
                datePicker.minimumDate = startDate
            }
        } else {
            datePicker.tag = 1
            datePicker.minimumDate = Date()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if datePicker.tag == 1 {
            endDate = nil
            eventEndTxtf.text = ""
        }
        datePicker.addTarget(self, action: #selector(selectDate(_:)), for: .valueChanged)
    }
}


