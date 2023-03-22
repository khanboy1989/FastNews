//
//  PostDetailHostingController.swift
//  FastNews
//
//  Created by Serhan Khan on 21.03.23.
//

import Foundation
import SwiftUI

final class PostDetailHostingController: BaseHostingController<PostDetailView>,
                                            ViewModelBased {
    var viewModel: PostDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel.output.title)
    }
}
