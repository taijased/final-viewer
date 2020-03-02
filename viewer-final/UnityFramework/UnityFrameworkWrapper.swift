//
//  UnityFrameworkWrapper.swift
//  ARQ-Viewer
//
//  Created by Alexey Antipin on 05/09/2019.
//  Copyright © 2019 Alexey Antipin. All rights reserved.
//

import Foundation

class UnityFrameworkWrapper
{
    private static var launchOptions : [UIApplication.LaunchOptionsKey: Any]!
    
    var unityFramework: UnityFramework!
    var unityFrameworkListener: UnityFrameworkListener
    var communicator: UNCommunicatorProtocol
    var unityIsInitialized: Bool
    {
        get
        {
            return (unityFramework != nil) && (unityFramework.appController() != nil)
        }
    }
    
    static func setLaunchOptions(_ launchOpts : [UIApplication.LaunchOptionsKey: Any]?)
    {
        UnityFrameworkWrapper.launchOptions = launchOpts
    }
    
    init(unityFrameworkListener: UnityFrameworkListener, communicator: UNCommunicatorProtocol)
    {
        unityFramework = UnityFrameworkWrapper.unityFrameworkLoad()
        self.unityFrameworkListener = unityFrameworkListener
        self.communicator = communicator
        self.communicator.unityFramework = unityFramework

    }
    
    func initializeUnity()
    {
        if unityIsInitialized
        {
            return
        }
        if unityFramework == nil
        {
            unityFramework = UnityFrameworkWrapper.unityFrameworkLoad()
        }
        unityFramework.setDataBundleId("com.unity3d.framework")
        unityFramework.register(unityFrameworkListener)
        NSClassFromString("FrameworkLibAPI")!.registerAPIforNativeCalls(communicator)
        unityFramework.runEmbedded(withArgc: CommandLine.argc, argv: CommandLine.unsafeArgv, appLaunchOpts: UnityFrameworkWrapper.launchOptions)
    }
    
    static private func unityFrameworkLoad() -> UnityFramework!
    {
        var bundlePath: String? = nil
        bundlePath = Bundle.main.bundlePath
        bundlePath = (bundlePath ?? "") + ("/Frameworks/UnityFramework.framework")
        
        let bundle = Bundle(path: bundlePath ?? "")
        
        if bundle?.isLoaded == false
        {
            bundle?.load()
        }
        
        let ufw = bundle?.principalClass?.getInstance()
        
        if ufw?.appController() == nil
        {
            let machineHeader = UnsafeMutablePointer<MachHeader>.allocate(capacity: 1)
            machineHeader.pointee = _mh_execute_header
            ufw!.setExecuteHeader(machineHeader)
        }
        return ufw
    }
    
    func addOverlappingView(view: UIView)
    {
        unityFramework.appController()?.rootView.addSubview(view)
        view.fillSuperview()
    }
    
    func showMain()
    {
        (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
        communicator.executeUnity(methodName: "OnUnityViewClosed", parameters: [], callback: {(r, e) in print("On unity closed callback") })
    }
    
    func openModel(path: String, callback: @escaping UNCallback)
    {
        communicator.executeUnity(methodName: "LoadModel", parameters: [path], callback: callback)
        print(path)
    }
    
    func unloadUnity()
    {
        if unityIsInitialized
        {
            unityFramework.unloadApplication()
            unityFramework = nil
        }
        showMain()
    }
    
    func  showUnityView()
    {
        unityFramework.showUnityWindow()
     
    }
}
