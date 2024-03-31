//
//  ViewModel.swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import UIKit

protocol IServiceViewModel {
    var result: (() -> Void)? {get set}
    var error: (() -> Void)? {get set}
    var numberOfRowsInSection: Int {get}
    
    func didSelectedCell(_ indexPath: IndexPath) -> DetailViewController
    func request(urlString: String)
    func getDataForCell(indexPath: IndexPath) -> CellModel
    
    func getDisclosureImageView() -> UIImageView 
}

final class ServiceViewModel: IServiceViewModel  {
    
    private var networkService: INetworkService
    private var data = [ServiceModel]()
    
    var numberOfRowsInSection: Int {return self.data.count}
    var result: (() -> Void)?
    var error: (() -> Void)?
    
    init ( networkService: INetworkService) {
        self.networkService = networkService
    }
    
    func didSelectedCell(_ indexPath: IndexPath) -> DetailViewController {
        let url = data[indexPath.row].link
        let vc = DetailViewController(stringURL: url)
        return vc
    }
    
    func request(urlString: String){
        networkService.getDataAdvertisement(urlString: urlString) {  result in
            switch result {
            case .success(let response):
                self.data = response.body.services
                self.result?()
            case .failure(_):
                self.error?()
            }
        }
    }
    
    func getDataForCell(indexPath: IndexPath) -> CellModel {
        let index = indexPath.row
        let arrayData = data[index]
        return  CellModel(
                    name: arrayData.name,
                    description: arrayData.description,
                    iconUrl: arrayData.iconUrl,
                    id: String(index)
                )
    }
    
    func getDisclosureImageView() -> UIImageView {
        let customDisclosureImage = UIImage(systemName: Constants.Images.forward)
        let disclosureImageView = UIImageView(image: customDisclosureImage)
        disclosureImageView.tintColor = UIColor.darkGray
        return disclosureImageView
    }
}
