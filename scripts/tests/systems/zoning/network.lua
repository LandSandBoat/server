-----------------------------------
-- Zoning over real datagrams.
-- The test client applies the retail client's receive rules (PS2 decomp), so a
-- reply it drops here is one a real client would drop.
-----------------------------------
local zoning = require('scripts.tests.helpers.zoning')

describe('Zoning over the network', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player.network:drain()
    end)

    it('moves the client to the next zone', function()
        assert(zoning.zoneOut(player, xi.zone.EAST_RONFAURE) == 'login')

        player.network:zoneIn()
        assert(player.network:mode() == 'ingame', string.format('Client is %s: %s', player.network:mode(), player.network:hangReason()))
        assert(player:getZoneID() == xi.zone.EAST_RONFAURE)
    end)

    it('gets S2C 0x00A after its first reply is lost', function()
        -- The client resends C2S 0x00A until a reply with S2C 0x00A arrives
        zoning.zoneOut(player, xi.zone.EAST_RONFAURE)

        assert(not player.network:login({ dropReply = true }))
        assert(player.network:login())

        player.network:finishLoading()
        assert(player.network:mode() == 'ingame')
    end)

    it('gets S2C 0x00A after a reply without one', function()
        zoning.zoneOut(player, xi.zone.EAST_RONFAURE)

        -- The client has now seen a server seq, so the next reply must carry a newer one
        assert(not player.network:login({ ignoreLogin = true }))
        assert(player.network:login())

        player.network:finishLoading()
        assert(player.network:mode() == 'ingame')
    end)
end)
