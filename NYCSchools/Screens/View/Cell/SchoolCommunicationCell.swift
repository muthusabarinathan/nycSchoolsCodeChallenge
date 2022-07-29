//
//  SchoolCommunicationCell.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/28/22.
//

import UIKit

// MARK: - SchoolListCell Class

/**
 SchoolCommunicationCell displays Schools communication details.
*/
class SchoolCommunicationCell: UITableViewCell {

   // MARK: - Variables
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var timingLabel: UILabel!
    
    class var identifier: String { return String(describing: self)}
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)}
    
    var cellViewModel: SchoolDetailCellData? {
        didSet{
            addressLabel.text = cellViewModel?.address
            phoneLabel.text = cellViewModel?.phoneNumber
            emailLabel.text = cellViewModel?.email
            websiteLabel.text = cellViewModel?.websiteLink
            timingLabel.text = cellViewModel?.timing
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialize view
        initView()
    }

    func initView() {
        // Cell view custmozation
        backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        addressLabel.text = nil
        phoneLabel.text = nil
        emailLabel.text = nil
        websiteLabel.text = nil
        timingLabel.text = nil
    }
}
