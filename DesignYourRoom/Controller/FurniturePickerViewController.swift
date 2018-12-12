//
//  FurniturePickerViewController.swift
//  DesignYourRoom
//
//  Created by Sarthak Kapoor on 28/11/18.
//  Copyright © 2018 Sarthak Kapoor. All rights reserved.
//

import UIKit
import SceneKit

class FurniturePickerViewController: UIViewController {

    var sceneView: SCNView!
    var size: CGSize!
    
    weak var furniturePlacerViewController: FurniturePlacerViewController!
    
    init(size: CGSize) {
        super.init(nibName: nil, bundle: nil)
        self.size = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.frame = CGRect(origin: CGPoint.zero, size: size)
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.insertSubview(sceneView, at: 0)
        
        view.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.borderWidth = 3.0
        
        let scene = SCNScene(named: "art.scnassets/objects/furniture.scn")!
        sceneView.scene = scene
        
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        scene.rootNode.camera = camera
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tap)
        
//        let pipe = Furniture.getPipe()
//        Furniture.startRotation(node: pipe)
//        scene.rootNode.addChildNode(pipe)
        
        let pyramid = Furniture.getPyramid()
        Furniture.startRotation(node: pyramid)
        scene.rootNode.addChildNode(pyramid)
        
//        let quarter = Furniture.getQuarter()
//        Furniture.startRotation(node: quarter)
//        scene.rootNode.addChildNode(quarter)
        
//        let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.1))
//
//        let pipe = SCNScene(named: "art.scnassets/objects/pipe.dae")
//        let pipeNode = pipe?.rootNode.childNode(withName: "pipe", recursively: true)!
//        pipeNode?.runAction(rotate)
//        pipeNode?.scale = SCNVector3Make(0.002, 0.002, 0.002)
//        pipeNode?.position = SCNVector3Make(-2.35, 1, -1.2)
//        scene.rootNode.addChildNode(pipeNode!)
//
//        let pyramid = SCNScene(named: "art.scnassets/objects/pyramid.dae")
//        let pyramidNode = pyramid?.rootNode.childNode(withName: "pyramid", recursively: true)!
//        pyramidNode?.runAction(rotate)
//        pyramidNode?.scale = SCNVector3Make(0.004, 0.004, 0.004)
//        pyramidNode?.position = SCNVector3Make(-2.35, 0, -1.2)
//        scene.rootNode.addChildNode(pyramidNode!)
//
//        let quarter = SCNScene(named: "art.scnassets/objects/quarter.dae")
//        let quarterNode = quarter?.rootNode.childNode(withName: "quarter", recursively: true)!
//        quarterNode?.runAction(rotate)
//        quarterNode?.scale = SCNVector3Make(0.003, 0.003, 0.003)
//        quarterNode?.position = SCNVector3Make(-2.35, -1, -1.2)
//        scene.rootNode.addChildNode(quarterNode!)
        
        preferredContentSize = size
    }
    
    @objc func handleTap(_ tapGestureRecogniser: UITapGestureRecognizer) {
        
        let position = tapGestureRecogniser.location(in: sceneView)
        let hitResults = sceneView.hitTest(position, options: [:])
        
        if hitResults.count > 0 {
            
            let node = hitResults[0].node
            print(node.name!)
            furniturePlacerViewController.onFurnitureSelected(node.name!)
            dismiss(animated: true, completion: nil)
//            switch node.name! {
//            case "pipe":
//                furniturePlacerViewController.onFurnitureSelected("pipe")
//                break
//            case "pyramid":
//                furniturePlacerViewController.onFurnitureSelected("pyramid")
//                break
//            case "quarter":
//                furniturePlacerViewController.onFurnitureSelected("quarter")
//                break
//            default:
//                print("it me")
//            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
