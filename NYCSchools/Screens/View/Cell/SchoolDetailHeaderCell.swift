//
//  SchoolDetailHeaderCell.swift
//  NYCSchools
//
//  Created by Muthu Sabarinathan on 7/28/22.
//

import UIKit

// MARK: - SchoolListCell Class

/**
 SchoolDetailHeaderCell displays School name and overview.
*/
class SchoolDetailHeaderCell: UITableViewCell {

    // MARK: - Variables
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!

    class var identifier: String { return String(describing: self)}
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil)}
    
    var detailViewModel: SchoolDetailViewModel?
    var cellViewModel: SchoolDetailCellData? {
        didSet{
            schoolNameLabel.text = cellViewModel?.schoolName
            overViewLabel.appendReadmore(after: cellViewModel?.overview ?? "", trailingContent: .readmore)
            detailViewModel = cellViewModel?.detailViewModel
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
        
        overViewLabel.isUserInteractionEnabled = true
        overViewLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:))))

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        schoolNameLabel.text = nil
        overViewLabel.text = nil
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let text = overViewLabel.text else { return }
        guard let overviewText = cellViewModel?.overview else { return }
        let readmore = (text as NSString).range(of: TrailingContent.readmore.text)
        let readless = (text as NSString).range(of: TrailingContent.readless.text)
        if sender.didTap(label: overViewLabel, inRange: readmore) {
            overViewLabel?.appendReadLess(after: overviewText, trailingContent: .readless)
        } else if  sender.didTap(label: overViewLabel, inRange: readless) {
            overViewLabel?.appendReadmore(after: overviewText, trailingContent: .readmore)
        } else { return }
        detailViewModel?.reloadTableView?()
    }
    
}
