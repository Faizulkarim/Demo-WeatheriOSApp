//
//  HomeViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine
import CoreLocation

// MARK: HomeViewController
final class HomeViewController: BaseHomeViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var weekdaysWeatherCollectionView: UICollectionView!
    @IBOutlet weak var currentLocationName: UILabel!
    @IBOutlet weak var currentLocationTemp: UILabel!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var refreshButton : UIButton!
    @IBOutlet weak var time: UILabel!
    
    private var router: HomeRouter?
    private let viewModel: HomeViewModelType
    
    var locationManager: CLLocationManager!
    var displayModel = HomeDisplayModel()
    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    let weatherForcastApiSubject = PassthroughSubject <Parameters, Never>()
    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: HomeViewModelType,
         router: HomeRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(analyticsManager: analyticsManager, theme: theme)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind(to: viewModel)
        setupRouter()
        setupLocationManeger()
        viewDidLoadSubject.send()
    }
    
}

private extension HomeViewController {
    func getWeather(locationString: String?) {
        let params: Parameters = ["location": locationString ?? "","daily": "1d","apikey": Constants.apiKey]
        weatherForcastApiSubject.send(params)
    }
}

// MARK: Private Default Methods
private extension HomeViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }
    
    func setupLocationManeger() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    /// Setup UI
    private func setupUI() {
        self.baseView.addLinearGradient(startPoint: CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint(x: 1.0, y: 1.0), startColor: UIColor.blue, endColor: UIColor.white)
        self.currentLocationName.text = "Unknown"
        self.currentLocationName.font = theme.fontTheme.regularMontserrat.font(35)
        self.currentLocationName.textColor = theme.colorTheme.colorPrimaryWhite
        self.weatherConditionImage.image = UIImage(systemName: "cloud.rain")?.withRenderingMode(.alwaysOriginal)
        self.currentLocationTemp.text = "Unknown"
        self.currentLocationTemp.font = theme.fontTheme.regularMontserrat.font(60)
        self.currentLocationTemp.textColor = theme.colorTheme.colorPrimaryWhite
        self.time.font = theme.fontTheme.regularMontserrat.font(25)
        self.time.textColor = theme.colorTheme.colorPrimaryWhite
        weekDayscollectionViewSetup()
        refreshButton.handleTapToAction {
            self.getWeather(locationString: "\(self.displayModel.currentLocation?.latitude ?? 0.0),\(self.displayModel.currentLocation?.longitude ?? 0.0)")
        }
    }
    func weekDayscollectionViewSetup(){
        weekdaysWeatherCollectionView.register(UINib(nibName: "WeatherDaysCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "WeatherDaysCollectionViewCell")
        weekdaysWeatherCollectionView.delegate = self
        weekdaysWeatherCollectionView.dataSource = self
    }

    /// Bind viewmodel
    private func bind(to viewModel: HomeViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = HomeViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(), weatherForcastApiSubject: weatherForcastApiSubject.eraseToAnyPublisher())
                
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }

    /// Render UI
    private func render(_ state: HomeViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
        case .apiFailure(customError: let customError):
            showToast(message: customError.body)
        case .weatherApiSuccess(response: let response):
            self.displayModel.weatherData = response
            let temp = Int(response?.timelines?.minutely?.first?.values?.temperature ?? 0.0)
            self.currentLocationTemp.text = "\(temp)°"
            self.time.text = response?.timelines?.minutely?.first?.time?.convertStringToTime()
            self.weekdaysWeatherCollectionView.reloadData()
        }
    }
    
}

// MARK: Private Actions
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.displayModel.weatherData?.timelines?.daily?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            String(describing: WeatherDaysCollectionViewCell.self),
                                                         for: indexPath) as? WeatherDaysCollectionViewCell {
            cell.theme = theme
            cell.indexPath = indexPath
            let daily = self.displayModel.weatherData?.timelines?.daily?[indexPath.row]
            let temp = Int(daily?.values?.temperatureAvg ?? 0.0)
            cell.configureCell(daysName: daily?.time, image: "", temp: temp.description)
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemCount = self.displayModel.weatherData?.timelines?.daily?.count ?? 0
        let width = self.weekdaysWeatherCollectionView.frame.width / CGFloat(itemCount)
        let adjustedWidth = width - 5
        return CGSize(width: adjustedWidth, height: self.weekdaysWeatherCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
        
    }
}

extension HomeViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else {
            return
        }
        self.displayModel.currentLocation = userLocation.coordinate
        LocationManager.getLocationNameFromCoordinates(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude) { locationName in
            if let locationName = locationName {
                self.currentLocationName.text = locationName
            } else {
                print("Failed to get location name")
            }
        }
        let locationString = "\(userLocation.coordinate.latitude),\(userLocation.coordinate.longitude)"
        self.getWeather(locationString: locationString)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
