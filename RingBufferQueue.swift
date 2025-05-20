import Foundation

struct RingBufferQueue<T> {
    private var elements: [T?]
    private var front = -1
    private var rear = -1
    
    init(count: Int) {
        elements = Array(repeating: nil, count: count)
    }
    
    var isEmpty: Bool {
        return front == -1 && rear == -1
    }
    
    var isFull: Bool {
        return (rear + 1) % elements.count == front
    }
    
    var peek: T? {
        if isEmpty { return nil }
        return elements[front]
    }
}

extension RingBufferQueue: CustomStringConvertible {
    var description: String {
        if isEmpty { return "Queue is Empty ... " }
        return "---- Queue Start ----\n" + elements.map{ "\(String(describing: $0))" }.joined(separator: " <- ") + "\n---- Queue End ----"
    }
}

extension RingBufferQueue {
    // to enqueue an element
    mutating func enqueue(_ element: T) -> Bool {
        // if queue is empty
        if front == -1 && rear == -1 {
            front = 0
            rear = 0
            elements[rear] = element
            return true
        }
        
        if isFull {
            print("Queue is Full ... ")
            return false
        }
        
        rear = (rear + 1) % elements.count
        elements[rear] = element
        return true
    }
    
    // to dequeue an element
    mutating func dequeue() -> T? {
        if isEmpty {
            print("Queue is Empty ... ")
            return nil
        }
        
        // if queue has only single element
        if front == rear {
            defer {
                elements[front] = nil
                front = -1
                rear = -1
            }
            return elements[front]
        }
        
        defer {
            elements[front] = nil
            front = (front + 1) % elements.count
        }
        return elements[front]
    }
}