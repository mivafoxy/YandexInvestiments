//
//  QueryService.swift
//  YandexInvestiments
//
//  Created by Илья Малахов on 08.07.2021.
//

import Foundation

class QueryService {
    static let headers = [
        "X-Mboum-Secret": "bRxV1i7evGkMNYX0VifI9oYjZQjMXvQIthOFa2Yu7RCLgVlH6kp5O6KOTt4C"
    ]
    
    static func getMarketStockCollections(_ completion: ((Data) -> (Void))?) {
        guard let url = NSURL(string: "https://mboum.com/api/v1/tr/trending") as URL? else {
            return
        }
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            if let error = error {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                completion?(data)
            }
        }
        
        dataTask.resume()
    }
    
    static func getStockQuotes(tickerNames: [String],  _ completion: ((Data) -> (Void))?) {
        let urlTexted = "https://mboum.com/api/v1/qu/quote/?symbol=\(tickerNames.joined(separator: ","))".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        guard let url = NSURL(string: urlTexted) as URL? else {
            return
        }
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                
                guard let data = data else {
                    return
                }
                
                completion?(data)
            }
        }
        
        dataTask.resume()
    }
    
    static func getHistoricData(of ticker: String, with interval: String, _ complition: ((Data) -> (Void))?) {
        let urlTexted = "https://mboum.com/api/v1/hi/history/?symbol=\(ticker)&interval=\(interval)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        guard let url = NSURL(string: urlTexted) as URL? else {
            return
        }
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                
                guard let data = data else {
                    return
                }
                
                complition?(data)
            }
        }
        
        dataTask.resume()
    }
}
