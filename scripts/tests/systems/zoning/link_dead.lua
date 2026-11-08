-----------------------------------
-- A zone change slower than the link-dead window doesn't flag the new char as disconnecting.
-----------------------------------
local zoning = require('scripts.tests.helpers.zoning')

describe('Link-dead while zoning', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player.network:drain()
        zoning.zoneOut(player, xi.zone.EAST_RONFAURE)
    end)

    it('is not flagged when the zone change took longer than 5 s', function()
        -- The old char's last packet was 10 s before the new char's C2S 0x00A
        player.network:isLinkDeadAfter(10)
        assert(player.network:login())
        assert(not player.network:isLinkDeadAfter(0), 'The char went link-dead as it zoned in')
    end)

    it('is still flagged when the client stops talking after zoning in', function()
        player.network:zoneIn()
        assert(player.network:isLinkDeadAfter(10))
    end)
end)
