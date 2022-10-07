//
//  TrieNode.swift
//  Code_Test
//
//  Created by Thinzar Soe on 10/7/22.
//

import Foundation

class TrieNode<T: Hashable> {
    typealias Node = TrieNode<T>
    
    var value: T?
    var isTerminating = false
    var children: [T: Node] = [:]
    weak var parent: Node?
    
    var isLeaf: Bool {
        return children.count == 0
    }
    
    init(value: T? = nil, parent: Node? = nil) {
        self.value = value
        self.parent = parent
    }
    
    func add(child: T) -> Node {
        if let childNode = children[child] {
            return childNode
        } else {
            let newNode = Node(value: child, parent: self)
            children[child] = newNode
            return newNode
        }
    }
}
