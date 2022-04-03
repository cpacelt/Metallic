//
//  GaussianBlurViewModel.swift
//  Metallic
//
//  Created by Роман Путинцев on 03.04.2022.
//

import Foundation
import Combine
import CoreGraphics

// MARK: GaussianBlurViewModel protocol
protocol GaussianBlurViewModel: ObservableObject {
    associatedtype GeneralVM: FewImagesFewSlidersImageProcessingViewModel
    associatedtype ApplyGaussianBlurUC: ApplyGaussianBlurUseCase
    
    var generalVM:  GeneralVM { get }
    var applyGaussianBlurUsecase: ApplyGaussianBlurUC { get }
}

// MARK: GaussianBlurViewModelImpl
final class GaussianBlurViewModelImpl<ApplyGaussianBlurUC: ApplyGaussianBlurUseCase> {
    
    let generalVM: FewImagesFewSlidersImageProcessingViewModelImpl
    let applyGaussianBlurUsecase: ApplyGaussianBlurUC
    let sliderOnEnded: (Bool) -> Void
    let sliderOnChanged: (CGImage, Float) -> Void
    
    init(applyGaussianBlurUseCase: ApplyGaussianBlurUC) {
        
        let sliderOnEnded = {(isEnded: Bool) -> Void in
            //print("sliderOnEnded")
        }
        
        let sliderOnChanged = {(cgImage: CGImage, sigma: Float) -> Void in
            //print("\(sigma)")
            applyGaussianBlurUseCase.execute(image: .cgImagePlaceholder, sigma: sigma)
        }
        
        let useCasePublisher = applyGaussianBlurUseCase.publisher()
        
        self.sliderOnEnded = sliderOnEnded
        self.sliderOnChanged = sliderOnChanged
        self.applyGaussianBlurUsecase = applyGaussianBlurUseCase
        
        
        self.generalVM = FewImagesFewSlidersImageProcessingViewModelImpl(headerTitle: "Let's apply Gaussian Blur!",
                                                            imagesCount: 1,
                                                            valueRanges: [0...10.0],
                                                            slidersMinMaxTitles: [("0", "10")],
                                                            slidersOnEndedHandlers: [sliderOnEnded],
                                                            sliderOnChangesHandlers: [sliderOnChanged],
                                                            processedImagesPublishers: [useCasePublisher])
        
        
    }
}

// MARK: GaussianBlurViewModel extension
extension GaussianBlurViewModelImpl: GaussianBlurViewModel {}
