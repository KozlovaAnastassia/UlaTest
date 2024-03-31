//
//  Formuls.swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import Foundation

final class Formuls {
    static func extractWordFromURL(urlString: String) -> String? {
        if let url = URL(string: urlString), let host = url.host {
            let components = host.components(separatedBy: ".")
            let component = components[0] + "://"
            print(component)
         return component
        }
        return nil
    }
}
