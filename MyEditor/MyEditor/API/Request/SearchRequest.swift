//
//  SearchRequest.swift
//  MyEditor
//
//  Created by Do Hung on 8/29/18.
//  Copyright © 2018 Do Hung. All rights reserved.
//

import Foundation

class SearchRequest: BaseRequest {
    required init(query: String, page: Int, perPage: Int) {
        let body: [String: Any]  = [
            "client_id": APIKey.key,
            "page": page,
            "per_page": perPage,
            "query": query
        ]
        super.init(url: URLs.searchUrl, requestType: .get, body: body)
    }
}
