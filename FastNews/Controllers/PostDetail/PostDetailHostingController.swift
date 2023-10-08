//
//  PostDetailHostingController.swift
//  FastNews
//
//  Created by Serhan Khan on 21.03.23.
//

import Foundation
import SwiftUI

final class PostDetailHostingController: BaseHostingController<PostDetailView>, ViewModelBased {
    var viewModel: PostDetailViewModel!
    
    init(viewModel: PostDetailViewModel, content: PostDetailView) {
        self.viewModel = viewModel
        super.init(content: content)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print(viewModel.output.title)
    }
}
