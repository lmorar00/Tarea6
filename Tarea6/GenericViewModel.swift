//
//  GenericViewModel.swift
//  Tarea6
//
//  Created by Luis Mora Rivas on 24/9/21.
//

import Foundation

public struct GenericViewModel<Model: Codable> {
    public typealias SuccessComplention = (_ response: Model) -> Void
    
    static func httpGet(path: String, url: String, success successCallback: @escaping SuccessComplention) {
        // Asegurarnos de tener una URL utilizable, si no se llama al delegado para mostrar un error
        guard let urlComponent = URLComponents(string: url), let usableUrl = urlComponent.url else {
            print("Error")
            return
        }
        
        //Crea el request
        var request = URLRequest(url: usableUrl)
        
        //Define el tipo de metodo http
        request.httpMethod = "GET"
        
        var dataTask: URLSessionDataTask?
        let defaultSession = URLSession(configuration: .default)
        
        dataTask =
            defaultSession.dataTask(with: request) { data, response, error in
                defer {
                    dataTask = nil
                }
                if error != nil {
                    print("Error")
                } else if
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    guard let model = self.parsedModel(with: data, at: path) else {
                        print("Error")
                        return
                    }
                    successCallback(model)
                }
        }
        dataTask?.resume()
    }
    
    //Deserializa el modelo
    static func parsedModel(with data: Data, at path: String) -> Model? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary

            if let dictAtPath = json?.value(forKeyPath: path) {
                let jsonData = try JSONSerialization.data(withJSONObject: dictAtPath,
                                                          options: .prettyPrinted)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let model =  try decoder.decode(Model.self, from: jsonData)
                return model
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
