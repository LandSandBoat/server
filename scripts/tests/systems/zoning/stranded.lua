-----------------------------------
-- A char whose saved zone no process hosts zones in at its home point.
-- Without it the char gets no S2C 0x00A and sits on "Downloading data" until the client gives up.
-----------------------------------
local zoning = require('scripts.tests.helpers.zoning')

describe('Stranded zone-in', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:setHomePoint()
        player.network:drain()
        zoning.zoneOut(player, xi.zone.EAST_RONFAURE)
    end)

    it('sends the char to its home point', function()
        -- Above any zone id the server knows
        player.network:setStoredZone(1000)

        player.network:zoneIn()
        assert(player.network:mode() == 'ingame', string.format('Client is %s', player.network:mode()))
        assert(player:getZoneID() == xi.zone.WEST_RONFAURE)
    end)
end)
