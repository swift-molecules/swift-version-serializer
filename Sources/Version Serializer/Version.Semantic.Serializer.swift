public import Byte
public import Serializer
public import Version

extension Version.Semantic {
    public struct Serializer<Buffer: Swift.RangeReplaceableCollection>: Swift.Sendable
    where Buffer: Swift.Sendable, Buffer.Element == Byte {
        @inlinable
        public init() {}
    }
}

extension Version.Semantic.Serializer: Serializer.`Protocol` {
    public typealias Output = Version.Semantic
    public typealias Failure = Swift.Never

    public func serialize(_ output: Output, into buffer: inout Buffer) {
        buffer.append(contentsOf: output.description.utf8.lazy.map(Byte.init))
    }
}
