//
//  SearchViewController.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine
import MapKit

protocol SearchViewControllerDelegate: AnyObject {
    func getName(name: String?)
}
// MARK: SearchViewController
final class SearchViewController: BaseSearchViewController {
    
    // MARK: Variables
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: OTDynamicButton!
    @IBOutlet weak var searchTextField: UITextField!
    private var router: SearchRouter?
    private let viewModel: SearchViewModelType
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    var delegate: SearchViewControllerDelegate?
    // MARK: Interactions
    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()

    // MARK: Init Functions
    init(analyticsManager: AnalyticsManager,
         theme: Theme,
         viewModel: SearchViewModelType,
         router: SearchRouter) {
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
        searchCompleter.delegate = self
    }
    
}

// MARK: Private Default Methods
private extension SearchViewController {
    
    /// Setup router
    private func setupRouter() {
        router?.navigationController = navigationController
        router?.viewController = self
    }

    /// Setup UI
    private func setupUI() {
        tableView.registerCell(SearchTableCell.self)
        loadDefaultView()
        self.searchTextField.delegate = self
    }

    /// Bind viewmodel
    private func bind(to viewModel: SearchViewModelType) {
        /// Clear all observer
        disposeBag.cancel()
        let input = SearchViewModelInput(viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher())
                
        let output = viewModel.transform(input: input)
        output.viewState.sink(receiveValue: {[weak self] state in
            self?.render(state)
        }).store(in: disposeBag)
    }

    /// Render UI
    private func render(_ state: SearchViewState) {
        switch state {
        case .viewDidLoad:
            break
        case .loading(let shouldShow):
            shouldShow ? addLoadIndicator() : removeLoadIndicator()
        }
    }
    
}
extension SearchViewController {
    func loadDefaultView(){
        let backButtonViewModel = OTDynamicButtonViewModel(img: theme.imageTheme.navBack.withRenderingMode(.alwaysOriginal), title: "", titleFont: nil, titleColor: theme.colorTheme.clearColor, backgroundColor: theme.colorTheme.clearColor, borderColor: theme.colorTheme.clearColor, cornerRadius: 0, isHidden: false)
        self.backButton.configureView(viewModel: backButtonViewModel) { [weak self] sender in
            
            self?.router?.back()
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         // Get the updated text after the user input
         if let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
             searchCompleter.queryFragment = text
            
         }
         return true
     }
}

extension SearchViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Search failed with error: \(error.localizedDescription)")
    }
}

// MARK: Private Actions
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableCell.nameId) as! SearchTableCell
        cell.theme = theme
        cell.indexPath = indexPath
        let result = searchResults[indexPath.row]
        cell.configureCell(title: result.title, subTitle: result.subtitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.getName(name: self.searchResults[indexPath.row].title)
        self.router?.back()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
