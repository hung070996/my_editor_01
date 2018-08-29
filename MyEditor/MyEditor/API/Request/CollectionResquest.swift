//
//  CollectionResquest.swift
//  MyEditor
//
//  Created by Do Hung on 8/29/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation

class CollectionRequest: BaseRequest {
    required init(page: Int, perPage: Int) {
        let body: [String: Any]  = [
            "client_id": APIKey.key,
            "page": page,
            "per_page": perPage,
        ]
        super.init(url: URLs.collectionsUrl, requestType: .get, body: body)
    }
}
