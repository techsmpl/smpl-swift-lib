//
//  Types.swift
//  Alamofire
//
//  Created by CanGokceaslan on 6.12.2022.
//

import Foundation


struct GenericStyle{
    public var color: String?;
    public var backgroundColor: String?;
}

struct GenericResponse {
    public var message: String?;
    public var code: String?;
    public var status: NSNumber?;
}

struct PopupStyles {
    public var title: GenericStyle?;
    public var description: GenericStyle?;
    public var closeButton: GenericStyle?;
    public var primaryButton: GenericStyle?;
}

struct PopupConfig {
    public var backgroundImage: String?;
    public var title: String?;
    public var description: String?;
    public var image: String?;
    public var styles: PopupStyles?;
}

struct PopupNode {
    public var configs: [PopupConfig];
}

