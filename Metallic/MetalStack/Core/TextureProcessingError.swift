//
//  TextureProcessingError.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import Foundation

// MARK: TextureEncodingError
enum TextureProcessingError: Error {
    case cgImageCreationFailed
    case textureCreationFailed
    case commandQueueCreationFailed
    //case redrawFailed
    case cantMakeFunction
    case cantMakeComputePipelineState
    case cantMakeCommandEncoder
    case cantMakeCommandBuffer
    case textureProcessorInRendererNotSetedAndEqualNil
    case textureTransformerInRendererNotSetedAndEqualNil
    case sourceTextureInRendererNotSetedAndEqualNil
    case destinationTextureInRendererNotSetedAndEqualNil
}
