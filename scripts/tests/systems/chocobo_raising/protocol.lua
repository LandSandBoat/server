-----------------------------------
-- Raising replies checked param by param. A nil expectation skips a stale or unknown param.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

describe('Chocobo raising protocol', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:deleteRaisedChocobo()
    end)

    after_each(function()
        player:deleteRaisedChocobo()
    end)

    it('answers the first day like retail', function()
        local client = raisingClient.new(player)

        player:addItem(xi.item.CHOCOBO_EGG_FAINTLY_WARM)
        local trade = raisingClient.trade(client, { xi.item.CHOCOBO_EGG_FAINTLY_WARM })
        raisingClient.expectReply('826 start', trade.params, { nil, 0, 0, 0, 0, 0, 0, 1 })
        raisingClient.expectReply('F36 252', raisingClient.send(client, 252), { 0, 1, 0, 0, 0, 0, 0, 0 })
        raisingClient.finish(client, 252)

        -- Pins a good day so the roll does not depend on earlier tests.
        stub('math.randomInt', 1)
        xi.test.world:skipVanaDays(25)

        local start = raisingClient.talk(client)
        raisingClient.expectReply('F1 start', start.params, { 0, 1, nil, nil, nil, nil, nil, 1 })

        raisingClient.expectReply('F2 244', raisingClient.send(client, 244), { 0, 1, nil, nil, 1, 1, 0, 0 })
        raisingClient.expectReply('F3 208', raisingClient.send(client, 208), { 0xFFFFFFFF, 208 })
        raisingClient.expectReply('F4 248', raisingClient.send(client, 248), { 248, 1049601, 1, 65536, 1, 0, 0, 0 })
        raisingClient.expectReply('F5 246', raisingClient.send(client, 246), { 0, 256, nil, nil, 1 })
        raisingClient.expectReply('F6 214', raisingClient.send(client, 214), { 0, 0, 0, 0, 0, 0, 0, 0 })
        raisingClient.expectReply('F7 215', raisingClient.send(client, 215), { 1073741816, 0, 0, 0, 0, 0, 0, 0 })
        raisingClient.expectReply('F8 251', raisingClient.send(client, 251), { 251, 0, 460551, 65536, 0, 0, 0, 0 })
        raisingClient.expectReply('F9 248', raisingClient.send(client, 248), { 248, 1048578, 0, 0, 1, 0, 0, 0 })
        raisingClient.expectReply('F10 243', raisingClient.send(client, 243), { 2147483646, 98, 0, 0, 0, 0, 0, 0 })
        raisingClient.expectReply('F11 12530', raisingClient.send(client, 12530), { 304, 25186, 0, 0, 1 })
        raisingClient.finish(client, 0)
    end)

    it('has nothing to report twice in one day', function()
        stub('math.randomInt', 1)
        local client = raisingClient.tradeEgg(player)

        xi.test.world:skipVanaDays(25)
        raisingClient.visit(client)

        local start = raisingClient.talk(client)
        raisingClient.expectReply('F14 start', start.params, { 0, 0, nil, nil, nil, nil, nil, 1 })
        raisingClient.send(client, 244)
        raisingClient.expectReply('F14 208', raisingClient.send(client, 208), { 0, 0, 0, 0, 0, 0, 0, 0 })
        raisingClient.finish(client, 0)
    end)

    it('answers every option exactly once', function()
        stub('math.randomInt', 1)
        local client = raisingClient.tradeEgg(player)

        raisingClient.talk(client)

        -- 504 skip, a care plan write, a story key item, a walk encounter, every search distance
        for _, option in ipairs({ 504, 131326, 1119, 1241, 344, 600, 856 }) do
            raisingClient.send(client, option)
        end

        raisingClient.finish(client, 0)
    end)
end)
