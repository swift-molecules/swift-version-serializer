import Byte
import Byte_Standard_Library_Integration
import Serializer
import Testing
import Version
import Version_Serializer

@Suite struct `Version Serializer Tests` {
    @Test
    func `Semantic serializer emits canonical bytes`() {
        let version = Version.Semantic(
            major: 1,
            minor: 2,
            patch: 3,
            preReleaseIdentifiers: [.alphanumeric("rc"), .numeric(1)],
            buildMetadataIdentifiers: ["build", "42"]
        )
        var bytes: [Byte] = []
        Version.Semantic.Serializer().serialize(version, into: &bytes)
        #expect(Swift.String(decoding: bytes, as: Swift.UTF8.self) == "1.2.3-rc.1+build.42")
    }

    @Test
    func `Tools serializer preserves omitted patch`() {
        let version = Version.Tools(major: 6, minor: 4)
        var bytes: [Byte] = []
        Version.Tools.Serializer().serialize(version, into: &bytes)
        #expect(Swift.String(decoding: bytes, as: Swift.UTF8.self) == "6.4")
    }
}
