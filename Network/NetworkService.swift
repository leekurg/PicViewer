//
//  NetworkService.swift
//  PicViewer
//
//  Created by Ильяяя on 20.05.2022.
//

import Foundation

enum NetworkError : String {
    case ConnectionError = "Internet connection has been lost"
    case ServiceError = "Server answer is incorrect"
}

class NetworkService {
    let accessKey = "M9YU6SWPK45Eh0MKhz1e8dbT68ly62P5n2PTVl3MZfA"
    let secretKey = "g0oa9167tLZI4NugQf8Cxh7wLP5LT6pwD12Enyy6fgI"
    
    struct Adress{
        let schema:String
        let host:String
        let path:String
    }
    let adressComponents:Adress
    init(){
        adressComponents = Adress(schema: "https", host: "api.unsplash.com", path: "/photos/random")
    }
    
    func request(comp: @escaping (Data?,Error?) -> Void){
        let url = url(/*params: prepareParams()*/)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeaders()
        request.httpMethod = "get"
        let task = createDataTask(from: request, comp: comp)
        task.resume()
    
    }
    
    private func prepareHeaders() -> [String:String]?{
        var headers = [String:String]()
        headers["Authorization"] = String("Client-ID \(accessKey)")
        return headers
    }
    
    private func prepareParams() -> [String:String]{
        var params = [String:String]()
        params["orientation"] = "portrait"  //portrait landscape
        
        return params
    }
    
    private func url(params : [String:String] = [:]) -> URL{
        var components = URLComponents()
        components.scheme = adressComponents.schema
        components.host = adressComponents.host
        components.path = adressComponents.path
        components.queryItems = params.map{
            URLQueryItem(name: $0, value: $1)
        }
        return components.url!
    }
    
    private func createDataTask(from request:URLRequest, comp:@escaping (Data?, Error?) -> Void) -> URLSessionDataTask{
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                comp(data,error)
            }
        }
    }
}
