//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation
@testable import EmbeddedSocial

class MockCreatePostPresenter: CreatePostPresenter {
    private(set) var postCreatedCalledCount = 0
    private(set) var postCreationFailed = false
    
    override func created() {
        postCreatedCalledCount += 1
    }
    
    override func postCreationFailed(error: Error) {
        postCreationFailed = true
    }
    
    var postUpdatedCount = 0
    override func postUpdated() {
        postUpdatedCount += 1
    }
}
