//
//  GaussianBlurProcessor.swift
//  Metallic
//
//  Created by Роман Путинцев on 03.04.2022.
//

import Foundation
import MetalPerformanceShaders

class GaussianBlurProcessor {
    let library: MTLLibrary
    
    var kern: MPSImageGaussianBlur!
    var sigma: Float = .zero
    
    init(library: MTLLibrary) {
        self.library = library
    }
    
    
}

extension GaussianBlurProcessor: TextureProcessor {
    func encode(source: MTLTexture, destination: MTLTexture, in commandBuffer: MTLCommandBuffer) {
        kern = MPSImageGaussianBlur(device: library.device, sigma: sigma)
        kern.encode(commandBuffer: commandBuffer, sourceTexture: source, destinationTexture: destination)
    }
}
