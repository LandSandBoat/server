-----------------------------------
-- Feeding a chick at Hantileon.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

local feed = 241

describe('Chocobo raising feeding', function()
    ---@type CClientEntityPair
    local player
    local client

    -- A chick the day after it hatched, starving after the rollover. The lowest roll starts no condition.
    before_each(function()
        xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:deleteRaisedChocobo()

        stub('math.randomInt', 1)
        client = raisingClient.tradeEgg(player)

        xi.test.world:skipVanaDays(5 * 25)
        raisingClient.visit(client)

        -- The captured feeds were on a starving chick.
        raisingClient.setChocobo(player, { hunger = 0 })
    end)

    after_each(function()
        player:deleteRaisedChocobo()
    end)

    local function feedItems(items)
        local start = raisingClient.trade(client, items)
        local reply = raisingClient.send(client, feed)
        raisingClient.finish(client, 0)

        return start, reply
    end

    it('eats up to four items, cures first, and leaves what is not food', function()
        local starving = player:getChocoboRaisingInfo()

        player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)

        local start, reply = feedItems({ xi.item.BUNCH_OF_GYSAHL_GREENS })
        raisingClient.expectReply('one bunch start', start.params, { xi.item.BUNCH_OF_GYSAHL_GREENS, nil, nil, nil, nil, nil, nil, 1 })
        raisingClient.expectReply('one bunch 241', reply, { xi.item.BUNCH_OF_GYSAHL_GREENS, xi.chocoboRaising.glow.RED, 0, 0, 1, 3 })

        -- Eight bunches: four eaten and the overfeeding flagged.
        player:setChocoboRaisingInfo(starving)
        player:addItem({ id = xi.item.BUNCH_OF_GYSAHL_GREENS, quantity = 8 })

        start, reply = feedItems({ { itemId = xi.item.BUNCH_OF_GYSAHL_GREENS, quantity = 8 } })
        raisingClient.expectReply('eight bunches start', start.params, { 10, nil, nil, nil, nil, nil, nil, 4 })
        raisingClient.expectReply('eight bunches 241', reply, { 10, xi.item.BUNCH_OF_GYSAHL_GREENS, 0xFFFFFFFF, 0, 1, 7 })

        local remaining = player:findItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
        assert(remaining and remaining:getQuantity() == 4, 'Expected four greens left')
        player:delItem(xi.item.BUNCH_OF_GYSAHL_GREENS, 4)

        player:setChocoboRaisingInfo(starving)
        player:addItem({ id = xi.item.BUNCH_OF_GYSAHL_GREENS, quantity = 2 })
        player:addItem(xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS)

        _, reply = feedItems({ { itemId = xi.item.BUNCH_OF_GYSAHL_GREENS, quantity = 2 }, xi.item.CLUMP_OF_TOKOPEKKO_WILDGRASS })
        raisingClient.expectReply('cure first 241', reply, { 10, xi.chocoboRaising.glow.RED, 0, 1, 1, 7 })

        player:setChocoboRaisingInfo(starving)
        player:addItem({ id = xi.item.BUNCH_OF_GYSAHL_GREENS, quantity = 2 })
        player:addItem(xi.item.LITTLE_WORM)

        start, reply = feedItems({ { itemId = xi.item.BUNCH_OF_GYSAHL_GREENS, quantity = 2 }, xi.item.LITTLE_WORM })
        raisingClient.expectReply('not food start', start.params, { 10, nil, nil, nil, nil, nil, nil, 2 })
        raisingClient.expectReply('not food 241', reply, { 10, xi.chocoboRaising.glow.RED, 0, 0, 1, 6 })
        player.assert:hasItem(xi.item.LITTLE_WORM)
    end)

    it('refills energy with a Chocolixir', function()
        raisingClient.setChocobo(player, { energy = 10 })

        player:addItem(xi.item.CHOCOLIXIR)
        feedItems({ xi.item.CHOCOLIXIR })

        assert(player:getChocoboRaisingInfo().energy == 100, 'Expected full energy')
    end)

    it('heals an injury at the next rollover', function()
        raisingClient.setChocobo(player, { conditions = bit.lshift(1, xi.chocoboRaising.conditions.INJURED) })
        player:addItem(xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS)
        feedItems({ xi.item.CLUMP_OF_GAUSEBIT_WILDGRASS })

        raisingClient.talk(client)
        raisingClient.send(client, 244)
        assert(raisingClient.send(client, 251)[4] == 0x8001, 'Expected the injury with a cure waiting')
        raisingClient.finish(client, 0)

        xi.test.world:skipVanaDays(25)
        local visit = raisingClient.visit(client)
        assert(raisingClient.heard(visit, xi.chocoboRaising.cutscenes.INJURY_HAS_HEALED), 'Expected the healed scene')
        assert(player:getChocoboRaisingInfo().conditions == 0, 'Expected the injury gone')
    end)

    it('wakes a sleeping chocobo with a Chocotonic', function()
        raisingClient.setChocobo(player, { conditions = bit.lshift(1, xi.chocoboRaising.conditions.SLEEPING) })
        player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
        player:addItem(xi.item.CHOCOTONIC)

        player.actions:tradeNpc('Hantileon', { xi.item.BUNCH_OF_GYSAHL_GREENS })
        player.events:expectNotInEvent()
        player.assert:hasItem(xi.item.BUNCH_OF_GYSAHL_GREENS)

        feedItems({ xi.item.CHOCOTONIC })

        player.assert.no:hasItem(xi.item.CHOCOTONIC)
        local conditions = player:getChocoboRaisingInfo().conditions
        assert(bit.band(conditions, bit.lshift(1, xi.chocoboRaising.conditions.SLEEPING)) == 0, 'Expected the chocobo awake')
    end)

    it('eats a Chocotonic alone', function()
        player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
        player:addItem(xi.item.CHOCOTONIC)

        local start = feedItems({ xi.item.BUNCH_OF_GYSAHL_GREENS, xi.item.CHOCOTONIC })
        raisingClient.expectReply('start', start.params, { xi.item.CHOCOTONIC, nil, nil, nil, nil, nil, nil, 1 })

        player.assert.no:hasItem(xi.item.CHOCOTONIC)
        player.assert:hasItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
    end)

    it('sends food for a chocobo raised elsewhere to its own stable', function()
        raisingClient.gotoZone(player, xi.zone.BASTOK_MINES)

        player:addItem(xi.item.BUNCH_OF_GYSAHL_GREENS)

        local zopago = raisingClient.new(player)
        local start  = raisingClient.trade(zopago, { xi.item.BUNCH_OF_GYSAHL_GREENS })
        assert(start.eventId == 508, string.format('Expected the reminder event 508, got %d', start.eventId))
        raisingClient.expectReply('start', start.params, { 1, 1, 1, 1 })
        raisingClient.finish(zopago, 0)

        player.assert:hasItem(xi.item.BUNCH_OF_GYSAHL_GREENS)
    end)
end)
