//
//  PhotoInCollectionRequest.swift
//  MyEditor
//
//  Created by Do Hung on 8/29/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation

class PhotoInCollectionRequest: BaseRequest {
    required init(collection: Collection, page: Int, perPage: Int) {
        let body: [String: Any]  = [
            "client_id": APIKey.key,
            "page": page,
            "per_page": perPage
        ]
        let url = URLs.collectionsUrl + "/" + String(collection.id) + "/photos"
        super.init(url: url, requestType: .get, body: body)
    }
}
