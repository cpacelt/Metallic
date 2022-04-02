//
//  ColorTemperatureEditorViewModel.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import Foundation
import SwiftUI

// MARK: ColorTemperatureEditorViewModel protocol
protocol ColorTemperatureEditorViewModel: ObservableObject {
    associatedtype Units: BinaryFloatingPoint where Units.Stride: BinaryFloatingPoint
    
    var image: CGImage { get }
    var imageScale: CGFloat { get }
    var valueRange: ClosedRange<Units> { get }
    var sliderValuePublisher: Binding<Units> { get }
    var headerTitle: String { get }
    var sliderMinTitle: String { get }
    var sliderMaxTitle: String { get }
    var formatedSliderValue: String { get }
    
    func onSliderEditingEndedHandler(isEnded: Bool) -> Void
}

// MARK: ColorTemperatureEditorViewModelImpl
final class ColorTemperatureEditorViewModelImpl<Units: BinaryFloatingPoint, ChangeImageColorTemperatureUC: ChangeImageColorTemperatureUseCase>
where Units.Stride: BinaryFloatingPoint {
    
    //MARK: UseCases
    private let changeImageColorTemperatureUseCase: ChangeImageColorTemperatureUC
    private let numberFormatter: NumberFormatter = .init()
    
    @Published private var cgImage: CGImage?
    @Published private var cgImagePlaceHolder: CGImage
    @Published private var sliderValue: Units = 0
    @Published private(set) var imageScale: CGFloat = 1.0
    @Published private(set) var valueRange: ClosedRange<Units> = 0...100
    
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
    
    var sliderValuePublisher: Binding<Units> {
        .init(get: { self.sliderValue },
              set: { newValue in self.sliderValue = newValue })
    }
    
    // MARK: Init
    init(_ changeImageColorTemperatureUseCase: ChangeImageColorTemperatureUC) {
        self.changeImageColorTemperatureUseCase = changeImageColorTemperatureUseCase
        self.cgImagePlaceHolder = .cgImagePlaceholder
    }
    
}

// MARK: ColorTemperatureEditorViewModelImpl extension
extension ColorTemperatureEditorViewModelImpl: ColorTemperatureEditorViewModel {
    func onSliderEditingEndedHandler(isEnded: Bool) {
        return
    }
}

extension ColorTemperatureEditorViewModelImpl: ObservableObject {}
