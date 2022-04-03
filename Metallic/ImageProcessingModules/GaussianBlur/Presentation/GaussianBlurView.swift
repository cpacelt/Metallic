//
//  GaussianBlurView.swift
//  Metallic
//
//  Created by Роман Путинцев on 03.04.2022.
//

import SwiftUI
import SwiftUIRouter

// MARK: GaussianBlurView
struct GaussianBlurView<GaussianBlurVM: GaussianBlurViewModel,
                        SliderLabel: View>
{
    @EnvironmentObject var navigator: Navigator
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
        
        Spacer()
        FewImagesFewSlidersView(vm: vm, sliderLabel: { EmptyView() })
        
        Spacer()
        NavLink(to: "/color") {
            Text("One more thing")
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                )
        }
    }
}
