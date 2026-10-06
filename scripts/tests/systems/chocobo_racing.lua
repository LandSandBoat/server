-----------------------------------
-- Race offers and San d'Oria rentals.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

describe('Chocobo race offers', function()
    it('starts the offer with -1, which plays the delivery dialogue', function()
        local player = xi.test.world:spawnPlayer({ level = 20, zone = xi.zone.SOUTHERN_SAN_DORIA })
        local client = raisingClient.forNPC(player, 'Camereine', 599)

        player.packets:clear()
        xi.chocoboGame.startRaceEvent(player, xi.zone.SOUTH_GUSTABERG, 599)

        local start = assert(raisingClient.eventStart(client), 'Expected the race offer')
        assert(start.params[0] == 0xFFFFFFFF, string.format('Expected param 0 of -1, got %d', start.params[0]))
        player.events:finish()
    end)

    it('drops San d\'Oria riders at the captured West Ronfaure spot', function()
        local info = assert(xi.rentalChocobo.chocoboInfo[xi.zone.SOUTHERN_SAN_DORIA])
        local exit = assert(info.pos)
        assert(exit[1] == -134.940 and exit[2] == -62.500 and exit[3] == 270.874 and exit[4] == 95, 'Expected the captured exit')
        assert(exit[5] == xi.zone.WEST_RONFAURE, 'Expected West Ronfaure')
    end)
end)
