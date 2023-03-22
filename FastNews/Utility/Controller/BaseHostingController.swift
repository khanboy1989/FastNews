//
//  BaseHostingController.swift
//  FastNews
//
//  Created by Serhan Khan on 21.03.23.
//

import Foundation
import UIKit
import SwiftUI
import RxSwift

class BaseHostingController<Content: View>: UIHostingController<Content> {
    
    private let content: Content
    let disposeBag = DisposeBag()
    
    init(content: Content) {
        self.content = content
        super.init(rootView: content)
        view.backgroundColor = .white
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
