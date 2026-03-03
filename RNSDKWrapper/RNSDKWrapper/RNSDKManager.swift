//
//  RNSDKManager.swift
//  RNSDKManager
//
//  Created by Alejandro Caralt on 2/3/26.
//

import Foundation
import UIKit
// ¡Magia anti-fugas desde el primer día! Ocultamos React del contrato público.
@_implementationOnly import React

public class RNSDKManager: NSObject {
    
    // 1. El Singleton
    public static let shared = RNSDKManager()
    
    // 2. El puente nativo
    private var bridge: RCTBridge?
    
    private override init() {
        super.init()
    }
    
    // 3. Encendido del motor (Modo Desarrollo por ahora)
    public func startEngine() {
        guard bridge == nil else { return }
        print("⚙️ [RNSDK] Arrancando motor en modo RELEASE (Offline)...")
        
        // Buscamos el bundle físico dentro de ESTE framework
        let frameworkBundle = Bundle(for: RNSDKManager.self)
        guard let jsCodeLocation = frameworkBundle.url(forResource: "main", withExtension: "jsbundle") else {
            fatalError("❌ [RNSDK] No se encontró main.jsbundle.")
        }
        
        bridge = RCTBridge(bundleURL: jsCodeLocation, moduleProvider: nil, launchOptions: nil)
        print("✅ [RNSDK] Motor arrancado con éxito (Offline)")
    }
    
    // 4. Fábrica de la vista
    public func createBlueButtonView(title: String? = nil) -> UIView {
        guard let bridge = bridge else {
            fatalError("❌ [RNSDK] Debes llamar a startEngine() antes de pedir la vista.")
        }
        
        var props: [String: Any] = [:]
        if let title = title {
            props["title"] = title
        }
        
        // El nombre "BlueButtonComponent" debe coincidir EXACTAMENTE con el AppRegistry del index.js
        let rootView = RCTRootView(
            bridge: bridge,
            moduleName: "BlueButtonComponent",
            initialProperties: props
        )
        
        return rootView
    }
}
