local packetReader = require('scripts.tests.helpers.packet_reader')
local cloisterID   = zones[xi.zone.CLOISTER_OF_FLAMES]
local qufimID      = zones[xi.zone.QUFIM_ISLAND]

-- The flow spacing reads GetSystemTime, which follows the Vana'diel clock.
local function advance(seconds)
    local minutes = VanadielHour() * 60 + VanadielMinute() + math.ceil(seconds / 2.4)
    xi.test.world:setVanaTime(math.floor(minutes / 60) % 24, minutes % 60)
    xi.test.world:skipTime(seconds)
end

describe('ASA M4 - Sugar-Coated Directive', function()
    ---@type CClientEntityPair
    local player

    local counterseals =
    {
        xi.keyItem.AMBER_COUNTERSEAL,
        xi.keyItem.AZURE_COUNTERSEAL,
        xi.keyItem.CERULEAN_COUNTERSEAL,
        xi.keyItem.EMERALD_COUNTERSEAL,
        xi.keyItem.SCARLET_COUNTERSEAL,
        xi.keyItem.VIOLET_COUNTERSEAL,
    }

    before_each(function()
        player = xi.test.world:spawnPlayer({ job = xi.job.WAR, level = 99 })
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_DIRECTIVE)
        player:addKeyItem(xi.keyItem.DOMINAS_SCARLET_SEAL)
    end)

    describe('at the Cloister of Flames', function()
        before_each(function()
            player:gotoZone(xi.zone.CLOISTER_OF_FLAMES)
        end)

        it('refuses the seal once per visit before opening the fight', function()
            player.entities:gotoAndTrigger('FP_Entrance', { eventId = 3 })
            player.assert:hasKI(xi.keyItem.DOMINAS_SCARLET_SEAL)

            player.bcnm:enter('FP_Entrance', xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_FLAMES)
            player.assert:hasKI(xi.keyItem.DOMINAS_SCARLET_SEAL)
        end)

        it('refuses the seal again after zoning', function()
            player.entities:gotoAndTrigger('FP_Entrance', { eventId = 3 })
            player:gotoZone(xi.zone.CLOISTER_OF_FLAMES)

            player.entities:gotoAndTrigger('FP_Entrance', { eventId = 3 })
            assert(not player:getBattlefield(), 'Expected the stymied message again after zoning')
        end)

        it('ignores a player without the seal', function()
            player:delKeyItem(xi.keyItem.DOMINAS_SCARLET_SEAL)

            player.entities:gotoAndTrigger('FP_Entrance')
            player.events:expectNotInEvent()
        end)

        it('swaps the seal for the counterseal after the win, even after zoning', function()
            player.entities:gotoAndTrigger('FP_Entrance', { eventId = 3 })
            player.bcnm:enter('FP_Entrance', xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_FLAMES)

            -- The avatar stays unkillable until its fifth astral flow has gone out.
            local ifrit = player.entities:get(cloisterID.mob.IFRIT_PRIME_ASA + player:getBattlefield():getArea() - 1)
            ifrit:updateEnmity(player)
            ifrit:setLocalVar('astralflows', 6)
            ifrit:setHP(1)
            xi.test.world:tick()
            assert(not ifrit:getUnkillable(), 'Expected the avatar to be killable after the fifth flow')

            player.bcnm:killMobs()
            xi.test.world:skipTime(2)
            player.bcnm:expectWin()

            player:gotoZone(xi.zone.CLOISTER_OF_FLAMES)
            player.entities:gotoAndTrigger('FP_Entrance', { eventId = 2 })
            player.assert.no:hasKI(xi.keyItem.DOMINAS_SCARLET_SEAL)
            player.assert:hasKI(xi.keyItem.SCARLET_COUNTERSEAL)
        end)

        it('flows at each threshold, eight seconds apart, before it can die', function()
            player:addMod(xi.mod.DMG, -10000)
            player.entities:gotoAndTrigger('FP_Entrance', { eventId = 3 })
            player.bcnm:enter('FP_Entrance', xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_FLAMES)

            local ifrit  = player.entities:get(player:getBattlefield():getMobs(true, true)[1]:getID())
            local damage = ifrit:getMod(xi.mod.DMG)
            ifrit:updateEnmity(player)

            local thresholds = { 80, 60, 40, 20, 1 }
            local lastFlowAt = 0
            for flow, threshold in ipairs(thresholds) do
                ifrit:setHP(math.max(1, math.floor(ifrit:getMaxHP() * threshold / 100)))

                local waited = 0
                while ifrit:getLocalVar('astralflows') == flow and waited < 20 do
                    advance(1)
                    waited = waited + 1
                end

                assert(ifrit:getLocalVar('astralflows') == flow + 1, string.format('Expected astral flow %d at %d%%', flow, threshold))
                assert(flow == 1 or GetSystemTime() - lastFlowAt >= 8, string.format('Expected astral flow %d eight seconds after the last', flow))
                lastFlowAt = GetSystemTime()

                if threshold == 1 then
                    ifrit.assert:hasModifier(xi.mod.DMG, damage - 7000)
                end

                assert(ifrit:getUnkillable(), string.format('Expected the avatar to be unkillable after flow %d', flow))
            end

            local waited = 0
            while ifrit:getUnkillable() and waited < 20 do
                advance(1)
                waited = waited + 1
            end

            assert(not ifrit:getUnkillable(), 'Expected the avatar to be killable once the fifth flow is done')
            ifrit.assert:hasModifier(xi.mod.DMG, damage)

            player.bcnm:killMobs()
            xi.test.world:skipTime(2)
            player.bcnm:expectWin()
        end)
    end)

    it('swaps each seal for its counterseal in all six cloisters', function()
        local cloisters =
        {
            {
                zone        = xi.zone.CLOISTER_OF_FLAMES,
                entrance    = 'FP_Entrance',
                battlefield = xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_FLAMES,
                seal        = xi.keyItem.DOMINAS_SCARLET_SEAL,
                counterseal = xi.keyItem.SCARLET_COUNTERSEAL,
            },
            {
                zone        = xi.zone.CLOISTER_OF_FROST,
                entrance    = 'IP_Entrance',
                battlefield = xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_FROST,
                seal        = xi.keyItem.DOMINAS_AZURE_SEAL,
                counterseal = xi.keyItem.AZURE_COUNTERSEAL,
            },
            {
                zone        = xi.zone.CLOISTER_OF_GALES,
                entrance    = 'WP_Entrance',
                battlefield = xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_GALES,
                seal        = xi.keyItem.DOMINAS_EMERALD_SEAL,
                counterseal = xi.keyItem.EMERALD_COUNTERSEAL,
            },
            {
                zone        = xi.zone.CLOISTER_OF_STORMS,
                entrance    = 'LP_Entrance',
                battlefield = xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_STORMS,
                seal        = xi.keyItem.DOMINAS_VIOLET_SEAL,
                counterseal = xi.keyItem.VIOLET_COUNTERSEAL,
            },
            {
                zone        = xi.zone.CLOISTER_OF_TIDES,
                entrance    = 'WP_Entrance',
                battlefield = xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_TIDES,
                seal        = xi.keyItem.DOMINAS_CERULEAN_SEAL,
                counterseal = xi.keyItem.CERULEAN_COUNTERSEAL,
            },
            {
                zone        = xi.zone.CLOISTER_OF_TREMORS,
                entrance    = 'EP_Entrance',
                battlefield = xi.battlefield.id.SUGAR_COATED_DIRECTIVE_CLOISTER_OF_TREMORS,
                seal        = xi.keyItem.DOMINAS_AMBER_SEAL,
                counterseal = xi.keyItem.AMBER_COUNTERSEAL,
            },
        }

        for _, cloister in ipairs(cloisters) do
            player:addKeyItem(cloister.seal)
            player:gotoZone(cloister.zone)

            player.entities:gotoAndTrigger(cloister.entrance, { eventId = 3 })
            player.bcnm:enter(cloister.entrance, cloister.battlefield)

            -- Skips the run to the fifth flow, so the next tick makes the avatar killable.
            local avatar = player:getBattlefield():getMobs(true, true)[1]
            avatar:updateEnmity(player)
            avatar:setLocalVar('astralflows', 6)
            avatar:setHP(1)
            xi.test.world:tick()

            player.bcnm:killMobs()
            xi.test.world:skipTime(2)
            player.bcnm:expectWin()

            player:gotoZone(cloister.zone)
            player.entities:gotoAndTrigger(cloister.entrance, { eventId = 2 })
            player.assert.no:hasKI(cloister.seal)
            player.assert:hasKI(cloister.counterseal)
        end
    end)

    describe('at the Trodden Snow', function()
        before_each(function()
            player:gotoZone(xi.zone.QUFIM_ISLAND)
        end)

        it('waits for three counterseals', function()
            player:addKeyItem(xi.keyItem.SCARLET_COUNTERSEAL)
            player:addKeyItem(xi.keyItem.AZURE_COUNTERSEAL)

            player.packets:clear()
            player.entities:gotoAndTrigger('Trodden_Snow')
            player.events:expectNotInEvent()
            assert(packetReader.saidMessage(player, qufimID.text.ASA_SNOW), 'Expected the writing in the snow')
            player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.SUGAR_COATED_DIRECTIVE)
        end)

        it('pays 3000 gil for three counterseals and takes every seal', function()
            for i = 1, 3 do
                player:addKeyItem(counterseals[i])
            end

            local gil = player:getGil()
            player.entities:gotoAndTrigger('Trodden_Snow', { eventId = 45 })

            player.assert:hasGil(gil + 3000)
            player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_I)
            player.assert.no:hasKI(xi.keyItem.DOMINAS_SCARLET_SEAL)
            for i = 1, 3 do
                player.assert.no:hasKI(counterseals[i])
            end
        end)

        it('pays 50000 gil for all six counterseals', function()
            for _, counterseal in ipairs(counterseals) do
                player:addKeyItem(counterseal)
            end

            local gil = player:getGil()
            player.entities:gotoAndTrigger('Trodden_Snow', { eventId = 45 })

            player.assert:hasGil(gil + 50000)
            player.assert:hasMission(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_I)
        end)

        it('shows nothing once the mission is done', function()
            player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_I)

            player.packets:clear()
            player.entities:gotoAndTrigger('Trodden_Snow')
            player.events:expectNotInEvent()
            assert(packetReader.saidMessage(player, qufimID.text.NOTHING_OUT_OF_ORDINARY), 'Expected nothing out of the ordinary')
        end)
    end)
end)
