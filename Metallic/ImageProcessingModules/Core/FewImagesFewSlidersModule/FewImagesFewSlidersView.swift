//
//  FewImagesFewSlidersView.swift
//  Metallic
//
//  Created by Роман Путинцев on 03.04.2022.
//

import SwiftUI



// MARK: ColorTemperatureEditorView
struct FewImagesFewSlidersView<FewImagesFewSlidersVM: FewImagesFewSlidersImageProcessingViewModel,
                               SliderLabel: View>
{
    @ObservedObject var vm: FewImagesFewSlidersVM
    let sliderLabel: () -> SliderLabel
    
    init(vm: FewImagesFewSlidersVM, sliderLabel: @escaping () -> SliderLabel) {
        self.vm = vm
        self.sliderLabel = sliderLabel
    }
}

// MARK: View extension
extension FewImagesFewSlidersView: View {
    var body: some View {
        VStack {
            Text(vm.headerTitle)
                .font(.title)
                .bold()
                .padding()
                .padding([.bottom], 30)
            
            ForEach(vm.imageIdentifiers, id: \.self) { id in
                HStack {
                    Image(decorative: vm.image(for: id),
                          scale: vm.imageScale(for: id))
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10.0)
                        .padding()
                }
            }
            
            ForEach(vm.sliderIdentifiers, id: \.self) { id in
                VStack {
                    Slider(value: vm.sliderValuePublisher(for: id),
                           in: vm.valueRange(for: id),
                           label: sliderLabel, // SwiftUI bug, lable can not showed
                           minimumValueLabel: { Text(vm.slidersMinMaxTitles(for: id).min) },
                           maximumValueLabel: { Text(vm.slidersMinMaxTitles(for: id).max) },
                           onEditingChanged: vm.slidersOnEndedHandlers(for: id) )
                        .padding()
                    
                    Text(vm.formatedSliderValue(for: id))
                }
            }
            
            
            
        }
    }
}
