-----------------------------------
-- The stable's appearance reply (option 244) at each stage.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

local appearance = xi.chocoboRaising.appearance

describe('Chocobo raising appearance', function()
    ---@type CClientEntityPair
    local player
    ---@type RaisingClient
    local client

    local function lookAt(fields)
        raisingClient.setChocobo(player, fields)

        raisingClient.talk(client)
        local reply = raisingClient.send(client, 244)
        raisingClient.finish(client, 0)

        return reply
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:setGMLevel(0)
        player:deleteRaisedChocobo()

        client = raisingClient.tradeEgg(player)
    end)

    after_each(function()
        player:deleteRaisedChocobo()
    end)

    -- The client redraws the model from 244 after every report scene.
    it('shows the egg until the report has played its hatching scene', function()
        local location  = xi.chocoboRaising.raisingLocation[player:getZoneID()]
        local cutscenes = xi.chocoboRaising.cutscenes
        local drawn     = {}

        stub('math.randomInt', 1)

        xi.test.world:skipVanaDays(25 * (xi.chocoboRaising.daysToChick + 2))

        raisingClient.talk(client)
        local appearanceReply = raisingClient.send(client, 244)
        local statusReply     = raisingClient.send(client, 208)

        assert(appearanceReply[4] == xi.chocoboRaising.stage.EGG, string.format('Expected the egg in 244, got stage %d', appearanceReply[4]))
        assert(statusReply[4] == xi.chocoboRaising.stage.EGG, string.format('Expected the egg in 208, got stage %d', statusReply[4]))

        for _ = 1, 10 do
            local record = raisingClient.send(client, 248)
            for _ = 1, record[2] do
                local cutscene = raisingClient.send(client, 246)[1] - location * 256
                table.insert(drawn, { cutscene = cutscene, stage = raisingClient.send(client, 244)[4] })
            end

            if bit.band(record[1], 0x80000000) == 0 then
                break
            end
        end

        raisingClient.finish(client, 0)

        local hatched = false
        for _, entry in ipairs(drawn) do
            hatched = hatched or entry.cutscene == cutscenes.EGG_HATCHING

            local expected = hatched and xi.chocoboRaising.stage.CHICK or xi.chocoboRaising.stage.EGG
            assert(entry.stage == expected, string.format('After scene %d expected stage %d, got %d', entry.cutscene, expected, entry.stage))
        end

        assert(hatched, 'Expected the hatching scene')

        raisingClient.talk(client)
        local afterReport = raisingClient.send(client, 244)
        raisingClient.finish(client, 0)

        assert(afterReport[4] == xi.chocoboRaising.stage.CHICK, string.format('Expected the chick once reported, got stage %d', afterReport[4]))
    end)

    it('shows the colour, and the adult features each in its own param', function()
        local stage = xi.chocoboRaising.stage
        local color = xi.chocoboRaising.color

        -- { fields set, expected 244 reply }
        local looks =
        {
            {
                { stage = stage.EGG },
                { 0, 1, 0, 0, stage.EGG, 1, 0, 0 },
            },
            {
                { stage = stage.ADOLESCENT, color = color.RED, appearance = appearance.LARGE_TALONS },
                { color.RED, 0, 0, 0, stage.ADOLESCENT, 1, 0, 0 },
            },
            {
                { stage = stage.ADULT_1, color = color.YELLOW, appearance = appearance.LARGE_TALONS },
                { 0, 0, 1, 0, stage.ADULT_1, 1, 0, 0 },
            },
            {
                { stage = stage.ADULT_2, color = color.YELLOW, appearance = appearance.LARGE_BEAK + appearance.FULL_TAIL },
                { 0, 1, 0, 1, stage.ADULT_2, 1, 0, 0 },
            },
        }

        for _, look in ipairs(looks) do
            raisingClient.expectReply(string.format('244 at stage %d', look[1].stage), lookAt(look[1]), look[2])
        end
    end)
end)
