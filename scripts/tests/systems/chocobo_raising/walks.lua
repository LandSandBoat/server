-----------------------------------
-- Walks, meeting other chocobos, competing and stories.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')
local helpers       = require('scripts.tests.systems.chocobo_raising.helpers')

local walks     = xi.chocoboRaising.walks
local trainer   = xi.chocoboRaising.walkTrainer
local cutscenes = xi.chocoboRaising.cutscenes
local ability   = xi.chocoboRaising.ability
local effect    = xi.chocoboRaising.effect

local scriptedRolls = helpers.scriptedRolls
local lowestRoll    = helpers.lowestRoll
local highestRoll   = helpers.highestRoll
local hasEffect     = helpers.hasEffect

local sandoria = 1
local bastok   = 2
local windurst = 3

local shortWalk   = cutscenes.GO_ON_A_WALK_SHORT
local regularWalk = cutscenes.GO_ON_A_WALK_REGULAR
local longWalk    = cutscenes.GO_ON_A_WALK_LONG

-- A care action option carries its cutscene in the second byte.
local shortWalkOption   = 242 + shortWalk * 256
local regularWalkOption = 242 + regularWalk * 256
local watchOverOption   = 242 + cutscenes.HAPPY_TO_SEE_YOU * 256
local storyMenuOption   = 242 + cutscenes.INTERESTED_IN_YOUR_STORY * 256

-- The impatient story is the fourth in the story menu.
local tellImpatientStory = 50 + 4 * 256

local function newState()
    return
    {
        stage         = xi.chocoboRaising.stage.ADOLESCENT,
        held_item     = 0,
        walk_progress = 0,
        strength      = 0,
        endurance     = 0,
        discernment   = 0,
        receptivity   = 0,
        affection     = 128,
        energy        = 50,
        ability1      = 0,
        ability2      = 0,
    }
end

-- The stubbed math.randomInt answers with this. The lowest roll meets someone on every walk after the rivals.
local currentRolls = lowestRoll

