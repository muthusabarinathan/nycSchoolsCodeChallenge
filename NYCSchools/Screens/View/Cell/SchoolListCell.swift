//
//  SchoolListCell.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/26/22.
//

import UIKit

// MARK: - SchoolListCell Class

/**
 SchoolListCell displays School name.
*/
class SchoolListCell: UITableViewCell {
    
    // MARK: - Variables
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    class var identifier: String { return String(describing: self)}
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)}
    
    var cellViewModel: SchoolListCellData? {
        didSet{
            schoolNameLabel.text = cellViewModel?.schoolName
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
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        schoolNameLabel.text = nil
    }
}
