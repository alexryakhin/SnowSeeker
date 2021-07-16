//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Alexander Bonney on 7/14/21.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalsizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var body: some View {
        GeometryReader { geometry in
                Text("Welcome to Finding Snow app!\nSwipe from the left to see all resorts we provide!").bold().font(.largeTitle)
                         .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }.navigationBarTitle(Text("Welcome!"), displayMode: .inline)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
