//
//  PhotoRequest.swift
//  MyEditor
//
//  Created by Do Hung on 8/28/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation

class PhotoRequest: BaseRequest {
    required init(page: Int, perPage: Int) {
        let body: [String: Any]  = [
            "client_id": APIKey.key,
            "page": page,
            "per_page": perPage
        ]
        super.init(url: URLs.photosUrl, requestType: .get, body: body)
    }
}
