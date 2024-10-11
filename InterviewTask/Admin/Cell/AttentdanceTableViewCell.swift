//
//  AttentdanceTableViewCell.swift
//  InterviewTask
//
//  Created by j on 08/10/24.
//

import UIKit

class AttentdanceTableViewCell: UITableViewCell {

    @IBOutlet weak var lblcheckIn: UILabel!
    @IBOutlet weak var lblcheckOut: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTotalHours: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(attendanceData: AttendanceHistoryModel) {
        lblcheckIn.text = attendanceData.checkintime
        lblcheckOut.text = attendanceData.checkouttime
        lblDate.text = attendanceData.date
        lblTotalHours.text = attendanceData.totalhours
    }
}
