//
//  ColorTemperatureEditorView.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import SwiftUI

// MARK: GaussianBlurView
struct ColorTemperatureEditorView<ColorTemperatureEditorVM: ColorTemperatureEditorViewModel,
                        SliderLabel: View>
{
    @ObservedObject var vm: ColorTemperatureEditorVM.GeneralVM
    let sliderLabel: () -> SliderLabel
    
    init(vm: ColorTemperatureEditorVM, sliderLabel: @escaping () -> SliderLabel) {
        self.vm = vm.generalVM
        self.sliderLabel = sliderLabel
    }
}

// MARK: View extension
extension ColorTemperatureEditorView: View {
    var body: some View {
        FewImagesFewSlidersView(vm: vm, sliderLabel: { EmptyView() })
    }
}
