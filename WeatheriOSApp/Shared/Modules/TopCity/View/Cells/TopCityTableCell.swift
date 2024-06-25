//
//  TopCityTableCell.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol TopCityTableCellDelegate: AnyObject {}

class TopCityTableCell: BaseTableViewCell {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var temp: UILabel!
    weak var delegate: TopCityTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTheme()
    }
    
    func configureCell(locationName: String? , time: String?, temp: String?, imageString: String?) {
        self.location.text = locationName
        self.time.text = time
        self.temp.text = "\(temp ?? "")°"
        self.weatherImage.image = UIImage(systemName: "cloud.fill")
    }
}

//MARK: Cell Configuration
extension TopCityTableCell {
    
    func setupTheme(){
        self.baseView.addShadowWithCornerRedious(color: UIColor.gray, opacity: 0.5, sizeX: 0.5, sizeY: 0.5, shadowRadius: 1.5, cornerRadius: 5)
        self.location.font = theme?.fontTheme.regularMontserrat.font(18)
        self.location.textColor = theme?.colorTheme.colorPrimaryBlack
        self.time.font = theme?.fontTheme.regularMontserrat.font(12)
        self.time.textColor = theme?.colorTheme.colorPrimaryBlack
        self.temp.font = theme?.fontTheme.regularMontserrat.font(25)
        self.temp.textColor = theme?.colorTheme.colorPrimaryBlack
    }
    
}
