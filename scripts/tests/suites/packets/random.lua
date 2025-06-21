describe('/random C2S 0x0A2', function()
    it('emits a 0x009 response', function()
        local client, _ = xi.test.world:spawnPlayer()

        local packet = PacketBuilder:new(0x0A2)
        local expectedResponse = PacketBuilder:new(0x009)

        -- TODO: Improve expectPackets to match the message ID and the roll number
        client:expectPackets(function()
                client:sendPacket(packet.data)
            end,

            expectedResponse
        )
    end)
end)
