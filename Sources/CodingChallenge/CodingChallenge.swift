
import Advent

struct IncorrectParameterCount: Error {
    let count: Int
}

public func calculatePositions(input: Input) throws -> String {

    let upperRightPosition = try input
        .lines
        .first
        .map(Position2D.init(rawValue:))
        .unwrapped()

    func isOff(position: Position2D<Int>) -> Bool {
        position.x < 0
            || position.y < 0
            || position.x > upperRightPosition.x
            || position.y > upperRightPosition.y
    }

    var lost: Set<RobotPosition> = []

    return try input.lines
        .dropFirst()
        .split(whereSeparator: { $0.isEmpty })
        .map(Array.init)
        .map { lines -> RobotPosition in
            guard lines.count == 2 else { throw IncorrectParameterCount(count: lines.count) }
            let initial = try RobotPosition(rawValue: lines[0])
            let instructions: [Instruction] = try lines[1].map(Instruction.init)
            return instructions.reduce(into: initial) { robot, instruction in
                switch instruction {
                case .forward: robot.move(lost: lost)
                case .left: robot.heading.transform(.rotate270)
                case .right: robot.heading.transform(.rotate90)
                }
            }
        }
        .map(\.description)
        .joined(separator: "\n")
}

struct RobotPosition: Hashable {
    var position: Position2D<Int>
    var heading: Vector2D<Int>

    mutating func move(lost: Set<RobotPosition>) {
        guard !lost.contains(self) else { return }
        position += heading
    }
}

extension RobotPosition: CustomStringConvertible {

    var description: String {
        let headingDescription: String
        switch heading {
        case .north: headingDescription = "N"
        case .east: headingDescription = "E"
        case .south: headingDescription = "S"
        case .west: headingDescription = "W"
        default: fatalError()
        }

        return "\(position.x) \(position.y) \(headingDescription)"
    }
}

extension RobotPosition {

    init<S: StringProtocol>(rawValue: S) throws {
        let split = rawValue.split(separator: " ")
        guard split.count == 3 else { throw IncorrectParameterCount(count: split.count) }
        let position = try Position2D(x: Int(split[0]), y: Int(split[1]))
        let heading = try Vector2D(rawValue: split[2])
        self.init(position: position, heading: heading)
    }
}

extension Position2D where Space == Dimension2<Int> {

    init(rawValue: String) throws {
        let split = rawValue.split(separator: " ")
        guard split.count == 2 else { throw IncorrectParameterCount(count: split.count) }
        let x = try Int(split[0])
        let y = try Int(split[1])
        self.init(x: x, y: y)
    }
}

struct DirectionError: Error {}
extension Vector where Space == Dimension2<Int> {

    init<S: StringProtocol>(rawValue: S) throws {
        switch rawValue {
        case "N": self = .north
        case "E": self = .east
        case "S": self = .south
        case "W": self = .west
        default: throw DirectionError()
        }
    }
}

enum Instruction: Character {
    case left = "L"
    case right = "R"
    case forward = "F"
}