describe('Chocobo raising walks', function()
    describe('rules', function()
        before_each(function()
            currentRolls = lowestRoll
            stub('math.randomInt', function(low, high)
                return currentRolls(low, high)
            end)
        end)

        it('meets the right trainers at each stable on each walk', function()
            local meetings =
            {
                { sandoria, shortWalk,   { trainer.HANTILEON } },
                { sandoria, regularWalk, { trainer.ZOPAGO, trainer.RIVALS } },
                { sandoria, longWalk,    { trainer.PULONONO, trainer.BRUTUS } },
                { bastok,   shortWalk,   { trainer.ZOPAGO } },
                { bastok,   regularWalk, { trainer.HANTILEON, trainer.RIVALS } },
                { bastok,   longWalk,    { trainer.PULONONO, trainer.BRUTUS } },
                { windurst, shortWalk,   { trainer.PULONONO } },
                { windurst, regularWalk, { trainer.HANTILEON, trainer.RIVALS } },
                { windurst, longWalk,    { trainer.ZOPAGO, trainer.BRUTUS } },
            }

            for _, case in ipairs(meetings) do
                local candidates = walks.candidates(case[1], case[2], false)
                assert(#candidates == #case[3], string.format('Stable %d walk %d: expected %d trainers, got %d', case[1], case[2], #case[3], #candidates))

                for index, expected in ipairs(case[3]) do
                    -- Rivals met, so any trainer may appear.
                    local state         = newState()
                    state.walk_progress = bit.lshift(1, (trainer.RIVALS - 1) * 2)

                    currentRolls = scriptedRolls({ 1, index })

                    local result = walks.walk(state, case[2], { location = case[1], walkZone = 0 })
                    assert(result.trainer == expected, string.format('Stable %d walk %d: expected trainer %d, got %d', case[1], case[2], expected, result.trainer))
                end
            end
        end)

        it('meets the rivals on the first regular walk and unlocks competing', function()
            local state = newState()
            assert(not walks.canCompete(state), 'Expected competing locked before the rivals')

            currentRolls = highestRoll

            local result = walks.walk(state, regularWalk, { location = sandoria, walkZone = 0 })
            assert(result.trainer == trainer.RIVALS and result.meeting == 0, 'Expected the rivals, first meeting')
            assert(walks.canCompete(state), 'Expected competing unlocked')
        end)

        it('teaches the trainer\'s story on the third meeting and the happy story on the third win', function()
            local state = newState()
            local ctx   = { location = sandoria, walkZone = 0 }

            for meeting = 0, 3 do
                local result, effects = walks.walk(state, shortWalk, ctx)
                local taught          = hasEffect(effects, effect.ADD_KEY_ITEM, xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO)

                assert(result.meeting == math.min(meeting, 3), string.format('Expected meeting count %d', meeting))
                assert(taught == (meeting == 2), string.format('Story on meeting %d: %s', meeting, tostring(taught)))
            end

            local competitor = newState()
            local results    = {}
            local happy      = false

            -- Losses do not count toward the third win.
            for _, roll in ipairs({ 1, 1, 2, 1, 1 }) do
                currentRolls = scriptedRolls({ roll })

                local result, effects = walks.compete(competitor)
                table.insert(results, result)
                happy = happy or hasEffect(effects, effect.ADD_KEY_ITEM, xi.keyItem.STORY_OF_A_HAPPY_CHOCOBO)
            end

            assert(results[1] == 0 and results[2] == 0 and results[3] == 2, 'Expected win, win, loss')
            assert(results[4] == 3, 'Expected the third win to be result 3')
            assert(results[5] == 0, 'Expected later wins to be plain wins')
            assert(happy, 'Expected the happy story')
        end)

        it('finds an item only when the chocobo holds none, and nothing on a high roll', function()
            local state    = newState()
            local walkZone = xi.chocoboRaising.shortWalkLocation[sandoria]

            local itemRoll = walks.eventChance[shortWalk][1] + 1
            currentRolls   = scriptedRolls({ itemRoll, 1 })

            local result = walks.walk(state, shortWalk, { location = sandoria, walkZone = walkZone })
            assert(result.event == 7 and result.trainer == 0, 'Expected an item and no meeting')
            assert(state.held_item == xi.chocoboRaising.walkItems[walkZone][1], 'Expected the zone\'s first item held')

            currentRolls = scriptedRolls({ itemRoll, 1 })

            result = walks.walk(state, shortWalk, { location = sandoria, walkZone = walkZone })
            assert(result.event == 0, 'Expected no second item while one is held')

            currentRolls = highestRoll

            result = walks.walk(newState(), shortWalk, { location = sandoria, walkZone = 0 })
            assert(result.event == 0 and result.trainer == 0, 'Expected nothing on a high roll')
        end)

        it('learns abilities from stories with enough discernment, else is inspired or only interested', function()
            local state       = newState()
            state.discernment = 200

            local result, effects = walks.tellStory(state, 4)
            assert(result == 1 and state.ability1 == ability.GALLOP, 'Expected Gallop from the impatient story')
            assert(hasEffect(effects, effect.DEL_KEY_ITEM, xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO), 'Expected the story used up')
            assert(state.energy == 60, string.format('Expected the lowest restore of 10 energy, got %d', state.energy))

            walks.tellStory(state, 8)
            assert(state.ability2 == ability.AUTO_REGEN, 'Expected Auto-Regen from the happy story')

            local endurance = state.endurance
            result = walks.tellStory(state, 5)
            assert(result == 2, 'Expected inspiration with both slots full')
            assert(state.endurance > endurance, 'Expected the inspired endurance rise')

            local failed       = newState()
            failed.discernment = 200

            currentRolls = scriptedRolls({ walks.learnChance + 1 })

            local failedResult, failedEffects = walks.tellStory(failed, 4)
            assert(failedResult == 0 and #failedEffects == 0, 'Expected interest only, and the story kept')
            assert(failed.ability1 == 0 and failed.energy == 50, 'Expected no ability and no energy restored')

            currentRolls = lowestRoll

            local known       = newState()
            known.discernment = 200
            known.ability1    = ability.GALLOP

            assert(walks.tellStory(known, 4) == 2 and known.strength > 0, 'Expected inspiration and a strength rise for a known ability')

            local average       = newState()
            average.discernment = 100

            local boreResult, boreEffects = walks.tellStory(average, 7)
            assert(boreResult == 0 and #boreEffects == 0, 'Expected Bore to need Impressive discernment')
            assert(walks.tellStory(average, 4) == 1, 'Expected Gallop to need less')
        end)

        it('names friend chocobos by the character\'s chocobo number', function()
            assert(walks.friendName(trainer.HANTILEON, 1) == 'Air', 'Expected Air first')
            assert(walks.friendName(trainer.HANTILEON, 3) == 'Sea', 'Expected Sea third')
            assert(walks.friendName(trainer.HANTILEON, 6) == 'Air', 'Expected the names to repeat from the sixth')
            assert(walks.friendName(trainer.RIVALS, 1) == 'Best', 'Expected the rival Best first')
        end)
    end)

    describe('at the trainer', function()
        ---@type CClientEntityPair
        local player
        local client

        -- A chick on day 4 in clear weather.
        before_each(function()
            xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
            xi.test.world:setSeed(1)
            player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
            player:deleteRaisedChocobo()

            client = raisingClient.tradeEgg(player)

            xi.test.world:skipVanaDays(4 * 25)
            raisingClient.visit(client)

            stub('xi.chocoboRaising.getWeatherInZone', xi.weather.SUNSHINE)
        end)

        after_each(function()
            player:deleteRaisedChocobo()
        end)

        local function careAction(option)
            raisingClient.talk(client)
            raisingClient.send(client, 244)

            return raisingClient.send(client, option)
        end

        -- A short walk in sunshine that finds nothing.
        it('answers a short walk like retail', function()
            local solvedChick  = walks.lostChick(0)
            solvedChick.solved = true

            player:setCharVar(walks.lostChickVar, walks.packLostChick(solvedChick))
            raisingClient.setChocobo(player, { energy = 94 })
            stub('math.randomInt', highestRoll)

            local reply = careAction(shortWalkOption)
            raisingClient.finish(client, 0)

            assert(reply[0] == 298 and reply[1] == 18014, string.format('Expected [298, 18014], got [%d, %d]', reply[0], reply[1]))
            assert(reply[2] == 0 and reply[4] == xi.chocoboRaising.stage.CHICK and reply[7] == xi.weather.SUNSHINE, 'Expected nothing found, chick, sunshine')
        end)

        it('refuses a walk when the chocobo is too tired, and saves a walk before the event ends', function()
            raisingClient.setChocobo(player, { energy = 29 })

            local refused = careAction(shortWalkOption)
            raisingClient.finish(client, 0)

            assert(refused[1] == 0x8000002A, string.format('Expected the failure flag, got 0x%X', refused[1]))
            assert(player:getChocoboRaisingInfo().energy == 29, 'Expected the energy kept')

            raisingClient.setChocobo(player, { energy = 100 })
            stub('math.randomInt', highestRoll)

            careAction(shortWalkOption)
            local energy = player:getChocoboRaisingInfo().energy
            raisingClient.finish(client, 0)

            assert(energy < 100, string.format('Expected the energy spent before the finish, got %d', energy))
        end)

        -- Captured: option 95 | 1 << 8 after the third meeting, answered with "Obtained key item".
        it('meets Hantileon\'s chocobo and announces his story on the third walk', function()
            stub('math.randomInt', lowestRoll)

            local obtained = zones[xi.zone.SOUTHERN_SAN_DORIA].text.KEYITEM_OBTAINED
            local said     = false

            for meeting = 0, 2 do
                raisingClient.setChocobo(player, { energy = 100 })

                local reply = careAction(shortWalkOption)
                assert(reply[5] == trainer.HANTILEON and reply[6] == meeting, string.format('Expected Hantileon, meeting %d', meeting))

                raisingClient.send(client, 473)
                assert(raisingClient.strings(client)[1] == 'Air', 'Expected the friend chocobo Air in the name packet')

                if player:hasKeyItem(xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO) then
                    raisingClient.send(client, 95 + bit.lshift(1, 8))

                    for _, packet in ipairs(player.packets:getIncoming()) do
                        if
                            packet.type == 0x02A and
                            bit.band(packet.data[0x1A] + packet.data[0x1B] * 256, 0x7FFF) == obtained
                        then
                            said = true
                        end
                    end
                end

                raisingClient.finish(client, 0)
            end

            player.assert:hasKI(xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO)
            assert(said, 'Expected the key item message')
        end)

        it('holds a found item until Watch over, through a full inventory', function()
            local rolls = { 30, 1 }
            stub('math.randomInt', function(low, high)
                return table.remove(rolls, 1) or low
            end)

            local walk = careAction(shortWalkOption)
            raisingClient.finish(client, 0)
            assert(walk[2] == 7, 'Expected the item found')

            local itemId = player:getChocoboRaisingInfo().held_item
            player:changeContainerSize(xi.inventoryLocation.INVENTORY, -player:getFreeSlotsCount())

            local fullWatch = careAction(watchOverOption)
            raisingClient.finish(client, 0)

            assert(fullWatch[2] == 2 and fullWatch[3] == itemId, 'Expected the full inventory reply')
            assert(player:getChocoboRaisingInfo().held_item == itemId, 'Expected the chocobo to keep the item')
            player.assert.no:hasItem(itemId)

            player:changeContainerSize(xi.inventoryLocation.INVENTORY, 1)
            raisingClient.setChocobo(player, { energy = 100 })

            local watch = careAction(watchOverOption)
            raisingClient.finish(client, 0)

            assert(watch[0] == 304 and watch[2] == 1 and watch[3] == itemId, 'Expected the item handed over')
            assert(player:getChocoboRaisingInfo().held_item == 0, 'Expected the item no longer held')
            player.assert:hasItem(itemId)
        end)

        it('unlocks competing after the first regular walk', function()
            raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.ADOLESCENT, energy = 100 })

            assert(careAction(243)[0] == 0x7FFFFFC8, 'Expected compete hidden')
            raisingClient.finish(client, 0)

            local walk = careAction(regularWalkOption)
            raisingClient.finish(client, 0)
            assert(walk[5] == trainer.RIVALS, 'Expected the rivals')

            assert(careAction(243)[0] == 0x7FFFFFC0, 'Expected compete shown')
            raisingClient.finish(client, 0)
        end)

        it('keeps the impatient story when the chocobo does not learn, and learns Gallop when it does', function()
            raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.ADOLESCENT, energy = 100, discernment = 100 })
            player:addKeyItem(xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO)

            local rolls = highestRoll
            stub('math.randomInt', function(low, high)
                return rolls(low, high)
            end)

            careAction(storyMenuOption)
            local interested = raisingClient.send(client, tellImpatientStory)
            raisingClient.finish(client, 0)

            assert(interested[0] == 0, string.format('Expected interest only, got %d', interested[0]))
            assert(player:getChocoboRaisingInfo().ability1 == 0, 'Expected no ability stored')
            player.assert:hasKI(xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO)

            raisingClient.setChocobo(player, { energy = 100 })
            rolls = lowestRoll

            local menu = careAction(storyMenuOption)
            assert(bit.band(menu[2], 2) == 0, 'Expected the impatient story offered')

            local learned = raisingClient.send(client, tellImpatientStory)
            raisingClient.finish(client, 0)

            assert(learned[0] == 1, 'Expected the chocobo to learn')
            assert(player:getChocoboRaisingInfo().ability1 == ability.GALLOP, 'Expected Gallop stored')
            player.assert.no:hasKI(xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO)
        end)
    end)
end)
