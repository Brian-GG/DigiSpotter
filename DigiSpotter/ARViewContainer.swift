//
//  ARViewContainer.swift
//  BodyTracking2022
//
//  Created by Kareem Ghadban on 2022-09-17.
//

import SwiftUI
import ARKit
import RealityKit
import SwiftUI

private var bodySkeleton: BodySkeleton?
private let bodySkeletonAnchor = AnchorEntity()

struct ARViewContainer: UIViewRepresentable{
    typealias UIViewType = ARView
    
    func makeUIView(context: Context) -> ARView{
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        arView.setupBodyForTracking()
        arView.scene.addAnchor(bodySkeletonAnchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}

extension ARView: ARSessionDelegate{
    func setupBodyForTracking(){
        let configuration = ARBodyTrackingConfiguration()
        self.session.run(configuration)
        
        self.session.delegate = self
    }
    
    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            if let bodyAnchor = anchor as? ARBodyAnchor{
                if let skeleton = bodySkeleton{
                    skeleton.update(with: bodyAnchor)
                } else{
                    bodySkeleton = BodySkeleton(for: bodyAnchor)
                    bodySkeletonAnchor.addChild(bodySkeleton!)
                }
            }
        }
    }
}
