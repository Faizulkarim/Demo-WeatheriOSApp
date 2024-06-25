//
//  SearchTableCell.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchTableCellDelegate: AnyObject {}

class SearchTableCell: BaseTableViewCell {
    
    static let height: CGFloat = 50
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    weak var delegate: SearchTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTheme()
    }
    
    func configureCell(title: String, subTitle: String) {
        self.title.text = title
        self.subTitle.text = subTitle
    }
}

//MARK: Cell Configuration
extension SearchTableCell {
    
    func setupTheme(){
        self.title.font = theme?.fontTheme.regularMontserrat.font(14)
        self.subTitle.font = theme?.fontTheme.regularMontserrat.font(12)
    }
    
}
