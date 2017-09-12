//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation
@testable import EmbeddedSocial

class MockPostDetailRouter: PostDetailRouterInput {
    
    var backIfNeededCount = 0
    func backIfNeeded(from view: UIViewController) {
        backIfNeededCount += 1
    }
    
    var openLoginCount = 0
    func openLogin(from view: UIViewController) {
        openLoginCount += 1
    }
}
