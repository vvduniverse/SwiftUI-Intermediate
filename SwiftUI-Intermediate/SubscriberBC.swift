//
//  SubscriberBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 03.04.2022.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count = 0
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText = ""
    @Published var textIsValid = false
    
    @Published var showButton = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _count in
                guard let self = self else { return }
                self.count += 1
                
//                if self.count >= 10 {
//                    for item in self.cancellables {
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBC: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text(vm.textIsValid.description )
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                .overlay(alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                    vm.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                        .font(.title)
                        .padding(.trailing, 20)
                }
            
            Button {
                
            } label: {
                Text("Submit".uppercased())
            }
            .buttonStyle(.borderedProminent)
            .opacity(vm.showButton ? 1.0 : 0.5)
            .disabled(!vm.showButton)

        }
    }
}

struct SubscriberBC_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBC()
    }
}
