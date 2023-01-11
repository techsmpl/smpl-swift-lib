public struct SmplApiConfigs {
    public var configs: [Any]?;
}
public struct SmplApiDebugResponse {
    public var message: String?;
    public var code: String?;
    public var status: NSNumber?;
}

public struct SmplApiResponseData {
    public var node:SmplApiConfigs?;
    public var response: SmplApiDebugResponse?;
}

public struct SmplApiResponse {
    public var data:NSDictionary?;
    public var error:Any?;
}

public struct SmplInitialHeaders{
    public var key:AnyObject? = nil;
    public var apiKey:String = "";
}

struct ApiResponse{
    var node: PopupNode;
    var response: GenericResponse;
}
