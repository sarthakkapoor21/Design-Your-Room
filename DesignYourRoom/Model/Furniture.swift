//
//  Furniture.swift
//  DesignYourRoom
//
//  Created by Sarthak Kapoor on 02/12/18.
//  Copyright © 2018 Sarthak Kapoor. All rights reserved.
//

import Foundation
import SceneKit

class Furniture {
    
    class func getFurnitureForName(furnitureName: String) -> SCNNode {
        
        switch furnitureName {
            
//        case "chair":
//            return getPipe()
        case "table":
            return getPyramid()
//        case "computer_table":
//            return getQuarter()
        default:
            return getPyramid()
        }
    }
    
//    class func getPipe() -> SCNNode {
//        
//        let pipe = SCNScene(named: "art.scnassets/objects/chair.dae")
//        let pipeNode = pipe?.rootNode.childNode(withName: "chair", recursively: true)!
//        pipeNode?.scale = SCNVector3Make(0.02, 0.02, 0.02)
//        pipeNode?.position = SCNVector3Make(-2.35, 1, -1.2)
//        return pipeNode!
//    }
    
    class func getPyramid() -> SCNNode {
        
        let pyramid = SCNScene(named: "art.scnassets/objects/table.dae")
        let pyramidNode = pyramid?.rootNode.childNode(withName: "table", recursively: true)!
        pyramidNode?.scale = SCNVector3Make(0.033, 0.033, 0.033)
        pyramidNode?.position = SCNVector3Make(-2.35, -0.5, -1.2)
        return pyramidNode!
    }
    
//    class func getQuarter() -> SCNNode {
//
//        let quarter = SCNScene(named: "art.scnassets/objects/computer_table.dae")
//        let quarterNode = quarter?.rootNode.childNode(withName: "computer_table", recursively: true)!
//        quarterNode?.scale = SCNVector3Make(0.003, 0.003, 0.003)
//        quarterNode?.position = SCNVector3Make(-2.35, -1, -1.2)
//        return quarterNode!
//    }
    
    class func startRotation(node: SCNNode) {
        
        let rotate = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: CGFloat(0.01 * Double.pi), z: 0, duration: 0.1))
        node.runAction(rotate)
    }
    
}
