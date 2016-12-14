//
//  ViewController.swift
//  WorkFromWhere
//
//  Created by Grace Thompson on 12/13/16.
//  Copyright © 2016 Grace Thompson. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
    
    //cached color values 
    let white = UIColor(colorWithHexValue: 0xECEAED)
    let gray = UIColor(colorWithHexValue: 0xABB1B3)
    let black = UIColor(colorWithHexValue: 0x050505)
    let blue = UIColor(colorWithHexValue: 0x2537FA)
    let orange = UIColor(colorWithHexValue: 0xF5982F)
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!

    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "CellView") //Register the cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    //function to set up data-source protocol for calendar
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2016 12 01")!  //you can use date generated from a formatter
        let endDate = Date()
        let parameters = ConfigurationParameters(startDate: startDate,
                                                endDate: endDate,
                                                numberOfRows: 6,
                                                calendar: Calendar.current,
                                                generateInDates: .forAllMonths,
                                                generateOutDates: .tillEndOfGrid,
                                                firstDayOfWeek: .sunday)
        return parameters
    }
    //delegate protocol method to see date cells
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CellView
        
        //setup cell text
        myCustomCell.dayLabel.text = cellState.text
        
        //default cell to deselected
        myCustomCell.selectedView.isHidden = true
        
        //setup text color 
        if cellState.dateBelongsTo == .thisMonth {
            myCustomCell.dayLabel.textColor = black
        } else {
            myCustomCell.dayLabel.textColor = gray
        }
    }
    //function to select a date cell 
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        let myCustomCell = cell as! CellView
        
        //rounded corners for selected cell 
        myCustomCell.selectedView.layer.cornerRadius = 25
        
        //if selected, don't hide 
        if cellState.isSelected {
            myCustomCell.selectedView.isHidden = false
        }
    }
    //function to deselect a date cell 
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        let myCustomCell = cell as! CellView
        myCustomCell.selectedView.isHidden = true
    }
}

//color caching 
extension UIColor {
    convenience init(colorWithHexValue value: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
