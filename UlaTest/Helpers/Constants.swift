//
//  Constants.swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import UIKit

enum Constants {
    enum Network {
        static let stringURL =  "https://publicstorage.hb.bizmrg.com/sirius/result.json"
    }
    enum Errors {
        static let initError = "init(coder:) has not been implemented"
        static let serviceError = "Loading error, serverce problem"
    }
    enum Images {
        static let placeHolder = "placeHolder"
        static let forward = "chevron.forward"
    }
    enum Title {
        static let servicesTitle = "Сервисы"
    }
    
    enum Font {
        static let titleFont = UIFont.systemFont(ofSize: 18)
        static let descriptionFont =  UIFont.systemFont(ofSize: 14)
    }
}
