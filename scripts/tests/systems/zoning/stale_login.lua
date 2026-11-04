-----------------------------------
-- A plaintext C2S 0x00A can reach the server late, duplicated or out of order.
-- Taking one that is no longer current rewinds the sequence counters or skips S2C 0x00B, and
-- the client then drops everything the server sends.
-----------------------------------
local zoning = require('scripts.tests.helpers.zoning')

describe('Stale C2S 0x00A', function()
    ---@type CClientEntityPair
    local player

    -- Every datagram the client dropped as older than one it had seen, as a failure message
    local function staleDatagrams()
        local stale = {}
        for _, packet in ipairs(player.network:received()) do
            if
                not packet.accepted and
                packet.type == 0
            then
                table.insert(stale, string.format('datagram %u: %s', packet.datagram, packet.reason))
            end
        end

        return table.concat(stale, ', ')
    end

    -- True when the client accepted a packet of that type since the last clear
    local function gotPacket(packetType)
        for _, packet in ipairs(player.network:received()) do
            if
                packet.type == packetType and
                packet.accepted
            then
                return true
            end
        end

        return false
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player.network:drain()
        zoning.zoneOut(player, xi.zone.EAST_RONFAURE)
    end)

    it('is ignored when an older retry arrives after a newer one', function()
        -- Retry 1 reaches the server but its reply is lost, so the client sends retry 2
        assert(not player.network:login({ dropReply = true }))
        assert(player.network:login())

        player.network:clearReceived()
        player.network:sendStaleLogin(1)
        player.network:finishLoading()
        player.network:drain()

        assert(player.network:mode() == 'ingame')
        local stale = staleDatagrams()
        assert(stale == '', string.format('Client dropped %s', stale))
    end)

    it('leaves packets held for the load in place on a retry', function()
        -- The first reply's 0x00A is lost, so the client retries while a message waits for GAMEOK
        assert(not player.network:login({ ignoreLogin = true }))
        player:printToPlayer('Held for the load')
        assert(player.network:login())

        player.network:clearReceived()
        player.network:finishLoading()
        player.network:drain()
        assert(gotPacket(0x017), 'The held message was dropped')
    end)

    it('keeps the load deadline of the first try', function()
        -- A client stuck retrying C2S 0x00A can't hold off warps and jail past the deadline
        assert(not player.network:login({ ignoreLogin = true }))
        for _ = 1, 4 do
            xi.test.world:skipTime(10)
            assert(not player.network:login({ ignoreLogin = true }))
        end

        player:setPos(0, 0, 0, 0, xi.zone.WEST_RONFAURE)
        xi.test.world:tick()
        assert(not player:getZone(), 'Retries held the warp past the load deadline')
    end)

    it('keeps the load deadline when retries send seq 0', function()
        -- Seq 0 reads as no 0x00A taken yet, so it must not reopen the load window
        player.network:sendStaleLogin(0x8001)
        for _ = 1, 4 do
            xi.test.world:skipTime(10)
            player.network:sendStaleLogin(0)
            player.network:sendStaleLogin(0x8001)
        end

        player:setPos(0, 0, 0, 0, xi.zone.WEST_RONFAURE)
        xi.test.world:tick()
        assert(not player:getZone(), 'Seq 0 retries held the warp past the load deadline')
    end)

    it('ends the zone-in reply with S2C 0x00A once the load deadline has passed', function()
        -- With gear on, the zone-in reply has an equip list to send
        player.network:zoneIn()
        player:addItem(xi.item.BRONZE_SWORD)
        player:equipItem(xi.item.BRONZE_SWORD, nil, xi.slot.MAIN)
        player.network:drain()
        zoning.zoneOut(player, xi.zone.WEST_RONFAURE)

        assert(not player.network:login({ ignoreLogin = true }))
        for _ = 1, 4 do
            xi.test.world:skipTime(10)
            assert(not player.network:login({ ignoreLogin = true }))
        end

        player.network:clearReceived()
        assert(player.network:login())

        local loginDatagram = 0
        local lastType      = 0
        local received      = player.network:received()
        for _, packet in ipairs(received) do
            if packet.type == 0x00A then
                loginDatagram = packet.datagram
            end
        end

        for _, packet in ipairs(received) do
            if packet.datagram == loginDatagram then
                lastType = packet.type
            end
        end

        assert(lastType == 0x00A, string.format('S2C 0x00A was followed by 0x%03X', lastType))
    end)

    it('is ignored from the old address after a NAT rebind', function()
        -- Retry 1's reply is lost, then the client rebinds and retry 2 moves the session to the new port
        assert(not player.network:login({ dropReply = true }))
        player.network:rebind(23456)
        xi.test.world:skipTime(2)
        assert(player.network:login())

        -- Retry 1 arrives again from the old port, over a second after the move
        xi.test.world:skipTime(2)
        player.network:sendStaleLogin(1, 12345)

        -- The GAMEOK burst only reaches the client if the session stayed on the new port
        player.network:clearReceived()
        player.network:finishLoading()
        player.network:drain()
        assert(gotPacket(0x008), 'The client never got the zone-in burst')
    end)

    it('from another address can\'t lock the client out with a seq far ahead', function()
        -- A forged 0x00A with a high seq must not make the real client's retries look old
        assert(not player.network:login({ dropReply = true }))

        xi.test.world:skipTime(2)
        player.network:sendStaleLogin(0x7FFF, 34567)

        xi.test.world:skipTime(2)
        assert(player.network:login(), 'The real client retry was refused')

        player.network:clearReceived()
        player.network:finishLoading()
        player.network:drain()
        assert(gotPacket(0x008), 'The client never got the zone-in burst')
    end)

    it('is ignored while S2C 0x00B is still queued', function()
        player.network:zoneIn()
        xi.test.world:skipTime(3)

        -- The server queues 0x00B, then a delayed retry from this zone-in arrives
        player:setPos(0, 0, 0, 0, xi.zone.WEST_RONFAURE)
        xi.test.world:tick()
        assert(not player:getZone(), 'S2C 0x00B was not queued')
        player.network:sendStaleLogin(2)

        assert(zoning.awaitZoneOut(player) == 'login', 'Client never got S2C 0x00B')
        player.network:zoneIn()
        assert(player:getZoneID() == xi.zone.WEST_RONFAURE)
    end)
end)
