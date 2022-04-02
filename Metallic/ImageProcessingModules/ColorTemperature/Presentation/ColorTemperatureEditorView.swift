//
//  ColorTemperatureEditorView.swift
//  Metallic
//
//  Created by Роман Путинцев on 02.04.2022.
//

import SwiftUI

struct ColorTemperatureEditorView<SliderLabel: View>
 {
    let sliderLabel: () -> SliderLabel
    @EnvironmentObject var colorTemperatureEditorVM: ColorTemperatureEditorViewModel<Float>
}

extension ColorTemperatureEditorView: View {
    var body: some View {
        VStack {
            Text(colorTemperatureEditorVM.headerTitle)
                .font(.title)
                .padding()
            
            Image(decorative: colorTemperatureEditorVM.image,
                  scale: colorTemperatureEditorVM.imageScale)
                .resizable()
                .scaledToFit()
                .padding()
            
            
            Slider(value: $colorTemperatureEditorVM.sliderValue,
                   in: colorTemperatureEditorVM.valueRagnge,
                   label: sliderLabel, // SwiftUI bug, lable can not showed
                   minimumValueLabel: { Text(colorTemperatureEditorVM.sliderMinTitle) },
                   maximumValueLabel: { Text(colorTemperatureEditorVM.sliderMaxTitle) },
                   onEditingChanged: colorTemperatureEditorVM.onSliderEditingEndedHandler)
                .padding()
            
            Text(colorTemperatureEditorVM.formatedSliderValue)
        }
    }
}

struct ColorTemperatureEditorView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ColorTemperatureEditorViewModel<Float>()
        ColorTemperatureEditorView(sliderLabel: {
            Text("\(vm.sliderValue)")
        })
            .environmentObject(vm)
    }
}
