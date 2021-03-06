//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation

final class FollowRequestsAPI: UsersListAPI {
    private let activityService: ActivityService
    
    init(activityService: ActivityService) {
        self.activityService = activityService
    }
    
    override func getUsersList(cursor: String?, limit: Int, completion: @escaping (Result<UsersListResponse>) -> Void) {
        activityService.loadPendingsRequests(cursor: cursor, limit: limit, completion: completion)
    }
}
