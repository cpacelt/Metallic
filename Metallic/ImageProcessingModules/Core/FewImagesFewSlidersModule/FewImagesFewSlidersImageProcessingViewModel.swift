//
//  GeneralImageProcessingViewModel.swift
//  Metallic
//
//  Created by Роман Путинцев on 03.04.2022.
//

import Foundation
import SwiftUI

protocol FewImagesFewSlidersImageProcessingViewModel: ObservableObject {
    associatedtype ImageId: Hashable
    associatedtype SliderId: Hashable
    
    typealias SliderOnChangedHandler = (CGImage, Float) -> Void
    typealias SliderOnEndedHandler = (Bool) -> Void
    
    var headerTitle: String { get }
    var imageIdentifiers: [ImageId] { get }
    var sliderIdentifiers: [SliderId] { get }
    
    func image(for id: ImageId) -> CGImage
    func imageScale(for id: ImageId) -> CGFloat
    
    func valueRange(for id: SliderId) -> ClosedRange<Float>
    func sliderValuePublisher(for id: SliderId) -> Binding<Float>
    
    func slidersMinMaxTitles(for id: SliderId) -> (min: String, max: String)
    func formatedSliderValue(for id: SliderId) -> String
    
    func slidersOnEndedHandlers(for id: SliderId) -> SliderOnEndedHandler
    func sliderOnChangesHandlers(for id: SliderId) -> SliderOnChangedHandler
    
}
