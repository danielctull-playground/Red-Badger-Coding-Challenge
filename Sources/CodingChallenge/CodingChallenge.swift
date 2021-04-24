
import Advent

struct IncorrectParameterCount: Error {
    let count: Int
}

public func calculatePositions(input: Input) throws -> String {

    let topRight = try input
        .lines
        .first
        .map(Position.init)
        .unwrapped()

    // Used to store the set of lost robots that can be passed into the Robot's
    // move function.
    var lost: Set<Robot> = []

    return try input.lines
        .dropFirst()
        .split(whereSeparator: { $0.isEmpty })
        .map(Array.init)
        .map { lines -> Robot in // Find the last position of each of the robots.
            guard lines.count == 2 else { throw IncorrectParameterCount(count: lines.count) }
            let initial = try Robot(rawValue: lines[0])
            let instructions: [Instruction] = try lines[1].map(Instruction.init)
            return instructions.reduce(into: initial) { robot, instruction in
                switch instruction {
                case .forward: robot.move(alreadyLost: &lost, topRight: topRight)
                case .left: robot.heading.transform(.rotate270)
                case .right: robot.heading.transform(.rotate90)
                }
            }
        }
        .map(\.description)
        .joined(separator: "\n")
}

// MARK: - Instruction

private enum Instruction: Character {
    case left = "L"
    case right = "R"
    case forward = "F"
}


// MARK: - Robot

private struct Robot: Hashable {
    var position: Position2D<Int>
    var heading: Vector2D<Int>
    var isLost = false
}

extension Robot {

    mutating func move(alreadyLost: inout Set<Robot>, topRight: Position2D<Int>) {

        func isOff(position: Position2D<Int>) -> Bool {
            position.x < 0
                || position.y < 0
                || position.x > topRight.x
                || position.y > topRight.y
        }

        // If it's lost don't move…
        guard !isLost else { return }

        guard !isOff(position: position + heading) else {
            // A little trickery here is to add the robots to the alreadyLost
            // set when isLost is false to make the contains work.
            if alreadyLost.contains(self) {
                return
            } else {
                alreadyLost.insert(self)
                isLost = true
                return
            }
        }

        position += heading
    }
}

extension Robot: CustomStringConvertible {

    var description: String {
        let headingDescription: String
        switch heading {
        case .north: headingDescription = "N"
        case .east: headingDescription = "E"
        case .south: headingDescription = "S"
        case .west: headingDescription = "W"
        default: fatalError()
        }
        let lostDescription = isLost ? " LOST" : ""

        return "\(position.x) \(position.y) \(headingDescription)\(lostDescription)"
    }
}

extension Robot {

    init<S: StringProtocol>(rawValue: S) throws {
        let split = rawValue.split(separator: " ")
        guard split.count == 3 else { throw IncorrectParameterCount(count: split.count) }
        let position = try Position(x: Int(split[0]), y: Int(split[1]))
        let heading = try Vector(rawValue: split[2])
        self.init(position: position, heading: heading)
    }
}

// MARK: - Position Initialiser

extension Position where Space == Dimension2<Int> {

    fileprivate init(rawValue: String) throws {
        let split = rawValue.split(separator: " ")
        guard split.count == 2 else { throw IncorrectParameterCount(count: split.count) }
        let x = try Int(split[0])
        let y = try Int(split[1])
        self.init(x: x, y: y)
    }
}

// MARK: - Vector Initialiser

struct DirectionError: Error {}
extension Vector where Space == Dimension2<Int> {

    fileprivate init<S: StringProtocol>(rawValue: S) throws {
        switch rawValue {
        case "N": self = .north
        case "E": self = .east
        case "S": self = .south
        case "W": self = .west
        default: throw DirectionError()
        }
    }
}
