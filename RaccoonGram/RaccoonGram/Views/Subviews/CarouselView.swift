//
//  CarouselView.swift
//  RaccoonGram
//
//  Created by Emrah Karabulut on 30.07.2022.
//

import SwiftUI

struct CarouselView: View {
    
    @State var selection: Int = 1
    let maxCount: Int = 8
    @State var timerAdded: Bool = false
    
    var body: some View {
        TabView(selection: $selection) {
            
            ForEach(1..<maxCount) { count in
                Image("raccoon\(count)")
                    .resizable()
                    .scaledToFill()
                    .tag(count)
            }
           
            
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 300)
        .animation(.default)
        .onAppear {
            if !timerAdded {
                addTimer()
            }
        }
    }
    
    func addTimer() {
        
        timerAdded = true
        let timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
               
            if selection == (maxCount - 1) {
                selection = 1
            } else {
                selection += 1
            }
            
        }
        timer.fire()
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
            .previewLayout(.sizeThatFits)
    }
}
