-----------------------------------
-- C2S 0x00C GAMEOK tells the server the client has loaded the zone.
-- Before it, a retail client drops most packets and still acks them, and S2C 0x00B leaves it
-- stuck on "Downloading data" for good.
-----------------------------------
local zoning = require('scripts.tests.helpers.zoning')

describe('GAMEOK', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player.network:drain()
        zoning.zoneOut(player, xi.zone.EAST_RONFAURE)
    end)

    it('holds a warp requested during the load until the client sends it', function()
        assert(player.network:login())

        player:setPos(0, 0, 0, 0, xi.zone.WEST_RONFAURE)
        xi.test.world:tick()
        assert(player:getZoneID() == xi.zone.EAST_RONFAURE, 'The char left the zone before the client loaded it')

        player.network:finishLoading()
        assert(not player.network:isHung(), player.network:hangReason())
        assert(player.network:mode() == 'ingame')

        assert(zoning.awaitZoneOut(player) == 'login')
        player.network:zoneIn()
        assert(player:getZoneID() == xi.zone.WEST_RONFAURE)
    end)

    it('opens the gate on a GAMEOK the handler refuses', function()
        assert(player.network:login())
        player.network:finishLoading({ refuseGameOk = true })

        assert(zoning.zoneOut(player, xi.zone.WEST_RONFAURE) == 'login', 'The warp never went out')
    end)

    it('stops waiting for GAMEOK after the load deadline', function()
        assert(player.network:login())

        player:setPos(0, 0, 0, 0, xi.zone.WEST_RONFAURE)
        xi.test.world:tick()

        -- Still loading, so the warp waits
        xi.test.world:skipTime(20)
        player.network:exchange()
        assert(player.network:mode() == 'loading')

        -- A client this slow is not loading, and the warp goes out
        xi.test.world:skipTime(15)
        player.network:exchange()
        assert(player.network:isHung(), string.format('Client is %s', player.network:mode()))
    end)
end)
