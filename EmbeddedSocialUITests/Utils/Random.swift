//
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See LICENSE in the project root for license information.
//

import Foundation


class Random {

    class func randomUInt(_ seed: UInt) -> UInt {
        return UInt(arc4random_uniform(UInt32(seed)))
    }
    
    class func randomInt(max: Int, min: Int = 0) -> Int {
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
}
