//
//  ImageModel.swift
//  MoyaSample
//
//  Created by Илья Аникин on 14.07.2022.
//

import Foundation
import SwiftUI

public struct ImageModel: Codable {
    var data: Data
}

extension Image {
    init(data: Data) {
        if let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        }
        else {
            self.init("turtlerock")
        }
    }
}


