import Foundation

class Node<T> {
    var value: T
    var next: Node?
    
    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible, Equatable {
    var description: String {
        guard let next else { return "\(value)" }
        return "\(value) -> " + String(describing: next)
    }
    
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.next == rhs.next
    }
}

struct LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    init() {}
    
    var isEmpty: Bool {
        return head == nil
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head else { return "Empty List" }
        return String(describing: head)
    }
}

extension LinkedList {
    // Head-first insertion
    mutating func push(_ value: T) {
        let newNode = Node(value: value, next: head)
        head = newNode
        if tail == nil {
            tail = newNode
        }
    }
    
    mutating func append(_ value: T) {
        if isEmpty {
            push(value)
            return
        }
        tail?.next = Node(value: value)
        tail = tail?.next
    }
    
    func node(at index: Int) -> Node<T>? {
        if isEmpty {
            return nil
        }
        var currentNode = head
        var currentIndex = 0
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
    
    func numberOfNodes() -> Int {
        var currentNode = head
        var count = 0
        while currentNode != nil {
            currentNode = currentNode?.next
            count += 1
        }
        return count
    }
    
    mutating func insert(_ value: T, after index: Int) {
        if index < 0, index >= numberOfNodes() {
            append(value)
            return
        }
        
        if let beforeNode = node(at: index), let tail = tail {
            if beforeNode == tail {
                append(value)
            } else {
                beforeNode.next = Node(value: value, next: beforeNode.next)
            }
        } else {
            push(value)
        }
    }
    
    @discardableResult
    mutating func pop() -> T? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    mutating func deleteLast() -> T? {
        guard let head = head else { return nil }
        guard head.next != nil else { return pop() }
        
        var currentNode = head
        var previousNode = head
        while let next = currentNode.next {
            previousNode = currentNode
            currentNode = next
        }
        previousNode.next = nil
        tail = previousNode
        return currentNode.value
    }
    
    @discardableResult
    mutating func remove(after index: Int) -> T? {
        if index < 0, index >= numberOfNodes() {
            return nil
        }
        
        if let beforeNode = node(at: index) {
            defer {
                if beforeNode.next == tail {
                    tail = beforeNode
                }
                beforeNode.next = beforeNode.next?.next
            }
            return beforeNode.next?.value
        }
        return nil
    }
}


var list = LinkedList<Int>()

list.append(1)
list.append(2)
list.append(3)

print(list.description)

list.insert(4, after: 1)

print(list.description)

print(list.node(at: 2) ?? 0)

print(list.numberOfNodes())

list.pop()

print(list.description)

list.deleteLast()

print(list.description)

list.remove(after: 0)

print(list.description)