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
    func execute(image: CGImage, value: Float)
    func publisher() -> AnyPublisher<CGImage?, ImageProcessingError>
}

// MARK: ChangeImageColorTemperatureUseCaseImpl
final class ChangeImageColorTemperatureUseCaseImpl {
    let subject: PassthroughSubject<CGImage?, ImageProcessingError>
    let renderer: TextureRenderer
    let processor: ColorTemperatureProcessor
    let transformer: TextureTransformer
    
    init(renderer: TextureRenderer, processor: ColorTemperatureProcessor, transformer: TextureTransformer) {
        self.subject = PassthroughSubject()
        
        self.renderer = renderer
        self.processor = processor
        self.transformer = transformer
        
        //renderer.setContext(transformer: transformer, processor: processor)
    }
}

// MARK: ChangeImageColorTemperatureUseCaseImpl extension
extension ChangeImageColorTemperatureUseCaseImpl: ChangeImageColorTemperatureUseCase {
    
    func execute(image: CGImage, value: Float) {
        renderer.setContext(transformer: transformer, processor: processor)
        self.processor.tint = value
        
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
