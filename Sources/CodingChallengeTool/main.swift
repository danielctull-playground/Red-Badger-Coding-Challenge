
import Advent
import ArgumentParser
import CodingChallenge
import Foundation

extension Input: ExpressibleByArgument {

    public init?(argument: String) {
        guard let directory = Process().currentDirectoryURL else { return nil }
        let url = directory.appendingPathComponent(argument)
        try? self.init(url: url)
    }
}

struct Tool: ParsableCommand {

    @Argument(help: "The file to open.")
    var input: Input

    func run() throws {
        let output = try calculatePositions(input: input)
        print(output)
    }
}

Tool.main()
