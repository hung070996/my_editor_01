//
//  RandomRequest.swift
//  MyEditor
//
//  Created by Do Hung on 9/10/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation

class RandomRequest: BaseRequest {
    required init() {
        let body: [String: Any]  = [
            "client_id": APIKey.key
        ]
        super.init(url: URLs.randomUrl, requestType: .get, body: body)
    }
}
