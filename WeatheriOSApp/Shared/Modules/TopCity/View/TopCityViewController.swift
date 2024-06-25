//
//  TopCityViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

// MARK: TopCityViewController
final class TopCityViewController: BaseTopCityViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButtonView: OTDynamicButton!
    private var router: TopCityRouter?
    private let viewModel: TopCityViewModelType
    var cityName : String?
    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    let weatherForcastApiSubject = PassthroughSubject <Parameters, Never>()
    var displayModel = TopCityDisplayModel()
    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: TopCityViewModelType,
         router: TopCityRouter) {
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
        viewDidLoadSubject.send()
        for item in 0..<self.displayModel.topCity.count {
            self.getWeather(locationString: "\(self.displayModel.topCity[item].latitude),\(self.displayModel.topCity[item].longitude)")
        }
    }
    
}

// MARK: Private Default Methods
private extension TopCityViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }

    /// Setup UI
    private func setupUI() {
        tableView.registerCell(TopCityTableCell.self)
        loadDefaultView()
    }

    /// Bind viewmodel
    private func bind(to viewModel: TopCityViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = TopCityViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(), weatherForcastApiSubject: weatherForcastApiSubject.eraseToAnyPublisher())
                
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }

    /// Render UI
    private func render(_ state: TopCityViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
            
        case .apiFailure(customError: let customError):
            showToast(message: customError.body)
        case .weatherApiSuccess(response: let response):
            if let min = response?.timelines?.minutely?.first {
                let data = TempData(time: min.time ?? "", temp: Int(min.values?.temperature ?? 0.0))
                if self.displayModel.tempData == nil {
                    self.displayModel.tempData = [TempData]()
                }
                self.displayModel.tempData?.append(data)
                print(self.displayModel.tempData)
            }

            if self.displayModel.tempData?.count == self.displayModel.topCity.count {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension TopCityViewController {
    func loadDefaultView(){
        let addButtonViewModel = OTDynamicButtonViewModel(img: theme.imageTheme.addButtonImage.withRenderingMode(.alwaysOriginal), title: "", titleFont: nil, titleColor: theme.colorTheme.clearColor, backgroundColor: theme.colorTheme.clearColor, borderColor: theme.colorTheme.clearColor, cornerRadius: 0, isHidden: false)
        self.addButtonView.configureView(viewModel: addButtonViewModel) { [weak self] sender in

            self?.router?.routeToSearch()
        }
    }
}
private extension TopCityViewController {
    
    func getWeather(locationString: String?) {
        let params: Parameters = ["location": locationString ?? "","daily": "1d","apikey": Constants.apiKey]
        weatherForcastApiSubject.send(params)
    }
}

extension TopCityViewController : SearchViewControllerDelegate{
    func getName(name: String?) {
        LocationManager.getCoordinatesFromLocationName(locationName: name ?? "") { cordinate in
            if let cordinate = cordinate {
                self.displayModel.topCity.append(cordinate)
                self.getWeather(locationString: "\(cordinate.latitude),\(cordinate.longitude)")
            }else{
                print("Failed to get location name")
            }
        }
    }
    
    
}

// MARK: Private Actions
extension TopCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayModel.tempData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopCityTableCell.nameId) as! TopCityTableCell
        cell.theme = theme
        cell.indexPath = indexPath
        let time = self.displayModel.tempData?[indexPath.row].time.convertStringToTime()
        let temp = self.displayModel.tempData?[indexPath.row].temp
        LocationManager.getLocationNameFromCoordinates(latitude: self.displayModel.topCity[indexPath.row].latitude, longitude: self.displayModel.topCity[indexPath.row].longitude) { locationName in
            
            if let locationName = locationName {
                self.cityName = locationName
                cell.configureCell(locationName: self.cityName, time: time
                                   , temp: temp?.description, imageString: "")
            } else {
                print("Failed to get location name")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
