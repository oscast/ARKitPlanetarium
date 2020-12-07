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
    let sunPosition = SCNVector3(0,0,-1)
    
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
        createSun()
        createEarth()
        createMercury()
    }
    
    func createSun() {
        let sun = createPlanetNode(geometry: SCNSphere(radius: 0.3),
                                   position: sunPosition,
                                   diffuse: .sunDiffuse)
        sceneView.scene.rootNode.addChildNode(sun)
        sun.geometry?.firstMaterial?.diffuse.contents = PlanetImages.sunDiffuse.makeImage()
        sun.runAction(RotationAction(15))
    }
    
    func createEarth() {
        let earth = createPlanetNode(geometry: SCNSphere(radius: 0.05),
                                   position: SCNVector3(1,0,0),
                                   diffuse: .earthDiffuse,
                                   specular: .earthSpecular,
                                   normal: .earthNormal,
                                   emission: .earthClouds)
        
        let earthParent = createParentNode(position: sunPosition)
        earthParent.addChildNode(earth)
        earthParent.runAction(RotationAction(5))
        earth.runAction(RotationAction(8))
    }
    
    func createMercury() {
        let mercuryParent = createParentNode(position: sunPosition)
        let mercury = createPlanetNode(geometry: SCNSphere(radius: 0.05),
                                       position: SCNVector3(0.45,0,0),
                                       diffuse: .mercuryDiffuse)
        mercuryParent.addChildNode(mercury)
        mercury.runAction(RotationAction(5))
        mercuryParent.runAction(RotationAction(2))
    }
    
    
    func createParentNode(position: SCNVector3) -> SCNNode {
        let node = SCNNode()
        node.position = position
        sceneView.scene.rootNode.addChildNode(node)
        return node
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
