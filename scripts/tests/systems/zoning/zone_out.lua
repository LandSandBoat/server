-----------------------------------
-- What the old zone sends as the client leaves it.
-- Retail sends S2C 0x00B alone in its datagram, then nothing more but a resent 0x00B.
-- The client answers with C2S 0x00D once, under the old key, and moves on.
-----------------------------------
local zoning = require('scripts.tests.helpers.zoning')

describe('Zone-out', function()
    ---@type CClientEntityPair
    local player

    -- The types in each datagram that held S2C 0x00B, in order
    local function zoneOutDatagrams(client)
        local received  = client.network:received()
        local datagrams = {}

        for _, packet in ipairs(received) do
            if packet.type == 0x00B and packet.accepted then
                local types = {}
                for _, other in ipairs(received) do
                    if other.datagram == packet.datagram then
                        table.insert(types, string.format('%03X', other.type))
                    end
                end

                table.insert(datagrams, table.concat(types, ' '))
            end
        end

        return datagrams
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player.network:drain()
        player.network:clearReceived()
    end)

    it('sends S2C 0x00B alone in its datagram, as retail does', function()
        -- Packets queued in the tick the zone change goes out
        player:printToPlayer('Before the zone change')
        assert(zoning.zoneOut(player, xi.zone.EAST_RONFAURE) == 'login')

        local datagrams = zoneOutDatagrams(player)
        assert(#datagrams == 1, string.format('The client got %u S2C 0x00B', #datagrams))
        assert(datagrams[1] == '00B', string.format('The S2C 0x00B datagram was %s', datagrams[1]))
    end)

    it('sends the logout S2C 0x00B alone in its datagram', function()
        player:leaveGame()
        player:printToPlayer('Before the logout')
        assert(zoning.awaitZoneOut(player) == 'loggedout')

        local datagrams = zoneOutDatagrams(player)
        assert(#datagrams == 1, string.format('The client got %u S2C 0x00B', #datagrams))
        assert(datagrams[1] == '00B', string.format('The S2C 0x00B datagram was %s', datagrams[1]))
    end)

    it('sends nothing from the old zone after the client answers with C2S 0x00D', function()
        assert(zoning.zoneOut(player, xi.zone.EAST_RONFAURE) == 'login')

        -- A reply to the 0x00D would reach the client's new socket under the old key, and fail its MD5
        player.network:clearReceived()
        assert(player.network:login())

        for _, packet in ipairs(player.network:received()) do
            assert(packet.type ~= 0, string.format('Client dropped a datagram: %s', packet.reason))
        end
    end)

    it('resends a lost S2C 0x00B alone, under the old key', function()
        player:setPos(0, 0, 0, 0, xi.zone.EAST_RONFAURE)

        -- Every reply is lost until the server has sent 0x00B and let the char go
        for _ = 1, 10 do
            xi.test.world:tick()
            player.network:exchange({ dropReply = true })

            if player.network:hasSentZoneOut() then
                break
            end
        end

        assert(player.network:hasSentZoneOut(), 'S2C 0x00B never went out')
        assert(player.network:mode() == 'ingame')

        -- The client is still in game and sends under the old key, without 0x00D
        player.network:exchange()
        assert(player.network:mode() == 'login', string.format('Client is %s', player.network:mode()))

        local datagrams = zoneOutDatagrams(player)
        assert(#datagrams == 1, string.format('The client got %u S2C 0x00B', #datagrams))
        assert(datagrams[1] == '00B', string.format('The resent S2C 0x00B datagram was %s', datagrams[1]))

        player.network:zoneIn()
        assert(player:getZoneID() == xi.zone.EAST_RONFAURE)
    end)
end)
