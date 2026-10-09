-----------------------------------
-- Stable area NPCs checked against retail captures.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

describe('Stable area NPCs', function()
    it('has Palabelle turn away a player outside the CRA', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        local start  = raisingClient.talk(raisingClient.forNPC(player, 'Palabelle', 876))

        assert(start.eventId == 876 and start.params[2] == 1, 'Expected event 876 with param 2 of 1')
        player.events:finish()
    end)

    it('plays Gerahja\'s and Keturah\'s events in Bastok Mines', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.BASTOK_MINES })

        player.entities:gotoAndTrigger('Gerahja', { eventId = 544 })

        local start = raisingClient.talk(raisingClient.forNPC(player, 'Keturah', 546))
        assert(start.eventId == 546 and start.params[2] == 5, 'Expected event 546 with param 2 of 5')
        player.events:finish()
    end)

    it('faces Neigepance the captured way', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.BASTOK_MINES })

        assert(player.entities:get(17735733):getRotPos() == 100, 'Expected rotation 100')
    end)

    it('prices Ferdoulemiont\'s stock to fit the captured San d\'Oria prices', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        local prices = {}

        stub('xi.shop.nation', function(shopPlayer, stock)
            for _, entry in ipairs(stock) do
                prices[entry[1]] = entry[2]
            end
        end)

        player.entities:gotoAndTrigger('Ferdoulemiont')

        assert(prices[xi.item.BUNCH_OF_GYSAHL_GREENS] == 68, 'Expected Gysahl greens at 68')
        assert(prices[xi.item.SCROLL_OF_KNIGHTS_MINNE] == 18, 'Expected Knight\'s Minne at 18')
        assert(prices[xi.item.PET_FOOD_BETA_BISCUIT] == 90, 'Expected Beta biscuits at 90')
        assert(prices[xi.item.JUG_OF_CARROT_BROTH] == 60, 'Expected carrot broth at 60')
    end)
end)
