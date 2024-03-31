//
//  ViewController.swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import UIKit

private enum Metrics {
    static let cellHeight = 100.0
}

final class ServiceViewController: UITableViewController {
    
    //MARK: -> Properties
    private var viewModel: IServiceViewModel
    
    private var state: ScreenState = .plain {
        didSet {
            switch state  {
            case .failure: failureScreeen()
            case .loading: loadingScreeen()
            case .loaded:  loadedScreeen()
            default:  loadingScreeen()
            }
        }
    }
    //MARK: -> Life circle
    
    init(viewModel: IServiceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpController()
        setViews()
        sendRequest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ServiceViewController.errorLabel.center = view.center
        ServiceViewController.activityIndicator.center =  view.center
    }

    //MARK: -> private func
    
    private func sendRequest() {
        state = .loading
        viewModel.request(urlString: Constants.Network.stringURL)
        
        viewModel.result = {  [weak self] in
            self?.state = .loaded
            self?.tableView.reloadData()
        }
        viewModel.error = { [weak self] in
            self?.state = .failure
        }
    }
    
    private func setUpController() {
        title = Constants.Title.servicesTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .black
        tableView.register(ServiceCell.self, forCellReuseIdentifier: ServiceCell.reuseIdentifier)
    }
    
    private func setViews() {
        view.addSubviews(
            ServiceViewController.errorLabel,
            ServiceViewController.activityIndicator
        )
    }
}
//MARK: -> Extension

extension ServiceViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCell.reuseIdentifier, 
                                                 for: indexPath
                                                    )as? ServiceCell
        
        let data = viewModel.getDataForCell(indexPath: indexPath)
        cell?.configure(model: data)
        
        let disclosureImageView = viewModel.getDisclosureImageView()
        cell?.accessoryView = disclosureImageView
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Metrics.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = viewModel.didSelectedCell(indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

