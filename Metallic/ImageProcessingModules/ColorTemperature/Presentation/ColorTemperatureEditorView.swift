//
//  ColorTemperatureEditorView.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import SwiftUI
import SwiftUIRouter

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
        
        Spacer()
        FewImagesFewSlidersView(vm: vm, sliderLabel: { EmptyView() })
        
        Spacer()
        NavLink(to: "/gauss") {
            Text("One more thing")
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                )
        }
    }
}
