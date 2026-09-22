import NIOCore
import Testing
@testable import NIOQUIC

@available(anyAppleOS 26, *)
extension HeaderIDTests {
    @Test("SNQ-1: short header undersized DCID causes crash on 0.2.2")
    func snq1ShortHeaderTooSmallForDCID() throws {
        let connectionID = QUICConnectionID(
            bytes: [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0],
            length: 16
        )
        let packet = Array(QUICPackets.shortHeader(destinationID: connectionID).prefix(4))
        let buffer = ByteBuffer(bytes: packet)
        let header = try buffer.getQUICPacketHeader(destinationIDLength: 16)
        #expect(header == nil)
    }
}
