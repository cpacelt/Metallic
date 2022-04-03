//
//  GaussianBlurView.swift
//  Metallic
//
//  Created by Роман Путинцев on 03.04.2022.
//

import SwiftUI


// MARK: GaussianBlurView
struct GaussianBlurView<GaussianBlurVM: GaussianBlurViewModel,
                        SliderLabel: View>
{
    @ObservedObject var vm: GaussianBlurVM.GeneralVM
    let sliderLabel: () -> SliderLabel
    
    init(vm: GaussianBlurVM, sliderLabel: @escaping () -> SliderLabel) {
        self.vm = vm.generalVM
        self.sliderLabel = sliderLabel
    }
}

// MARK: View extension
extension GaussianBlurView: View {
    var body: some View {
        FewImagesFewSlidersView(vm: vm, sliderLabel: { EmptyView() })
    }
}
