import Foundation

public struct Queue<T> {
    private var array: [T] = []
    
    public var count: Int {
        return array.count
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    @discardableResult
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public var peek: T? {
        return array.first
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        if isEmpty { return "Queue is Empty ..." }
        return "---- Queue Start ----\n" + array.map{ "\($0)" }.joined(separator: " <- ") + "\n---- Queue End ----"
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