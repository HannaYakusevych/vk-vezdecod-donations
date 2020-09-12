//
//  NetworkService.swift
//  VKDonations
//
//  Created by Анна Якусевич on 12.09.2020.
//  Copyright © 2020 Hanna Yakusevych. All rights reserved.
//

import Foundation
import UIKit

final class NetworkService {
    
    let endpoint = "https://vkhackstub.herokuapp.com/donate"
    
    let queue = DispatchQueue(label: "creation_screen", qos: .userInitiated)
    
    func createDonate(donate: Donate, completion: ((Result<String, Error>) -> Void)?) {
        print("creating donate")
        queue.async {
            guard let url = URL(string: "\(self.endpoint)/create") else {
                print("Error: cannot create URL")
                completion?(.failure(NSError()))
                return
            }
            // Create the url request
            var request = URLRequest(url: url)
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let encoder = JSONEncoder()
            //                    encoder.dateEncodingStrategy = .millisecondsSince1970
            encoder.dateEncodingStrategy = .custom({ date, encoder in
                let milliseconds = Int((date.timeIntervalSince1970 * 1000.0).rounded())
                var singleValueEnc = encoder.singleValueContainer()
                try singleValueEnc.encode(milliseconds)
            })
            do {
                let jsonData = try encoder.encode(donate)
                request.httpBody = jsonData
                print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
            } catch {
                completion?(.failure(NSError()))
                print("ERROR")
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: \(error!)")
                    completion?(.failure(error!))
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    completion?(.failure(NSError()))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    completion?(.failure(NSError()))
                    return
                }
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        completion?(.failure(NSError()))
                        return
                    }
                    
                    completion?(.success(jsonObject["id"] as? String ?? ""))
                    
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    print(prettyPrintedJson)
                } catch {
                    completion?(.failure(NSError()))
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
    }
    
    func createPost() {
        
    }
    
    func saveImage(image: UIImage, id: String) {
        guard let url = URL(string: "\(endpoint)/image/\(id)") else {
            print("Error: cannot create URL")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let data = Data(base64Encoded: image.toBase64()!, options: .ignoreUnknownCharacters)
        request.httpBody = data
        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")

        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Data: \(data)")
            print("Response: \(response)")
            print("Error: \(error)")
        }.resume()
    }
    
    func getList() {
        
    }
    
    func clear() {
        
    }
}
