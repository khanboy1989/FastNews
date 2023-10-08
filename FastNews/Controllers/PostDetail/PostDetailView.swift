//
//  PostDetailView.swift
//  FastNews
//
//  Created by Serhan Khan on 20.03.23.
//

import SwiftUI

struct PostDetailView: View {
    
    var viewModel: PostDetailViewModel!
    
    var body: some View {
        VStack {
            HStack {
                Text("SwiftUI Screen")
                    .bold()
                    .foregroundColor(.black)
                    .font(.system(size: 21.0))
                    
            }
            Spacer()
                .frame(width: 1, height: 74, alignment: .bottom)
            VStack(alignment: .center) {
                Button(action: {
                   viewModel.input.navigateBack.execute()
                }) {
                    Text("Navigate to UIKit Screen")
                        .font(.system(size: 21.0))
                        .bold()
                        .frame(width: UIScreen.main.bounds.width, height: 10, alignment: .center)
                }
            }
            Spacer()
                .frame(width: 2, height: 105, alignment: .bottom)
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView()
            .background(Color.white)
    }
}
