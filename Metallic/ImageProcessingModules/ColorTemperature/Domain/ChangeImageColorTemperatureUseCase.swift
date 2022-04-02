//
//  ChangeImageColorTemperatureUseCase.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import Foundation
import Combine
import CoreGraphics

// MARK: ImageProcessingError
enum ImageProcessingError: Error {
    case fail
}

// MARK: ChangeImageColorTemperatureUseCase
protocol ChangeImageColorTemperatureUseCase {
    func execute(image: CGImage, value: Float) -> Future<CGImage, ImageProcessingError>?
}

// MARK: ChangeImageColorTemperatureUseCaseImpl
final class ChangeImageColorTemperatureUseCaseImpl {
    
}

// MARK: ChangeImageColorTemperatureUseCaseImpl extension
extension ChangeImageColorTemperatureUseCaseImpl: ChangeImageColorTemperatureUseCase {
    func execute(image: CGImage, value: Float) -> Future<CGImage, ImageProcessingError>? {
        nil
    }
}
