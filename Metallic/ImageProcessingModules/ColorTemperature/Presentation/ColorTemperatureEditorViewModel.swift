//
//  ColorTemperatureEditorViewModel.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import Foundation
import SwiftUI
import Combine

// MARK: ColorTemperatureEditorViewModel protocol
protocol ColorTemperatureEditorViewModel: ObservableObject {
    var image: CGImage { get }
    var imageScale: CGFloat { get }
    var valueRange: ClosedRange<Float> { get }
    var sliderValuePublisher: Binding<Float> { get }
    var headerTitle: String { get }
    var sliderMinTitle: String { get }
    var sliderMaxTitle: String { get }
    var formatedSliderValue: String { get }
    
    func onSliderEditingEndedHandler(isEnded: Bool) -> Void
}

// MARK: ColorTemperatureEditorViewModelImpl
final class ColorTemperatureEditorViewModelImpl<ChangeImageColorTemperatureUC: ChangeImageColorTemperatureUseCase> {
    
    //MARK: UseCases
    private let changeImageColorTemperatureUseCase: ChangeImageColorTemperatureUC
    private let numberFormatter: NumberFormatter = .init()
    
    @Published private var cgImage: CGImage?
    @Published private var cgImagePlaceHolder: CGImage
    @Published private var sliderValue: Float = 0
    @Published private(set) var imageScale: CGFloat = 1.0
    @Published private(set) var valueRange: ClosedRange<Float> = 0...10
    
    @Published private(set) var headerTitle: String = "Let's go!\nChange the picture's  color temperature!"
    @Published private(set) var sliderMinTitle: String = "❄️"
    @Published private(set) var sliderMaxTitle: String = "🔥"
    
    var image: CGImage {
        cgImage ?? cgImagePlaceHolder
    }
    
    var formatedSliderValue: String {
        let nsNumber = NSNumber(value: sliderValue)
        return numberFormatter.string(from: nsNumber) ?? "0.0"
    }
    
    var sliderValuePublisher: Binding<Float> {
        .init(get: { self.sliderValue },
              set: { newValue in self.sliderValue = newValue })
    }
    
    // MARK: Init
    init(_ changeImageColorTemperatureUseCase: ChangeImageColorTemperatureUC) {
        self.changeImageColorTemperatureUseCase = changeImageColorTemperatureUseCase
        self.cgImagePlaceHolder = .cgImagePlaceholder
        
        self.changeImageColorTemperatureUseCase
            .publisher()
            .replaceError(with: cgImagePlaceHolder)
            .receive(on: RunLoop.main)
            .assign(to: &$cgImage)
    }
    
}

// MARK: ColorTemperatureEditorViewModelImpl extension
extension ColorTemperatureEditorViewModelImpl: ColorTemperatureEditorViewModel {
    
    func onSliderEditingEndedHandler(isEnded: Bool) {
        changeImageColorTemperatureUseCase.execute(image: cgImagePlaceHolder, value: sliderValue)
    }
}

extension ColorTemperatureEditorViewModelImpl: ObservableObject {}
