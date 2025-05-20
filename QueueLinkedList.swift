import Foundation

// Queue Using Singly Linked List
class Node<T> {
    var value: T
    var next: Node<T>?
    
    init(value: T, next: Node<T>? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next else { return "\(value)" }
        return "\(value) <- " + String(describing: next)
    }
}

struct Queue<T> {
    var front: Node<T>?
    var rear: Node<T>?
    
    var isEmpty: Bool {
        return front == nil
    }
    
    var peek: T? {
        return front?.value
    }
}

extension Queue {
    mutating func push(_ value: T) {
        front = Node(value: value)
        if rear == nil {
            rear = front
        }
    }
    
    mutating func enqueue(_ value: T) {
        if isEmpty {
            push(value)
            return
        }
        rear?.next = Node(value: value)
        rear = rear?.next
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        defer {
            front = front?.next
            if isEmpty {
                rear = nil
            }
        }
        return front?.value
    }
}


extension Queue: CustomStringConvertible {
    var description: String {
        guard let front else { return "Empty Queue" }
        return String(describing: front)
    }
}

var queue = Queue<Int>()

print(queue.description)

queue.enqueue(5)
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
queue.enqueue(4)
queue.enqueue(5)

print(queue.description)

queue.dequeue()

print(queue.description)

if let peekedValue = queue.peek {
    print("Peeked Value:", peekedValue)
}

print(queue.description)

queue.dequeue()

print(queue.description)