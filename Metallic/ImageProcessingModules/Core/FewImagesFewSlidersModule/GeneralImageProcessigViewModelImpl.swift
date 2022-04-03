//
//  GeneralImageProcessigViewModelImpl.swift
//  Metallic
//
//  Created by Роман Путинцев on 03.04.2022.
//

import Foundation
import SwiftUI

final class FewImagesFewSlidersImageProcessingViewModelImpl {
    var headerTitle: String
    
    var images: [CGImage]
    var imageScales: [CGFloat]
    var valueRanges: [ClosedRange<Float>]
    var sliderValues: [Float]
    var sliderValuePublishers: [Binding<Float>] = []
    var slidersMinMaxTitles: [(min: String, max: String)]
    var slidersOnEndedHandlers: [(Bool) -> Void]
    var sliderOnChangesHandlers: [(Float) -> Void]
    
    init(headerTitle: String,
         imagesCount: Int,
         valueRanges: [ClosedRange<Float>],
         slidersMinMaxTitles: [(min: String, max: String)],
         slidersOnEndedHandlers: [(Bool) -> Void],
         sliderOnChangesHandlers: [(Float) -> Void]
    ) {
        self.headerTitle = headerTitle
        
        self.images = Array(repeating: .cgImagePlaceholder, count: imagesCount)
        self.imageScales = Array(repeating: 1.0, count: imagesCount)
        
        self.valueRanges = valueRanges
        self.slidersMinMaxTitles = slidersMinMaxTitles
        self.slidersOnEndedHandlers = slidersOnEndedHandlers
        self.sliderOnChangesHandlers = sliderOnChangesHandlers
        
        let slidersCount = valueRanges.count
        self.sliderValues = Array(repeating: .zero, count: slidersCount)
        
        (0..<slidersCount).forEach({
            index in sliderValuePublishers.append(prerarePublisher(for: index))
        })
    }
    
    func prerarePublisher(for id: Int) -> Binding<Float> {
        .init(get: { self.sliderValues[id] },
              set: { newValue in self.sliderValues[id] = newValue })
    }
}

extension FewImagesFewSlidersImageProcessingViewModelImpl: FewImagesFewSlidersImageProcessingViewModel {
    
    typealias ImageId = Int
    typealias SliderId = Int
    
    var imageIdentifiers: [Int] { Array(images.indices) }
    var sliderIdentifiers: [Int] { Array(valueRanges.indices) }
    
    func image(for id: Int) -> CGImage {
        return id >= images.count ? .cgImagePlaceholder : images[id]
    }
    
    func imageScale(for id: Int) -> CGFloat {
        return id >= images.count ? 1.0 : imageScales[id]
    }
    
    func valueRange(for id: Int) -> ClosedRange<Float> {
        return id >= valueRanges.count ? 0...1.0 : valueRanges[id]
    }
    
    func sliderValuePublisher(for id: Int) -> Binding<Float> {
        let empty = Binding<Float>(get: { .zero }, set: { _ in })
        return id >= sliderValuePublishers.count ? empty : sliderValuePublishers[id]
    }
    
    func slidersMinMaxTitles(for id: Int) -> (min: String, max: String) {
        return id >= slidersMinMaxTitles.count ? ("", "") : slidersMinMaxTitles[id]
    }
    
    func formatedSliderValue(for id: Int) -> String {
        guard id < sliderValues.count else { return "0.0" }
        let formatter = NumberFormatter()
        let number = NSNumber(value: sliderValues[id])
        let str = formatter.string(from: number)

        return str ?? "0.0"
    }
    
    func slidersOnEndedHandlers(for id: Int) -> SliderOnEndedHandler {
        return slidersOnEndedHandlers[id]
    }
    
    func sliderOnChangesHandlers(for id: Int) -> SliderOnChangedHandler {
        return sliderOnChangesHandlers[id]
    }
    
}
