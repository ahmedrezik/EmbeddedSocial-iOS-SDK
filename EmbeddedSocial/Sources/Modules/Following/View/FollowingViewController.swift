//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import UIKit
import SnapKit

class FollowingViewController: BaseViewController {
    
    var output: FollowingViewOutput!
    
    fileprivate var listView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
}

extension FollowingViewController: FollowingViewInput {
    func setupInitialState(userListView: UIView) {
        view.addSubview(userListView)
        userListView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        listView = userListView
    }
    
    func showError(_ error: Error) {
        showErrorAlert(error)
    }
}
