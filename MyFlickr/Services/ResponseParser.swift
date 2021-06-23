//
//  ResponseParser.swift
//  MyFlickr
//
//  Created by Nirmal Choudhari on 20/06/21.
//

import Foundation
import UIKit.UIImage


protocol Parser {
    associatedtype ResposneType
    func handleResposne(_ resposne: APIResponse) -> APIServiceResult<ResposneType>
}
/// A Generic API parser which accepts the Template type to decode and parse given resposne
struct ResponseParser<T>: Parser where T: Codable {
    typealias ResposneType = T

    
    /// Computes the APIService result based on the given API resposne
    /// - Parameter resposne: API resposne from Network Layer
    /// - Returns: APIService Result of template type
    func handleResposne(_ resposne: APIResponse) -> APIServiceResult<T> {
        if let error = resposne.error  {
            return APIServiceResult.error(.fetchFailed(error))
        }
        guard let data = resposne.data else {
            return APIServiceResult.error(.noData)
        }
        print(String(decoding: data, as: UTF8.self))
        guard let parsedResposne = parse(responseData: data) else {
            return APIServiceResult.error(.serelization)
        }
        return APIServiceResult.result(parsedResposne)
    }

    private func parse(responseData: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: responseData)
            return result
        } catch {
            print(error)
            return nil
        }
    }
}


/// Image Resposne Parser
struct ImageResposneParser: Parser {
    
    typealias ResposneType = UIImage

    /// Converst the resposne data to an UIImage object
    /// - Parameter resposne: API reposne for the image download
    /// - Returns: an APIResult with the image from resposne data
    func handleResposne(_ resposne: APIResponse) -> APIServiceResult<UIImage> {
        if let error = resposne.error  {
            return APIServiceResult.error(.fetchFailed(error))
        }
        guard let data = resposne.data,
              let image = UIImage(data: data) else {
            return APIServiceResult.error(.noData)
        }

        return APIServiceResult.result(image)
    }

}
