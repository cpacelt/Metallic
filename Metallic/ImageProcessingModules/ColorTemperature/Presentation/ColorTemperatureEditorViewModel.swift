//
//  ColorTemperatureEditorViewModel.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import Foundation
import SwiftUI

final class ColorTemperatureEditorViewModel<Units: BinaryFloatingPoint>
where Units.Stride: BinaryFloatingPoint {
    
    private let numberFormatter: NumberFormatter = .init()
    
    @Published private var cgImage: CGImage?
    @Published private var cgImagePlaceHolder: CGImage
    @Published private(set) var imageScale: CGFloat = 1.0
    @Published private(set) var valueRagnge: ClosedRange<Units> = 0...100
    @Published var sliderValue: Units = 0
    
    @Published private(set) var headerTitle: String = "Let's go!\nChange the picture's  color temperature!"
    @Published private(set) var sliderMinTitle: String = "❄️"
    @Published private(set) var sliderMaxTitle: String = "🔥"
    
    var image: CGImage {
        cgImage ?? cgImagePlaceHolder
    }
    
    var formatedSliderValue: String {
        let nsNumber = NSNumber(value: sliderValue as! Float)
        return numberFormatter.string(from: nsNumber) ?? "0.0"
    }
    
    init() {
        self.cgImagePlaceHolder = .cgImagePlaceholder
    }
    
}

extension ColorTemperatureEditorViewModel {
    func onSliderEditingEndedHandler(isEnded: Bool) {
        return
    }
}
extension ColorTemperatureEditorViewModel: ObservableObject {}

