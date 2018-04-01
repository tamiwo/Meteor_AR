//
//  ViewController.swift
//  Meteor_AR
//
//  Created by Ryota on 2018/04/01.
//  Copyright © 2018年 otutama studio. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        let labelNode = SKLabelNode(text: "👾")
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        return labelNode;
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    //コピペしたコード
    
   // func hitTest(_ point: CGPoint, types: ARHitTestResult.ResultType) -> [ARHitTestResult]
    
    func getCenter() -> SCNVector3? {
        // スマフォ画面の中央座標
        let touchLocation = sceneView.center
        // hitTestによる判定
        let hitResults = sceneView.hitTest(touchLocation, types: [.featurePoint])
        // 結果取得に成功しているかどうか
        if !hitResults.isEmpty {
            if let hitTResult = hitResults.first {
                // 実世界の座標をSCNVector3で返す
                return SCNVector3(hitTResult.worldTransform.columns.3.x, hitTResult.worldTransform.columns.3.y, hitTResult.worldTransform.columns.3.z)
            }
        }
        return nil
    }
    /*
    let position = SCNVector3Make(endPosition.x - startPosition.x, endPosition.y - startPosition.y, endPosition.z - startPosition.z)
    let distance = sqrt(position.x * position.x + position.y * position.y + position.z * position.z)
    print(String.init(format: "%.2fm", arguments: [distance]))
 */
    func createLineNode(startPosition: SCNVector3, endPosition: SCNVector3, color: UIColor) -> SCNNode {
        let indices: [Int32] = [0, 1]
        let source = SCNGeometrySource(vertices: [startPosition, endPosition])
        let element = SCNGeometryElement(indices: indices, primitiveType: .line)
        let line = SCNGeometry(sources: , elements: [element])
        line.firstMaterial?.lightingModel = SCNMaterial.LightingModel.blinn
        let lineNode = SCNNode(geometry: line)
        lineNode.geometry?.firstMaterial?.diffuse.contents = color
        return lineNode
    }

}
