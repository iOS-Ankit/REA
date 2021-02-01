//
//  ViewController.swift
//  News
//
//  Created by Ankit on 30/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Interface Builder Outlets
    
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Interface Builder Properties
    
    var myEventsList = [MyEvents]()
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVw.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchEvents()
    }
    
    func fetchEvents() {
        activityIndicator.startAnimating()
        let eventsVM = EventsVCViewModel()
        eventsVM.fetchEvents { (events, errorString) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if let error = errorString {
                    self.showAlert(error)
                } else {
                    if let list = events {
                        self.myEventsList = list
                        self.tblVw.reloadData()
                    } else {
                        self.showAlert("There is no event found. Please add and try again.")
                    }
                }
            }
        }
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Event APP", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Interface Builder Actions
    
    @IBAction func chengeView(sender: UIBarButtonItem) {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "CalendarVwViewController") as! CalendarVwViewController
        destinationVC.eventList = self.myEventsList
        let navController = UINavigationController(rootViewController: destinationVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func addEvent(sender: UIBarButtonItem) {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEventViewController") as! AddEventViewController
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myEventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        cell.displayCellData(event: myEventsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
