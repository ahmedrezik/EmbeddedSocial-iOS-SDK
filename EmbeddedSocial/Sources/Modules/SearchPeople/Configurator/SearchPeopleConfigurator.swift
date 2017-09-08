//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

final class SearchPeopleConfigurator {
    let viewController: SearchPeopleViewController
    private(set) var moduleInput: SearchPeopleModuleInput!
    
    init() {
        viewController = StoryboardScene.SearchPeople.instantiateSearchPeopleViewController()
    }
    
    func configure(isLoggedInUser: Bool, navigationController: UINavigationController?, output: SearchPeopleModuleOutput?) {
        let interactor = SearchPeopleInteractor()
        
        let presenter = SearchPeoplePresenter()

        let api = EmptyUsersListAPI()
        let usersListModule = makeUserListModule(api: api, navigationController: navigationController, output: presenter)
        
        presenter.view = viewController
        presenter.usersListModule = usersListModule
        presenter.interactor = interactor
        presenter.moduleOutput = output
        
        if isLoggedInUser {
            presenter.backgroundUsersListModule =
                makeBackgroundUsersListModule(navigationController: navigationController, output: presenter)
        }
        
        viewController.output = presenter
        
        moduleInput = presenter
    }
    
    private func makeUserListModule(api: UsersListAPI,
                                    navigationController: UINavigationController?,
                                    output: UserListModuleOutput?) -> UserListModuleInput {
        
        let settings = UserListConfigurator.Settings(api: api,
                                                     navigationController: navigationController,
                                                     output: output)
        
        return UserListConfigurator().configure(with: settings)
    }
    
    private func makeBackgroundUsersListModule(navigationController: UINavigationController?,
                                               output: UserListModuleOutput?) -> UserListModuleInput {
        let api = SuggestedUsersAPI(socialService: SocialService())
        return makeUserListModule(api: api, navigationController: navigationController, output: output)
    }
}
