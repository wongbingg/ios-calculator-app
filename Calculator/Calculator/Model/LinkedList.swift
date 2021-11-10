//
//  LinkedList.swift
//  Calculator
//
//  Created by Jun Bang on 2021/11/09.
//
import Foundation

class Node<T> {
    var item: T
    var next: Node?
    var previous: Node?
    
    init(item: T) {
        self.item = item
    }
}

struct LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    var isNotEmpty: Bool {
        return head != nil
    }
    
    mutating func append(_ item: T) {
        let newNode = Node(item: item)
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    mutating func removeFront() -> Node<T>? {
        guard isNotEmpty else {
            return nil
        }
        guard let oldHead = head else {
            return nil
        }
        guard let newHead = oldHead.next else {
            head = nil
            return oldHead
        }
        head = newHead
        return oldHead
    }
}
