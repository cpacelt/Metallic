//
//  ApplyGaussianBlurUseCase.swift
//  Metallic
//
//  Created by Роман Путинцев on 03.04.2022.
//

import Foundation
import Combine
import CoreGraphics


// MARK: ApplyGaussianBlurUseCase protocol
protocol ApplyGaussianBlurUseCase {
    func execute(image: CGImage, sigma: Float)
    func publisher() -> AnyPublisher<CGImage?, ImageProcessingError>
}

final class ApplyGaussianBlurUseCaseImpl {
    let subject: PassthroughSubject<CGImage?, ImageProcessingError>
    let renderer: TextureRenderer
    let processor: GaussianBlurProcessor
    let transformer: TextureTransformer
    
    init(renderer: TextureRenderer, processor: GaussianBlurProcessor, transformer: TextureTransformer) {
        self.subject = PassthroughSubject()
        
        self.renderer = renderer
        self.processor = processor
        self.transformer = transformer
        
        //renderer.setContext(transformer: transformer, processor: processor)
    }
}

// MARK: ApplyGaussianBlurUseCaseImpl extension
extension ApplyGaussianBlurUseCaseImpl: ApplyGaussianBlurUseCase {
    
    func execute(image: CGImage, sigma: Float) {
        self.renderer.setContext(transformer: transformer, processor: processor)
        self.processor.sigma = sigma
        
        do {
            try renderer.redraw(source: image) { redrawedImage in
                self.subject.send(redrawedImage)
            }
            
        } catch {
            //TODO: Create transformer between Errors
            //This line will fail every time
            subject.send(completion: .failure(error as! ImageProcessingError))
        }
    }
    
    func publisher() -> AnyPublisher<CGImage?, ImageProcessingError> {
        return subject.eraseToAnyPublisher()
    }
}

