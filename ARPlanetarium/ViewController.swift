//
//  ViewController.swift
//  ARPlanetarium
//
//  Created by Oscar Castillo on 12/6/20.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        sceneView.session.run(configuration)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createPlanets()
    }
    
    
    func createPlanets() {
        let sunPosition = SCNVector3(0,0,-1)
        
        let sun = createPlanetNode(geometry: SCNSphere(radius: 0.3),
                                   position: sunPosition,
                                   diffuse: .sunDiffuse)
        sceneView.scene.rootNode.addChildNode(sun)
        sun.geometry?.firstMaterial?.diffuse.contents = PlanetImages.sunDiffuse.makeImage()
        
        let earth = createPlanetNode(geometry: SCNSphere(radius: 0.05),
                                   position: SCNVector3(1,0,0),
                                   diffuse: .earthDiffuse,
                                   specular: .earthSpecular,
                                   normal: .earthNormal,
                                   emission: .earthClouds)
        
        let earthParent = SCNNode()
        earthParent.position = sunPosition
        earthParent.addChildNode(earth)
        sceneView.scene.rootNode.addChildNode(earthParent)
        sun.runAction(RotationAction(15))
        earth.runAction(RotationAction(8))
        earthParent.runAction(RotationAction(5))
    }
    
    func createPlanetNode(geometry: SCNGeometry,
                          position: SCNVector3,
                          diffuse: PlanetImages,
                          specular: PlanetImages? = nil,
                          normal: PlanetImages? = nil,
                          emission: PlanetImages? = nil) -> SCNNode {
        let planetNode = SCNNode(geometry: geometry)
        planetNode.geometry?.firstMaterial?.diffuse.contents = diffuse.makeImage()
        planetNode.geometry?.firstMaterial?.specular.contents = specular?.makeImage()
        planetNode.geometry?.firstMaterial?.normal.contents = normal?.makeImage()
        planetNode.geometry?.firstMaterial?.emission.contents = emission?.makeImage()
        planetNode.position = position
        
        return planetNode
    }
    
    func RotationAction(_ timeRotation: TimeInterval) -> SCNAction {
        let nodeRotation = SCNAction.rotateBy(x: 0,
                                          y: CGFloat(360.toRadians),
                                          z: 0,
                                          duration: timeRotation)
        let continueAction = SCNAction.repeatForever(nodeRotation)
        return continueAction
    }
}

extension Int {
    var toRadians: Double { return Double(self) * .pi/180 }
}
