//
//  TextureRenderer.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import Foundation
import CoreGraphics
import Metal

//MARK: Texture renderer
final class TextureRenderer {
    private let device: MTLDevice
    private var library: MTLLibrary?
    private let commandQueue: MTLCommandQueue
    
    private var textureTransformer: TextureTransformer?
    private var textureProcessor: TextureProcessor?
    
    private var sourceTexture: MTLTexture?
    private var destinationTexture: MTLTexture?
    
    init(device: MTLDevice) throws {
        // let library = try device.makeDefaultLibrary(bundle: .main)
        guard let commandQueue = device.makeCommandQueue()
        else { throw TextureProcessingError.commandQueueCreationFailed }
        self.device = device
        self.commandQueue = commandQueue

    }
    
    func setContext(transformer: TextureTransformer, processor: TextureProcessor) {
        self.textureTransformer = transformer
        self.textureProcessor = processor
        self.library = processor.library
    }
}

//MARK: Drawing funcs
extension TextureRenderer {
    
    func redraw(source: CGImage, completionHandler: @escaping (CGImage) -> Void ) throws {
        
        guard let textureTransformer = self.textureTransformer
        else { throw TextureProcessingError.textureTransformerInRendererNotSetedAndEqualNil }
        
        guard let textureProcessor = self.textureProcessor
        else { throw TextureProcessingError.textureProcessorInRendererNotSetedAndEqualNil }
        
        self.sourceTexture = try textureTransformer.texture(from: source)
        
        guard let sourceTexture = self.sourceTexture
        else { throw TextureProcessingError.sourceTextureInRendererNotSetedAndEqualNil }
        
        self.destinationTexture = try textureTransformer.matchingTexture(to: sourceTexture)
        
        
        guard let destinationTexture = self.destinationTexture
        else { throw TextureProcessingError.destinationTextureInRendererNotSetedAndEqualNil }
        
        guard let commandBuffer = self.commandQueue.makeCommandBuffer()
        else { throw TextureProcessingError.cantMakeCommandBuffer }

        textureProcessor.encode(source: sourceTexture, destination: destinationTexture, in: commandBuffer)

        commandBuffer.addCompletedHandler { _ in
            guard let result = try? textureTransformer.cgImage(from: destinationTexture)
            else { return }
            
            completionHandler(result)
        }

        commandBuffer.commit()
    }
}
