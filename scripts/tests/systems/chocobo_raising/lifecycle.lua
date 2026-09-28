-----------------------------------
-- Chocobo raising through Hantileon, one Earth day per raising day.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

local cutscenes = xi.chocoboRaising.cutscenes
local kerchief  = xi.chocoboRaising.handkerchief

describe('Chocobo raising lifecycle', function()
    ---@type CClientEntityPair
    local player

    -- One raising day is one Earth day; 25 Vana'diel days pass in it. The lowest roll starts no condition.
    before_each(function()
        xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:deleteRaisedChocobo()

        stub('math.randomInt', 1)
    end)

    after_each(function()
        player:deleteRaisedChocobo()
    end)

    it('raises a chocobo from egg to retirement with daily visits', function()
        local client = raisingClient.tradeEgg(player)
        local color  = player:getChocoboRaisingInfo().color

        for day = 1, 129 do
            xi.test.world:skipVanaDays(25)

            local visit = raisingClient.visit(client)
            assert(#visit.records == 1, string.format('Day %d: expected one report record, got %d', day, #visit.records))
            assert(visit.records[1].startDay == day and visit.records[1].endDay == day, string.format('Day %d: report covered %d-%d', day, visit.records[1].startDay, visit.records[1].endDay))

            if day == 7 then
                assert(raisingClient.heard(visit, cutscenes.CRYING_AT_NIGHT), 'Expected crying at night on day 7')
                player.assert:hasKI(xi.keyItem.WHITE_HANDKERCHIEF)
            end

            -- The hand-in needs a zone after the visit that reports day 8.
            if day == 8 then
                assert(not visit.preMenuCutscene, 'Expected no hand-in in the visit that reports day 8')
                player.assert:hasKI(xi.keyItem.WHITE_HANDKERCHIEF)
                raisingClient.gotoZone(player, xi.zone.NORTHERN_SAN_DORIA)
                raisingClient.gotoZone(player, xi.zone.SOUTHERN_SAN_DORIA)
            end

            if day == 9 then
                assert(visit.preMenuCutscene == cutscenes.THAT_SHOULD_BE_ENOUGH, 'Expected the hand-in on day 9')
                player.assert.no:hasKI(xi.keyItem.WHITE_HANDKERCHIEF)
            end

            if day == 10 then
                assert(raisingClient.heard(visit, cutscenes.WHITE_HANDKERCHIEF_END), 'Expected the cured scene on day 10')
                assert(xi.chocoboRaising.handkerchiefState(player) == kerchief.DONE, 'Expected the handkerchief done')
                assert(player:getCharVar(xi.chocoboRaising.handkerchiefVar) == 0, 'Expected the handkerchief var cleared')
            end

            if day == 15 then
                assert(not raisingClient.heard(visit, cutscenes.HAVENT_SEEN_YOU), 'Expected no cancel after a hand-in')
            end

            if day == 29 then
                assert(raisingClient.heard(visit, cutscenes.ADOLESCENT_TO_ADULT_1), 'Expected adulthood on day 29')
            end

            if day == 64 then
                assert(player:getChocoboRaisingInfo().first_name ~= 'Chocobo', 'Expected the trainer to name the chocobo on day 64')
            end

            if day == 129 then
                assert(visit.retired and raisingClient.heard(visit, cutscenes.ADULT_3_TO_ADULT_4), 'Expected retirement on day 129')
            end
        end

        assert(not player:getChocoboRaisingInfo(), 'Expected the chocobo to leave the stable')
        player.assert:hasItem(xi.item.VCS_REGISTRATION_CARD)
        player.assert:hasItem(xi.chocoboRaising.plaques[color])
    end)

    it('takes the handkerchief back on day 15 when the player stays away', function()
        local client = raisingClient.tradeEgg(player)

        xi.test.world:skipVanaDays(25)
        raisingClient.visit(client)

        for _ = 2, 21 do
            xi.test.world:skipVanaDays(25)
        end

        local visit = raisingClient.visit(client)
        assert(raisingClient.heard(visit, cutscenes.CRYING_AT_NIGHT), 'Expected crying at night in the catch-up report')
        assert(raisingClient.heard(visit, cutscenes.HAVENT_SEEN_YOU), 'Expected the cancel scene in the catch-up report')
        assert(raisingClient.heard(visit, cutscenes.CHICK_TO_ADOLESCENT), 'Expected adolescence in the catch-up report')
        player.assert.no:hasKI(xi.keyItem.WHITE_HANDKERCHIEF)
        assert(xi.chocoboRaising.handkerchiefState(player) == kerchief.CANCELLED, 'Expected the handkerchief cancelled')
    end)

    it('applies missed days even when the player skips the report', function()
        local client = raisingClient.tradeEgg(player)

        for _ = 1, 20 do
            xi.test.world:skipVanaDays(25)
        end

        raisingClient.talk(client)
        raisingClient.send(client, 244)
        raisingClient.send(client, 208)
        client.player.events:update(nil, 504)
        raisingClient.finish(client, 0)

        local info = player:getChocoboRaisingInfo()
        assert(info.stage == xi.chocoboRaising.stage.ADOLESCENT, string.format('Expected adolescence by day 20, got stage %d', info.stage))
        assert(info.last_update_age == 21, string.format('Expected days 1-20 applied, got next day %d', info.last_update_age))
    end)

    it('counts each egg handed in', function()
        local raised = player:getChocoboUserData().chocobosRaised

        raisingClient.tradeEgg(player)
        assert(player:getChocoboUserData().chocobosRaised == raised + 1, 'Expected the first egg counted')

        player:deleteRaisedChocobo()
        raisingClient.tradeEgg(player)
        assert(player:getChocoboUserData().chocobosRaised == raised + 2, 'Expected the second egg counted')
    end)
end)
