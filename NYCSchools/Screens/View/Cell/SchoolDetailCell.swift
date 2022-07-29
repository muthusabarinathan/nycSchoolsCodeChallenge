//
//  SchoolDetailCell.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/28/22.
//

import UIKit

// MARK: - SchoolListCell Class

/**
 SchoolDetailCell displays Schools SAT data.
*/
class SchoolDetailCell: UITableViewCell {

    // MARK: - Variables
    
    @IBOutlet weak var numberOfSATTestTakersLabel: UILabel!
    @IBOutlet weak var avgMathScoreLabel: UILabel!
    @IBOutlet weak var avgReadingScoreLabel: UILabel!
    @IBOutlet weak var avgWritingScoreLabel: UILabel!
    @IBOutlet weak var eligibilityLabel: UILabel!
    
    class var identifier: String { return String(describing: self)}
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)}
    
    var cellViewModel: SchoolDetailCellData? {
        didSet{
            numberOfSATTestTakersLabel.text = cellViewModel?.numberOfSATTestTakers
            avgMathScoreLabel.text = cellViewModel?.avgMathScore
            avgReadingScoreLabel.text = cellViewModel?.avgReadingScore
            avgWritingScoreLabel.text = cellViewModel?.avgWritingScore
            eligibilityLabel.text = cellViewModel?.eligibility
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
        numberOfSATTestTakersLabel.text = nil
        avgMathScoreLabel.text = nil
        avgReadingScoreLabel.text = nil
        avgWritingScoreLabel.text = nil
        eligibilityLabel.text = nil
    }
    
}
