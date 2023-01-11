//
//  HTTPClient.swift
//  Smpl
//
//  Created by CanGokceaslan on 17.11.2022.
//

import Foundation;
import Alamofire;

private var endpointUrl = "https://apiv2-test.hellosmpl.com/app"; //"http://127.0.0.1/api";

private var parameters: Parameters = ["name":"Can", "surname":"Gökçeaslan"];

private func prepareRequestPathWithQueryParameters(path:String, parameters: Parameters)->URL?{
    var urlStr: String = endpointUrl + path;
    var addedQuestionMark = false;
    for (key, value) in parameters {
        //let queryItem =  URLQueryItem(name: key, value: String(describing:value));
        let strValue = String(describing:value);
        if(addedQuestionMark == false){
            addedQuestionMark = true;
            urlStr += "?" + key + "=" + strValue;
        }else{
            urlStr += "&" + key + "=" + strValue;
        }
    }
    let url: URL? = URL(string:(urlStr));
    
    //print(url?.absoluteURL ?? "URL NOT FOUND");
    
    return url?.absoluteURL;
}

public class SmplApi {
    public init(){
        
    }
    
    
    static func prepareResponse(continuation:CheckedContinuation<SmplApiResponse, Never>, response: AFDataResponse<Data>){
        switch response.result {
        case .success(let data):
            do {
                let asJSON = try JSONSerialization.jsonObject(with: data);
                // Handle as previously success
                continuation.resume(returning: SmplApiResponse(data:asJSON as? NSDictionary))
            } catch {
                continuation.resume(returning: SmplApiResponse(error: ["message":"Error occurred"]));
            }
        case .failure(let error):
            //print("Error",error);
            continuation.resume(returning: SmplApiResponse(error: error))
            //continuation.resume(returning: [error:[err:error]])
        }
    }
    
    /**
        GET METHOD FOR SMPL API ENDPOINT
    */
    
    public static func get(path:String, params: Parameters,headers: HTTPHeaders)async->SmplApiResponse{
        let url = prepareRequestPathWithQueryParameters(path: path, parameters: params)!;
        let response = await withCheckedContinuation({ continuation in
            AF.request(url,
               method:.get,
               encoding: JSONEncoding.default,
               headers: headers
            ).responseData { response in
                prepareResponse(continuation: continuation, response: response)
            }
        })
        //print(response)
        return response;
    }
    public static func post(path:String, params: Parameters, headers: HTTPHeaders)async->SmplApiResponse{
        //print("path:",(endpointUrl + path), "parameters", params,"headers:",headers)
        let response = await withCheckedContinuation({ continuation in
            //print("path:",(endpointUrl + path), "parameters", params)
            AF.request((endpointUrl + path),
                            method:.post,
                            parameters:params,
                            encoding: JSONEncoding.default,
                            headers: headers
            ).responseData { response in
                //print(response)
                prepareResponse(continuation: continuation, response: response)
    
        }
        })
        //print(response)
        return response;
    }
    
    public static func put(path:String, params: Parameters,headers: HTTPHeaders)async->SmplApiResponse{
        let response = await withCheckedContinuation({ continuation in
            AF.request((endpointUrl + path),
                    method: .put,
                    parameters:params,
                    encoding: JSONEncoding.default,
                    headers: headers
            ).responseData { response in
                prepareResponse(continuation: continuation, response: response)
    
        }
        })
        //print(response)
        return response;
    }
    
    public static func patch(path:String, params: Parameters,headers: HTTPHeaders)async->SmplApiResponse{
        let response = await withCheckedContinuation({ continuation in
            AF.request((endpointUrl + path),
                            method:.patch,
                            parameters:params,
                            encoding: JSONEncoding.default,
                            headers: headers
            ).responseData { response in
                prepareResponse(continuation: continuation, response: response)
    
        }
        })
        //print(response)
        return response;
    }
    
    public static func delete(path:String, params: Parameters,headers: HTTPHeaders)async->SmplApiResponse{
        let url = prepareRequestPathWithQueryParameters(path: path, parameters: params)!;
        let response = await withCheckedContinuation({ continuation in
            AF.request(url,
               method:.delete,
               encoding: JSONEncoding.default,
               headers: headers
            ).responseData { response in
                prepareResponse(continuation: continuation, response: response)
            }
        })
        //print(response)
        return response;
    }
    
    
}
