//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

protocol PostMenuModuleModuleOutput: class {

    func didBlock(user: UserHandle)
    func didUnblock(user: UserHandle)
    func didRepost(user: UserHandle)
    func didFollow(user: UserHandle)
    func didUnfollow(user: UserHandle)
    func didHide(post: PostHandle)
    func didEdit(post: PostHandle)
    func didRemove(post: PostHandle)
    func didReport(post: PostHandle)
    func didRequestFail(error: Error)
}

protocol PostMenuModuleModuleInput: class {
    
    func didTapBlock(user: UserHandle)
    func didTapUnblock(user: UserHandle)
    func didTapHide(post: PostHandle)
    func didTapFollow(user: UserHandle)
    func didTapUnfollow(user: UserHandle)
    func didTapEditPost(post: PostHandle)
    func didTapRemovePost(post: PostHandle)
    
}

enum PostMenuType {
    case myPost(post: Post)
    case otherPost(post: Post, isHome: Bool)
}

struct ActionViewModel {
    
    typealias ActionHandler = () -> ()
    
    var title: String = ""
    var action: ActionHandler!
}

class PostMenuModulePresenter: PostMenuModuleViewOutput, PostMenuModuleModuleInput, PostMenuModuleInteractorOutput {

    weak var view: PostMenuModuleViewInput!
    weak var output: PostMenuModuleModuleOutput?
    var interactor: PostMenuModuleInteractorInput!
    var router: PostMenuModuleRouterInput!
    var menuType: PostMenuType!
    
    func viewIsReady() {
        let items = itemsForMenu(type: menuType)
        view.showItems(items: items)
    }
    
    // MARK: Actions
    private func itemsForMenu(type: PostMenuType) -> [ActionViewModel] {
        switch type {
        case .myPost(let post):
            return buildActionListForMyPost(post: post)
        case .otherPost(let post, let isHomeFeed):
            return buildActionListForOtherPost(post: post, isHomeFeed: isHomeFeed)
        }
    }
    
    private func buildActionListForOtherPost(post: Post, isHomeFeed: Bool) -> [ActionViewModel] {
        
        let followItem = followersViewModel(post: post)
        let blockItem = blockViewModel(post: post)
        
        var reportItem = ActionViewModel()
        reportItem.title = "Report Post"
        reportItem.action = { [weak self] in
            self?.didTapRemovePost(post: post.topicHandle!)
        }
        
        var items = [followItem, blockItem, reportItem]
        
        if isHomeFeed {
            let item = hideViewModel(post: post)
            items.append(item)
        }
        
        return items
    }

    private func buildActionListForMyPost(post: Post) -> [ActionViewModel] {
        
        let postHandle = post.topicHandle!
        
        var editItem = ActionViewModel()
        editItem.title = "Edit Post"
        editItem.action = { [weak self] in
            self?.didTapEditPost(post: postHandle)
        }
        
        var removeitem = ActionViewModel()
        removeitem.title = "Remove Post"
        removeitem.action = { [weak self] in
            self?.didTapRemovePost(post: postHandle)
        }
        
        return [editItem, removeitem]
    }
    
    // MARK: View Models builder
    
    private func followersViewModel(post: Post) -> ActionViewModel {
        
        var item = ActionViewModel()
        
        let shouldFollow = (post.userStatus == Post.UserStatus.follow) ? false : true
        let userHandle = post.userHandle!
        
        item.title = shouldFollow ? "Follow" : "Unfollow"
        item.action = { [weak self] in
            if shouldFollow {
                self?.didTapFollow(user: userHandle)
            } else {
                self?.didTapUnfollow(user: userHandle)
            }
        }
        return item
    }
    
    private func blockViewModel(post: Post) -> ActionViewModel {
        
        var item = ActionViewModel()
        let userHandle = post.userHandle!
        
        let shouldUnblock = post.userStatus == .blocked
        
        item.title = shouldUnblock ? "Unblock" : "Block"
        item.action = { [weak self] in
            if shouldUnblock {
                self?.didTapUnblock(user: userHandle)
            } else {
                self?.didTapBlock(user: userHandle)
            }
        }
        return item
    }
    
    private func hideViewModel(post: Post) -> ActionViewModel {
        
        var item = ActionViewModel()
        item.title = "Hide"
        item.action = { [weak self] in
            self?.didTapHide(post: post.topicHandle!)
        }
        
        return item
    }
    
    // MARK: Module Input
    
    func didTapBlock(user: UserHandle) {
        self.output?.didBlock(user: user)
        self.interactor.block(user: user)
    }
    
    func didTapUnblock(user: UserHandle) {
        self.output?.didUnblock(user: user)
        self.interactor.unblock(user: user)
    }
    
    func didTapHide(post: PostHandle) {
        self.output?.didHide(post: post)
        self.interactor.hide(post: post)
    }
    
    func didTapFollow(user: UserHandle) {
        self.output?.didFollow(user: user)
        self.interactor.follow(user: user)
    }
    
    func didTapUnfollow(user: UserHandle) {
        self.output?.didUnfollow(user: user)
        self.interactor.unfollow(user: user)
    }
    
    func didTapEditPost(post: PostHandle) {
        self.output?.didEdit(post: post)
        self.interactor.edit(post: post)
    }
    
    func didTapRemovePost(post: PostHandle) {
        self.output?.didRemove(post: post)
        self.interactor.remove(post: post)
    }
    
    func didTapReportPost(post: PostHandle) {
        self.output?.didReport(post: post)
        self.interactor.report(post: post)
    }
    
    // MARK: Interactor Output
    func didBlock(user: UserHandle, error: Error?) {
        Logger.log(user, error)
        if let error = error {
            output?.didRequestFail(error: error)
        }
    }
    
    func didUnblock(user: UserHandle, error: Error?) {
        Logger.log(user, error)
        if let error = error {
            output?.didRequestFail(error: error)
        }
    }
    
    func didRepost(user: UserHandle, error: Error?) {
        Logger.log(user, error)
        if let error = error {
            output?.didRequestFail(error: error)
        }
    }
    
    func didFollow(user: UserHandle, error: Error?) {
        Logger.log(user, error)
        if let error = error {
            output?.didRequestFail(error: error)
        }
    }
    
    func didUnfollow(user: UserHandle, error: Error?) {
        Logger.log(user, error)
        if let error = error {
            output?.didRequestFail(error: error)
        }
    }
    
    func didHide(post: PostHandle, error: Error?) {
        Logger.log(post, error)
        if let error = error {
            output?.didRequestFail(error: error)
        }
    }
    
    func didEdit(post: PostHandle, error: Error?) {
        Logger.log(post, error)
        if let error = error {
            output?.didRequestFail(error: error)
        }
    }
    
    func didRemove(post: PostHandle, error: Error?) {
        Logger.log(post, error)
        if let error = error {
            output?.didRequestFail(error: error)
        }
    }
    
    func didReport(post: PostHandle, error: Error?) {
        Logger.log(post, error)
        if let error = error {
            output?.didRequestFail(error: error)
        }
    }
    
    deinit {
        Logger.log()
    }
}