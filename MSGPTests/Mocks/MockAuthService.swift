//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

@testable import MSGP

final class MockAuthService: AuthServiceType {
    private(set) var loginCount = 0
    
    func login(with provider: AuthProvider,
               from viewController: UIViewController?,
               handler: @escaping (Result<SocialUser>) -> Void) {
        loginCount += 1
    }
}
