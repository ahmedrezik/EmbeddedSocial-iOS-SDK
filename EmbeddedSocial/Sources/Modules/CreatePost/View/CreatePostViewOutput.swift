//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import UIKit

protocol CreatePostViewOutput {
    func viewIsReady()
    func post(photo: Photo?, title: String?, body: String!)
    func back()
}
