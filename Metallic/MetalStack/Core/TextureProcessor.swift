//
//  TextureProcessor.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import Foundation
import Metal

protocol TextureProcessor {
    var library: MTLLibrary { get }
    //var pipelineState: MTLComputePipelineState { get }
    //var constantValues: MTLFunctionConstantValues { get }
    //var function: MTLFunction { get }
    
    func encode(source: MTLTexture, destination: MTLTexture, in commandBuffer: MTLCommandBuffer)
}
