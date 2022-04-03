//
//  ContentView.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import SwiftUI
import MetalKit
import SwiftUIRouter

struct ContentView: View {
    var body: some View {
        
        
        let device = MTLCreateSystemDefaultDevice()!
        let library = try? device.makeDefaultLibrary(bundle: .main)
        let renderer = try? TextureRenderer(device: device)
        let transformer = TextureTransformer(device: device)
        
        //MARK: Gaussian blur
        let gaussianBlurProcessor = try? GaussianBlurProcessor(library: library!)
        let gaussianBlurUC = ApplyGaussianBlurUseCaseImpl(renderer: renderer!,
                                                          processor: gaussianBlurProcessor!,
                                                          transformer: transformer)
        let gaussianBlurVM = GaussianBlurViewModelImpl(applyGaussianBlurUseCase: gaussianBlurUC)
        
        //MARK: ColorTemp
        let colorTempProcessor = try? ColorTemperatureProcessor(library: library!)
        let colorTempUC = ChangeImageColorTemperatureUseCaseImpl(renderer: renderer!,
                                                                 processor: colorTempProcessor!,
                                                                 transformer: transformer)
        let colorTempVM = ColorTemperatureEditorViewModelImpl(changeImageColorTemperatureUseCase: colorTempUC)
        
        
        Router {
            SwitchRoutes {
                Route("color") {
                    ColorTemperatureEditorView(vm: colorTempVM) { EmptyView() }
                }
                
                Route("gauss") {
                    GaussianBlurView(vm: gaussianBlurVM) { EmptyView() }
                }
            }
            
            Navigate(to: "/gauss")
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
