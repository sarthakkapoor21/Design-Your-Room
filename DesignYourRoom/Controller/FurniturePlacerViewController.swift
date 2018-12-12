//
//  ViewController.swift
//  DesignYourRoom
//
//  Created by Sarthak Kapoor on 14/11/18.
//  Copyright © 2018 Sarthak Kapoor. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class FurniturePlacerViewController: UIViewController, ARSCNViewDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var selectedFurnitureName: String?
    var selectedFurniture: SCNNode?
    @IBOutlet weak var controlButtonStack: UIStackView!
    
    @IBOutlet weak var rotateButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/objects/main.scn")!
        sceneView.autoenablesDefaultLighting = true
        
        // Set the scene to the view
        sceneView.scene = scene
        
        let rotateGesture = UILongPressGestureRecognizer(target: self, action: #selector(onlongPress(gesture:)))
        let upGesture = UILongPressGestureRecognizer(target: self, action: #selector(onlongPress(gesture:)))
        let downGesture = UILongPressGestureRecognizer(target: self, action: #selector(onlongPress(gesture:)))
        
        rotateGesture.minimumPressDuration = 0.1
        upGesture.minimumPressDuration = 0.1
        downGesture.minimumPressDuration = 0.1
        
        rotateButton.addGestureRecognizer(rotateGesture)
        upButton.addGestureRecognizer(upGesture)
        downButton.addGestureRecognizer(downGesture)
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

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        
        let results = sceneView.hitTest(touch.location(in: sceneView), types: [.featurePoint])
        
        guard let hitFeature = results.last else { return }
        
        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
        let hitPosition = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
        
        placeFurniture(position: hitPosition)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func furnitureButtonPressed(_ sender: UIButton) {
        
        let furniturePickerViewController = FurniturePickerViewController(size: CGSize(width: 250, height: 500))
        furniturePickerViewController.furniturePlacerViewController = self
        furniturePickerViewController.modalPresentationStyle = .popover
        furniturePickerViewController.popoverPresentationController?.delegate = self
        present(furniturePickerViewController, animated: true)
        furniturePickerViewController.popoverPresentationController?.sourceView = sender
        furniturePickerViewController.popoverPresentationController?.sourceRect = sender.bounds
        
    }
    
    func onFurnitureSelected(_ furnitureName: String) {
        
        selectedFurnitureName = furnitureName
        controlButtonStack.isHidden = false
    }
    
    func placeFurniture(position: SCNVector3) {
        
        if let furnitureName = selectedFurnitureName {
            
            let furniture = Furniture.getFurnitureForName(furnitureName: furnitureName)
            selectedFurniture = furniture
            furniture.position = position
            furniture.scale = SCNVector3Make(0.01, 0.01, 0.01)
            sceneView.scene.rootNode.addChildNode(furniture)
        }
    }
    
    @IBAction func removeButtonPressed(_ sender: Any) {
        
        if let furniture = selectedFurniture {
            
            furniture.removeFromParentNode()
            selectedFurniture = nil
        }
    }
    
    @objc func onlongPress(gesture: UILongPressGestureRecognizer!) {
        
        if let furniture = selectedFurniture {
            
            if gesture.state == .ended {
                
                furniture.removeAllActions()
            } else if gesture.state == .began {
                
                if gesture.view === rotateButton {
                    
                    let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.08 * Double.pi), z: 0, duration: 0.1))
                    furniture.runAction(rotate)
                } else if gesture.view === upButton {
                    
                    let move = SCNAction.repeatForever(SCNAction.moveBy(x: 0, y: 0.08, z: 0, duration: 0.1))
                    furniture.runAction(move)
                } else if gesture.view === downButton {
                    
                    let move = SCNAction.repeatForever(SCNAction.moveBy(x: 0, y: -0.08, z: 0, duration: 0.1))
                    furniture.runAction(move)
                } else {
                    
                }
            }
        }
    }
    
    
}
