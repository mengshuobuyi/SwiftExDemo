//
//  TestViewController.swift
//  MySwiftEx
//
//  Created by codyy on 2016/11/18.
//  Copyright © 2016年 zpx. All rights reserved.
//

import UIKit
import MultipeerConnectivity
class TestViewController: UIViewController {
    let peerId = MCPeerID.init(displayName: UIDevice.current.name)
    var sessionArray = [AnyObject]()
    fileprivate var session : MCSession {
        let session = MCSession.init(peer: peerId)
        session.delegate = self
        return session
    }
    fileprivate var brower:MCNearbyServiceBrowser!{
        let brower = MCNearbyServiceBrowser.init(peer: peerId, serviceType: "type")
        brower.delegate = self
        return brower
    }
    var advertiser:MCAdvertiserAssistant {
        return MCAdvertiserAssistant.init(serviceType: "type", discoveryInfo: nil, session: session)
    }
    fileprivate var browerViewController:MCBrowserViewController? {
        get{
            let bVC = MCBrowserViewController.init(serviceType: "type", session: session)
            bVC.delegate = self
            return bVC
        }
        set {
            self.browerViewController = newValue
        }
    }
    lazy var redLine:UIView = {
        let redLine = UIView()
        return redLine
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
         //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension TestViewController : MCSessionDelegate {
 
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let message = peerID.displayName + String.init(data: data, encoding: .utf8)!
        print(message)
        
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        if state == .connected {
            guard !sessionArray.contains(where: { $0 === session}) else {
                return
            }
            sessionArray.append(session)
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        
    }
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        
    }
}

extension TestViewController:MCNearbyServiceBrowserDelegate {

  
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("附近用户\(peerID.displayName)离开了")
    }

    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        self.present(browerViewController!, animated: true, completion: nil)
    }
}

extension TestViewController:MCBrowserViewControllerDelegate {

    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        self .dismiss(animated: true, completion: nil)
        browerViewController = nil
        advertiser.stop()
    }
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        self .dismiss(animated: true, completion: nil)
        browerViewController = nil
        advertiser.stop()
    }
}
