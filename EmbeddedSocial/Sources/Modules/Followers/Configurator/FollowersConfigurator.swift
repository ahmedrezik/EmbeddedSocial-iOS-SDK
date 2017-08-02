//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import UIKit

final class FollowersConfigurator {
    let viewController: FollowersViewController
    
    init() {
        viewController = StoryboardScene.Followers.instantiateFollowersViewController()
    }
    
    func configure() {
        let presenter = FollowersPresenter()

        let api = MyFollowersAPI(service: SocialService())
        let listInput = UserListConfigurator().configure(api: api, output: presenter)
        
        presenter.view = viewController
        presenter.usersList = listInput
        
        viewController.output = presenter
    }
}