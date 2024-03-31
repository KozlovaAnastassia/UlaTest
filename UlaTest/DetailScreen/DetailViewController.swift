//
//  DetailViewController.swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import UIKit
import WebKit

final class DetailViewController: UIViewController {
    
    //MARK: -> Properties
    private let webView = WKWebView()
    private var stringURL: String
    
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
    init(stringURL: String) {
        self.stringURL = stringURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.Errors.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setupLayout()
        openApp(stringURL: stringURL)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DetailViewController.errorLabel.center = view.center
        DetailViewController.activityIndicator.center =  view.center
    }

    //MARK: -> Functions
    
    private func setUpViews(){
        state = .loading
        view.backgroundColor = .white
        
        view.addSubviews(
            webView,
            DetailViewController.errorLabel,
            DetailViewController.activityIndicator
        )
    }

    private func setupLayout() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            webView.topAnchor.constraint(equalTo: margins.topAnchor),
            webView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    private func getAppUrl(url: String) -> URL? {
        if let appURLString = Formuls.extractWordFromURL(urlString: url) {
            let appURL = URL(string: appURLString)
            return appURL
        }
        return nil
    }
    
    private func openApp(stringURL: String) {
        if isAppInstalled(url: stringURL) {
            if let appURL = getAppUrl(url: stringURL), UIApplication.shared.canOpenURL(appURL) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                if let url = URL(string: stringURL) {
                    let request = URLRequest(url: url)
                    self?.webView.load(request)
                    self?.state = .loaded
                }
            }
        }
    }
    
    private func isAppInstalled(url: String) -> Bool {
        if let appURL = getAppUrl(url: url) {
            return UIApplication.shared.canOpenURL(appURL)
        }
        return false
    }
}


