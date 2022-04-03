//
//  ContentView.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import SwiftUI
import MetalKit

struct ContentView: View {
    var body: some View {
        
        //MARK: Testing
        let device = MTLCreateSystemDefaultDevice()!
        let library = try? device.makeDefaultLibrary(bundle: .main)
        
        let renderer = try? TextureRenderer(device: device)
        //let processor = try? ColorTemperatureProcessor(library: library!)
        let processor = try? GaussianBlurProcessor(library: library!)
        let transformer = TextureTransformer(device: device)
        
//        let uc = ChangeImageColorTemperatureUseCaseImpl(renderer: renderer!,
//                                                        processor: processor!,
//                                                        transformer: transformer)
        
//        let uc = ApplyGaussianBlurUseCaseImpl(renderer: renderer!,
//                                                        processor: processor!,
//                                                        transformer: transformer)
//
//       // let vm = ColorTemperatureEditorViewModelImpl<ChangeImageColorTemperatureUseCaseImpl>(uc)
//        let vm = ColorTemperatureEditorViewModelImpl(uc)
//        ColorTemperatureEditorView(vm: vm) {
//            Text(vm.formatedSliderValue)
//        }
        let uc = ApplyGaussianBlurUseCaseImpl(renderer: renderer!,
                                              processor: processor!,
                                              transformer: transformer)
        let vm = GaussianBlurViewModelImpl(applyGaussianBlurUseCase: uc)
        GaussianBlurView(vm: vm, sliderLabel: {
            EmptyView()
        })
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
