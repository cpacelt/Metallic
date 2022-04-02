//
//  Renderer.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import Foundation
import Metal

// MARK: Safety extensions
fileprivate extension Int {
    enum ConstantValuesIndices: Int {
        case deviceSupportsNonuniformThreadgroups = 0
    }
    
    static func index(for safeIndex: ConstantValuesIndices) -> Int  {
        return safeIndex.rawValue
    }
}

fileprivate extension String {
    static var colorTemperatureProcessorsShaderName: String { "adjustments" }
}


// MARK: ColorTemperatureProcessor
final class ColorTemperatureProcessor {
    
    var temperature: Float = .zero
    var tint: Float = .zero
    
    internal let library: MTLLibrary
    internal let pipelineState: MTLComputePipelineState
    internal let constantValues: MTLFunctionConstantValues
    internal let function: MTLFunction
    private var deviceSupportsNonuniformThreadgroups: Bool
    
    init?(library: MTLLibrary) {
        self.library = library
        self.deviceSupportsNonuniformThreadgroups = library.device.supportsFeatureSet(.iOS_GPUFamily4_v1)
        self.constantValues = MTLFunctionConstantValues()
        self.constantValues.setConstantValue(&deviceSupportsNonuniformThreadgroups,
                                             type: .bool,
                                             index: .index(for: .deviceSupportsNonuniformThreadgroups))
        guard
            let function = try? library.makeFunction(name: .colorTemperatureProcessorsShaderName,
                                                     constantValues: constantValues),
            let pipelineState = try? library.device.makeComputePipelineState(function: function)
        else { return nil }
        
        self.function = function
        self.pipelineState = pipelineState
    }
}

extension ColorTemperatureProcessor: TextureProcessor {
    
    func encode(source: MTLTexture,
                destination: MTLTexture,
                in commandBuffer: MTLCommandBuffer) {
        
        guard let encoder = commandBuffer.makeComputeCommandEncoder()
        else { return }
        
        encoder.setTexture(source, index: 0)
        encoder.setTexture(destination, index: 1)
        
        encoder.setBytes(&self.temperature,
                         length: MemoryLayout<Float>.stride,
                         index: 0)
        encoder.setBytes(&self.tint,
                         length: MemoryLayout<Float>.stride,
                         index: 1)
        
        let gridSize = MTLSize(width: source.width,
                               height: source.height,
                               depth: 1)
        
        let threadGroupWidth = self.pipelineState.threadExecutionWidth
        let threadGroupHeight = self.pipelineState.maxTotalThreadsPerThreadgroup / threadGroupWidth
        let threadGroupSize = MTLSize(width: threadGroupWidth,
                                      height: threadGroupHeight,
                                      depth: 1)
        
        encoder.setComputePipelineState(self.pipelineState)
        
        if self.deviceSupportsNonuniformThreadgroups {
            encoder.dispatchThreads(gridSize,
                                    threadsPerThreadgroup: threadGroupSize)
        } else {
            let threadGroupCount = MTLSize(width: (gridSize.width + threadGroupSize.width - 1) / threadGroupSize.width,
                                           height: (gridSize.height + threadGroupSize.height - 1) / threadGroupSize.height,
                                           depth: 1)
            encoder.dispatchThreadgroups(threadGroupCount,
                                         threadsPerThreadgroup: threadGroupSize)
        }
        
        encoder.endEncoding()
    }
    
    
}

