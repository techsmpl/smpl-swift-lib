//
//  ViewController.swift
//  Smpl
//
//  Created by cangokceaslan on 11/17/2022.
//  Copyright (c) 2022 cangokceaslan. All rights reserved.
//

import UIKit;
import SwiftUI;
import Smpl;

class ViewController: UIViewController {

    @IBOutlet var theContainer: UIView!;

    override func viewDidLoad(){
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        //let response = Smpl.smplApi(path: "/todos", params: ["test":1,"Deneme":"abc"], httpMethod: .get);
		let childView = UIHostingController(rootView: renderer())
        addChildViewController(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
        childView.didMove(toParent: self)
        /* Task{
            let response = await SmplApi.get(path: "/todos/1", params:["test":1,"Deneme":"abc"])
            let arr = response.data;
            print(arr);
            print("Response", response.data)
            
            }
         */
        logEvent(key: "DEMO-01", parameters: ["category":"ust_giyim"])
		//logEvent(key: "BASKET_PAGE", parameters: ["category":"ust_giyim"])
        //logUserEvent(parameters: ["name":"Can","surname":"Gökçeaslan","phoneNumber": "5444850586", "email":"can.gokceaslan@barty.app","birthDate":"1995-07-04"])
            //print(response.data.value(forKey:"Deneme"))
        
        
        //print(response);
        //let view = PopupView()
        //let view = Smpl.PopupView()
        //extractViews()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

