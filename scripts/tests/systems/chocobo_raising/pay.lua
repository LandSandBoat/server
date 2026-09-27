-----------------------------------
-- A paid care plan pays out once, at the visit after the day it ran.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')
local helpers       = require('scripts.tests.systems.chocobo_raising.helpers')

local plans = xi.chocoboRaising.carePlans

describe('Chocobo raising care plan pay', function()
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

    it('pays Carrying Packages once, to an adolescent and to an adult', function()
        local goodDayPay = xi.chocoboRaising.carePlanData[plans.CARRYING_PACKAGES].pay[1]

        -- The lowest roll makes the plan a good day and starts no condition.
        stub('math.randomInt', helpers.lowestRoll)

        for _, stage in ipairs({ xi.chocoboRaising.stage.ADOLESCENT, xi.chocoboRaising.stage.ADULT_1 }) do
            player:deleteRaisedChocobo()

            local client = raisingClient.tradeEgg(player)
            raisingClient.setChocobo(player,
            {
                stage       = stage,
                locked_plan = plans.CARRYING_PACKAGES,
                care_plan   = bit.lshift(bit.lshift(1, 4) + plans.CARRYING_PACKAGES, 24) + 0x707070,
            })
            player:setGil(1000)

            xi.test.world:skipVanaDays(25)

            raisingClient.visit(client)
            player.assert:hasGil(1000 + goodDayPay)

            raisingClient.visit(client)
            player.assert:hasGil(1000 + goodDayPay)
        end
    end)
end)
