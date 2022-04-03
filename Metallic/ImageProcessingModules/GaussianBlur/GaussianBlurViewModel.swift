//
//  GaussianBlurViewModel.swift
//  Metallic
//
//  Created by Роман Путинцев on 03.04.2022.
//

import Foundation

// MARK: GaussianBlurViewModel protocol
protocol GaussianBlurViewModel: ObservableObject {
    associatedtype GeneralVM: FewImagesFewSlidersImageProcessingViewModel
    var generalVM:  GeneralVM { get }
}

// MARK: GaussianBlurViewModelImpl
final class GaussianBlurViewModelImpl {
    
    let generalVM: FewImagesFewSlidersImageProcessingViewModelImpl
    let sliderOnEnded: (Bool) -> Void
    let sliderOnChanged: (Float) -> Void
    
    init() {
        
        let sliderOnEnded = {(isEnded: Bool) -> Void in print("sliderOnEnded") }
        let sliderOnChanged = {(sigma: Float) -> Void in print("\(sigma)") }
        
        self.sliderOnEnded = sliderOnEnded
        self.sliderOnChanged = sliderOnChanged
        self.generalVM = FewImagesFewSlidersImageProcessingViewModelImpl(headerTitle: "Let's apply Gaussian Blur!",
                                                            imagesCount: 1,
                                                            valueRanges: [0...10.0],
                                                            slidersMinMaxTitles: [("0", "10")],
                                                            slidersOnEndedHandlers: [sliderOnEnded],
                                                            sliderOnChangesHandlers: [sliderOnChanged])
        
    }
}

// MARK: GaussianBlurViewModel extension
extension GaussianBlurViewModelImpl: GaussianBlurViewModel {}
