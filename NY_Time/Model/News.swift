//
//  News.swift
//  NY_Time
//
//  Created by MEHUL PANCHAL on 16/11/18.
//  Copyright © 2018 MEHUL PANCHAL. All rights reserved.
//

import Foundation

let baseURLString = "https://api.nytimes.com/svc/"
let popularArticals = "mostpopular/v2/mostviewed/all-sections/7.json?api_key=\(apiKey)"
let apiKey = "cc0692d604eb4f7eb72216dcb7cc16eb"


//struct main:Decodable {
//   
//    let status: String
//    let copyright: String
//    let num_results: Int
//    let results: [News]
//    
//     init(json : [String  : Any]) {
//       
//        status = json["status"] as? String ?? ""
//        copyright = json["copyright"] as? String ?? ""
//        num_results = json["num_results"] as? Int ?? -1
//        results = json["results"] as? [News] ?? []
//     }
//}


//struct News:Decodable {
//
//    let url: String?
//    let adx_keywords: String
//    let column: String?
//    let section: String?
//    let byline: String?
//    let type: String?
//    let title: String?
//    let abstract: String?
//    let published_date: String?
//    let source: String?
//    let id: Int?
//    let asset_id: Int?
//    let views: Int?
//    let des_facet : [String]?
//    let org_facet : [String]?
//    let per_facet : [String]?
//    let geo_facet : [String]?
//    let media : [media]?
//
//    init(json : [String  : Any]) {
//
//        url = json["url"] as? String ?? ""
//        adx_keywords = json["adx_keywords"] as? String ?? ""
//        column = json["column"] as? String ?? ""
//        section = json["section"] as? String ?? ""
//        byline = json["byline"] as? String ?? ""
//        type = json["type"] as? String ?? ""
//        title = json["title"] as? String ?? ""
//        abstract = json["abstract"] as? String ?? ""
//        published_date = json["published_date"] as? String ?? ""
//        source = json["source"] as? String ?? ""
//        id = json["id"] as? Int ?? -1
//        asset_id = json["asset_id"] as? Int ?? -1
//        views = json["views"] as? Int ?? -1
//        des_facet = json["des_facet"] as? [String] ?? []
//        org_facet = json["org_facet"] as? [String] ?? []
//        per_facet = json["per_facet"] as? [String] ?? []
//        geo_facet = json["geo_facet"] as? [String] ?? []
//        media = json["media"] as? [media] ?? []
//    }
//
//}
