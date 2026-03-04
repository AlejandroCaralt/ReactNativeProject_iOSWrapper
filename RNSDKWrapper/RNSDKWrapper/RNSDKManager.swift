//
//  RNSDKManager.swift
//  RNSDKManager
//
//  Created by Alejandro Caralt on 2/3/26.
//

import Foundation
import UIKit
internal import React

public class RNSDKManager: NSObject {

    public static let shared = RNSDKManager()
    private var bridge: Any?
    
    private override init() {
        super.init()
    }

    public func startEngine() {
        guard bridge == nil else { return }

        let frameworkBundle = Bundle(for: RNSDKManager.self)
        guard let jsCodeLocation = frameworkBundle.url(forResource: "main", withExtension: "jsbundle") else {
            fatalError("main.jsbundle not found.")
        }
        
        bridge = RCTBridge(bundleURL: jsCodeLocation, moduleProvider: nil, launchOptions: nil)
    }

    public func createBlueButtonView(title: String? = nil) -> UIView {
        guard let bridge = bridge as? RCTBridge else {
            fatalError("Engine not started")
        }
        
        var props: [String: Any] = [:]
        if let title = title {
            props["title"] = title
        }

        let rootView = RCTRootView(
            bridge: bridge,
            moduleName: "BlueButtonComponent",
            initialProperties: props
        )
        
        return rootView
    }
}
