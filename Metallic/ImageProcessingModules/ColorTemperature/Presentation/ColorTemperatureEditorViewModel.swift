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
    associatedtype GeneralVM: FewImagesFewSlidersImageProcessingViewModel
    associatedtype ChangeColorTemperatureUC: ChangeImageColorTemperatureUseCase
    
    var generalVM:  GeneralVM { get }
    var changeColorTemperatureUseCase: ChangeColorTemperatureUC { get }
}

// MARK: ColorTemperatureEditorViewModelImpl
final class ColorTemperatureEditorViewModelImpl<ChangeImageColorTemperatureUC: ChangeImageColorTemperatureUseCase> {
    
    let generalVM: FewImagesFewSlidersImageProcessingViewModelImpl
    let changeColorTemperatureUseCase: ChangeImageColorTemperatureUC
    let sliderOnEnded: (Bool) -> Void
    let sliderOnChanged: (CGImage, Float) -> Void
    
    init(changeImageColorTemperatureUseCase: ChangeImageColorTemperatureUC) {
        
        let sliderOnEnded = {(isEnded: Bool) -> Void in
            //print("sliderOnEnded")
        }
        
        let sliderOnChanged = {(cgImage: CGImage, sigma: Float) -> Void in
            //print("\(sigma)")
            changeImageColorTemperatureUseCase.execute(image: .cgImagePlaceholder, value: sigma)
        }
        
        let useCasePublisher = changeImageColorTemperatureUseCase.publisher()
        
        self.sliderOnEnded = sliderOnEnded
        self.sliderOnChanged = sliderOnChanged
        self.changeColorTemperatureUseCase = changeImageColorTemperatureUseCase
        
        
        self.generalVM = FewImagesFewSlidersImageProcessingViewModelImpl(headerTitle: "Let's change image's color temperature!",
                                                            imagesCount: 1,
                                                            valueRanges: [0...30.0],
                                                            slidersMinMaxTitles: [("❄️", "🔥")],
                                                            slidersOnEndedHandlers: [sliderOnEnded],
                                                            sliderOnChangesHandlers: [sliderOnChanged],
                                                            processedImagesPublishers: [useCasePublisher])
        
        
    }
    
}

// MARK: ColorTemperatureEditorViewModelImpl extension
extension ColorTemperatureEditorViewModelImpl: ColorTemperatureEditorViewModel {
    
}

extension ColorTemperatureEditorViewModelImpl: ObservableObject {}
