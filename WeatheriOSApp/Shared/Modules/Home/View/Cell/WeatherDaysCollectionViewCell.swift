//
//  WeatherDaysCollectionViewCell.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//

import UIKit

class WeatherDaysCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var daysName: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var baseView : UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        setupTheme()
    }
    
    func configureCell(daysName: String?, image: String, temp: String) {
        self.daysName.text = daysName?.ConvertStringTodayName()
        self.weatherImage.image = UIImage(systemName: "cloud.bolt.rain.fill")?.withRenderingMode(.alwaysOriginal)
        self.temp.text = "\(temp)°"
    }
}
extension WeatherDaysCollectionViewCell {

    func setupTheme(){
        self.daysName.font = theme?.fontTheme.regularMontserrat.font(20)
        self.daysName.textColor = theme?.colorTheme.colorPrimaryBlack
        self.temp.font = theme?.fontTheme.regularMontserrat.font(16)
        self.temp.textColor = theme?.colorTheme.colorPrimaryWhite
    }
}
