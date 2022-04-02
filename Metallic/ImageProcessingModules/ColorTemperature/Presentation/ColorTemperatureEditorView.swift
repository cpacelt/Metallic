//
//  ColorTemperatureEditorView.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import SwiftUI

// MARK: ColorTemperatureEditorView
struct ColorTemperatureEditorView<ViewModel: ColorTemperatureEditorViewModel, SliderLabel: View>
{
    @ObservedObject var vm: ViewModel
    let sliderLabel: () -> SliderLabel
}

// MARK: View extension
extension ColorTemperatureEditorView: View {
    var body: some View {
        VStack {
            Text(vm.headerTitle)
                .font(.title)
                .padding()
            
            Image(decorative: vm.image,
                  scale: vm.imageScale)
                .resizable()
                .scaledToFit()
                .padding()
            
            Slider(value: vm.sliderValuePublisher,
                   in: vm.valueRange,
                   label: sliderLabel, // SwiftUI bug, lable can not showed
                   minimumValueLabel: { Text(vm.sliderMinTitle) },
                   maximumValueLabel: { Text(vm.sliderMaxTitle) },
                   onEditingChanged: vm.onSliderEditingEndedHandler)
                .padding()
            
            Text(vm.formatedSliderValue)
        }
    }
}

//MARK: Preview
struct ColorTemperatureEditorView_Previews: PreviewProvider {
    static var previews: some View {
        let uc = ChangeImageColorTemperatureUseCaseImpl()
        let vm = ColorTemperatureEditorViewModelImpl<Float, ChangeImageColorTemperatureUseCaseImpl>(uc)
        ColorTemperatureEditorView(vm: vm) {
            Text(vm.formatedSliderValue)
        }
    }
}
