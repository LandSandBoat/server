-----------------------------------
-- Options the menus hide must change nothing.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')
local helpers       = require('scripts.tests.systems.chocobo_raising.helpers')

local cutscenes = xi.chocoboRaising.cutscenes

local retireOption = 90208
local giveUpOption = 240

local function careAction(cutscene)
    return 242 + cutscene * 256
end

local function carePlan(slot, days, planType)
    return 254 + bit.lshift(slot + bit.lshift(days, 8) + bit.lshift(planType, 11), 8)
end

describe('Chocobo raising guards', function()
    ---@type CClientEntityPair
    local player
    ---@type RaisingClient
    local client

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

    it('refuses the debug time skip, retiring and hidden care actions for an egg', function()
        local info = player:getChocoboRaisingInfo()

        raisingClient.talk(client)
        raisingClient.assertZeros(raisingClient.send(client, 226 + 200 * 256), 'Time skip')
        raisingClient.assertZeros(raisingClient.send(client, retireOption), 'Retire')
        raisingClient.assertZeros(raisingClient.send(client, careAction(cutscenes.GO_ON_A_WALK_LONG)), 'Long walk')
        raisingClient.assertZeros(raisingClient.send(client, careAction(cutscenes.COMPETE_WITH_OTHERS)), 'Compete')
        raisingClient.finish(client, 0)

        local after = player:getChocoboRaisingInfo()
        assert(after, 'Expected the chocobo to stay')
        assert(after.created == info.created, 'Expected no time skip')
        assert(after.energy == info.energy, 'Expected no energy spent')
        player.assert.no:hasItem(xi.item.VCS_REGISTRATION_CARD)
    end)

    it('refuses to register before the whistle quest is done, or a chick', function()
        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.ADULT_1 })
        player:setGil(1000)

        raisingClient.talk(client)
        raisingClient.assertZeros(raisingClient.send(client, 223), 'Register before the quest')
        raisingClient.finish(client, 0)

        player.assert:hasGil(1000)
        assert(not player:getFieldChocobo(), 'Expected no registration before the quest')

        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.CHICK })
        xi.chocoboRaising.setWhistleProgress(player, xi.chocoboRaising.whistleProg.DONE)

        raisingClient.talk(client)
        local menu = raisingClient.send(client, 215)
        assert(bit.band(menu[0], bit.lshift(1, 5)) ~= 0, 'Expected registration hidden for a chick')
        raisingClient.assertZeros(raisingClient.send(client, 223), 'Register a chick')
        raisingClient.finish(client, 0)

        player.assert:hasGil(1000)
        assert(not player:getFieldChocobo(), 'Expected no registration of a chick')
    end)

    it('refuses to let the player give up an adult, and cancels a handkerchief that is out on a give-up', function()
        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.ADULT_1, first_name = 'Test', last_name = 'Bird' })

        raisingClient.talk(client)
        raisingClient.assertZeros(raisingClient.send(client, giveUpOption), 'Give up an adult')
        raisingClient.finish(client, 0)

        assert(player:getChocoboRaisingInfo(), 'Expected the adult to stay')

        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.EGG, first_name = 'Chocobo', last_name = 'Chocobo' })
        player:addKeyItem(xi.keyItem.WHITE_HANDKERCHIEF)
        xi.chocoboRaising.setHandkerchiefState(player, xi.chocoboRaising.handkerchief.GIVEN)

        raisingClient.talk(client)
        raisingClient.send(client, giveUpOption)
        raisingClient.finish(client, 0)

        assert(not player:getChocoboRaisingInfo(), 'Expected the chocobo gone')
        player.assert.no:hasKI(xi.keyItem.WHITE_HANDKERCHIEF)
        assert(xi.chocoboRaising.handkerchiefState(player) == xi.chocoboRaising.handkerchief.CANCELLED, 'Expected a missed chance')
    end)

    it('refuses a whistle search without a search walk', function()
        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.ADULT_1 })

        for _, prog in ipairs({ xi.chocoboRaising.whistleProg.SEARCH, xi.chocoboRaising.whistleProg.DONE }) do
            xi.chocoboRaising.setWhistleProgress(player, prog)

            raisingClient.talk(client)
            for distance = 1, 3 do
                raisingClient.assertZeros(raisingClient.send(client, 88 + distance * 256))
            end

            raisingClient.finish(client, 0)

            assert(xi.chocoboRaising.whistleProgress(player) == prog, 'Expected the quest unchanged')
            player.assert.no:hasKI(xi.keyItem.HANDKERCHIEF)
            player.assert.no:hasKI(xi.keyItem.DIRTY_HANDKERCHIEF)
        end
    end)

    it('takes a tenth off the energy of a care action with Green Racing Silks', function()
        stub('xi.chocoboRaising.getWeatherInZone', xi.weather.SUNSHINE)
        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.ADOLESCENT, energy = 100 })
        player:addItem(xi.item.GREEN_RACING_SILKS)
        player:equipItem(xi.item.GREEN_RACING_SILKS, nil, xi.slot.BODY)

        raisingClient.talk(client)
        raisingClient.send(client, careAction(cutscenes.INTERESTED_IN_YOUR_STORY))
        raisingClient.finish(client, 0)

        -- A tenth off a story's 11 energy rounds up to 10.
        local energy = player:getChocoboRaisingInfo().energy
        assert(energy == 90, string.format('Expected a 10 energy story, got %d energy', energy))
    end)

    it('allows one story only after a paid telling, and only one the player holds', function()
        local tellImpatientStory = 50 + 4 * 256

        stub('math.randomInt', 1)
        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.ADOLESCENT, energy = 100, discernment = 50 })

        raisingClient.talk(client)
        raisingClient.assertZeros(raisingClient.send(client, tellImpatientStory))

        raisingClient.send(client, careAction(cutscenes.INTERESTED_IN_YOUR_STORY))
        raisingClient.assertZeros(raisingClient.send(client, tellImpatientStory))
        raisingClient.finish(client, 0)

        assert(player:getChocoboRaisingInfo().discernment == 50, 'Expected no story without the key item')

        player:addKeyItem(xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO)
        raisingClient.talk(client)
        raisingClient.send(client, careAction(cutscenes.INTERESTED_IN_YOUR_STORY))
        raisingClient.send(client, tellImpatientStory)
        raisingClient.assertZeros(raisingClient.send(client, tellImpatientStory))
        raisingClient.finish(client, 0)

        assert(player:getChocoboRaisingInfo().discernment == 51, 'Expected one story told')
    end)

    it('refuses care plans the menu does not offer', function()
        local before = player:getChocoboRaisingInfo().care_plan

        raisingClient.talk(client)
        raisingClient.send(client, carePlan(0, 7, xi.chocoboRaising.carePlans.DELIVERING_MESSAGES))
        raisingClient.send(client, carePlan(4, 7, xi.chocoboRaising.carePlans.BASIC_CARE))
        raisingClient.send(client, carePlan(0, 0, xi.chocoboRaising.carePlans.BASIC_CARE))
        raisingClient.send(client, carePlan(0, 7, 16))
        raisingClient.finish(client, 0)

        assert(player:getChocoboRaisingInfo().care_plan == before, 'Expected the schedule unchanged')

        raisingClient.talk(client)
        raisingClient.send(client, carePlan(0, 3, xi.chocoboRaising.carePlans.BASIC_CARE))
        raisingClient.finish(client, 0)

        local expected = bit.bor(bit.band(before, 0x00FFFFFF), 0x30000000)
        local actual   = player:getChocoboRaisingInfo().care_plan
        assert(actual == expected, string.format('Expected the Basic Care plan in slot 1, got 0x%08X', actual))
    end)

    it('offers only Watch over and Scold to a sleeping chocobo, and hides care and retiring once it ran away', function()
        local cond = xi.chocoboRaising.conditions

        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.CHICK, energy = 100, conditions = bit.lshift(1, cond.SLEEPING) })

        raisingClient.talk(client)
        local careMenu = raisingClient.send(client, 243)
        assert(careMenu[0] == 0x7FFFFFFA, string.format('Expected the care menu 0x7FFFFFFA, got 0x%08X', careMenu[0]))
        raisingClient.assertZeros(raisingClient.send(client, careAction(cutscenes.GO_ON_A_WALK_SHORT)))
        raisingClient.finish(client, 0)

        assert(player:getChocoboRaisingInfo().energy == 100, 'Expected no energy spent while asleep')

        raisingClient.talk(client)
        local scold = raisingClient.send(client, careAction(cutscenes.HANGS_HEAD_IN_SHAME))
        assert(scold[2] == 1, string.format('Expected p2 1 for a woken chocobo, got %d', scold[2]))
        assert(raisingClient.send(client, 46)[0] == 0, 'Expected no mood left')
        assert(raisingClient.send(client, 243)[0] == 0x7FFFFFEA, 'Expected the chick care menu back')
        raisingClient.finish(client, 0)

        assert(not xi.chocoboRaising.getCondition(player:getChocoboRaisingInfo(), cond.SLEEPING), 'Expected the chocobo awake')

        raisingClient.talk(client)
        assert(raisingClient.send(client, careAction(cutscenes.HANGS_HEAD_IN_SHAME))[2] == 0, 'Expected p2 0 for an awake chocobo')
        raisingClient.finish(client, 0)

        raisingClient.setChocobo(player,
        {
            stage      = xi.chocoboRaising.stage.ADULT_3,
            first_name = 'Test',
            last_name  = 'Bird',
            energy     = 100,
            conditions = bit.lshift(1, cond.RUN_AWAY),
        })
        xi.chocoboRaising.setWhistleProgress(player, xi.chocoboRaising.whistleProg.DONE)
        player:addItem(xi.item.CHOCOBO_WHISTLE)

        raisingClient.talk(client)
        local menu = raisingClient.send(client, 215)
        assert(menu[0] == 0x7FFFFFCA, string.format('Expected the main menu 0x7FFFFFCA, got 0x%08X', menu[0]))
        assert(raisingClient.send(client, 243)[0] == 0x7FFFFFFF, 'Expected no care action offered')
        raisingClient.assertZeros(raisingClient.send(client, careAction(cutscenes.HAPPY_TO_SEE_YOU)))
        raisingClient.assertZeros(raisingClient.send(client, retireOption))
        raisingClient.finish(client, 0)

        assert(player:getChocoboRaisingInfo(), 'Expected the chocobo to stay')
        assert(player:getChocoboRaisingInfo().energy == 100, 'Expected no energy spent while away')
    end)

    it('saves a compete before it gives the happy story', function()
        local rivals = xi.chocoboRaising.walkTrainer.RIVALS
        local saved

        raisingClient.setChocobo(player,
        {
            stage         = xi.chocoboRaising.stage.ADOLESCENT,
            energy        = 100,
            walk_progress = bit.lshift(1, (rivals - 1) * 2) + bit.lshift(2, 12),
        })

        stub('math.randomInt', helpers.lowestRoll)

        stub('xi.chocoboRaising.applyEffects', function(target, effects)
            if #effects > 0 then
                saved = xi.chocoboRaising.walks.wins(player:getChocoboRaisingInfo())
            end
        end)

        raisingClient.talk(client)
        local reply = raisingClient.send(client, careAction(cutscenes.COMPETE_WITH_OTHERS))
        raisingClient.finish(client, 0)

        assert(reply[2] == 3, string.format('Expected the third win, got %d', reply[2]))
        assert(saved == 3, string.format('Expected the win saved before the story, got %s', tostring(saved)))
    end)

    it('feeds nothing when the trade cannot be taken', function()
        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.CHICK, hunger = 0 })

        raisingClient.talk(client)
        xi.chocoboRaising.chocoState[player:getID()].foodGiven = { xi.item.BUNCH_OF_GYSAHL_GREENS }
        raisingClient.assertZeros(raisingClient.send(client, 241))
        raisingClient.finish(client, 0)

        assert(player:getChocoboRaisingInfo().hunger == 0, 'Expected nothing eaten')
    end)

    it('keeps no chocobo when the egg cannot be taken', function()
        player:deleteRaisedChocobo()
        xi.chocoboRaising.chocoState[player:getID()] = nil

        local count     = player:getChocoboUserData().chocobosRaised
        local tradeCSID = xi.chocoboRaising.csidTable[player:getZoneID()][3]
        xi.chocoboRaising.onEventFinishVCSTrainer(player, tradeCSID, 252, nil)

        assert(not player:getChocoboRaisingInfo(), 'Expected no chocobo without the egg')
        assert(player:getChocoboUserData().chocobosRaised == count, 'Expected the chocobo count unchanged')
    end)

    it('gives no recharged whistle when the trade cannot be taken', function()
        local whistle = xi.chocoboRaising.whistle
        player:setGil(1000)
        player:setLocalVar('[ChocoboRaising]WhistlePrice', 400)

        whistle.onEventFinish(player, whistle.events[player:getZoneID()].whistle, whistle.option.PAY_RECHARGE)

        player.assert:hasGil(1000)
        player.assert.no:hasItem(xi.item.CHOCOBO_WHISTLE)
    end)

    it('saves the held item as given before the event ends', function()
        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.CHICK, energy = 100, held_item = xi.item.CHUNK_OF_ADAMAN_ORE })

        raisingClient.talk(client)
        raisingClient.send(client, careAction(cutscenes.HAPPY_TO_SEE_YOU))

        assert(player:getChocoboRaisingInfo().held_item == 0, 'Expected the item saved as given')
        player.assert:hasItem(xi.item.CHUNK_OF_ADAMAN_ORE)
        raisingClient.finish(client, 0)
    end)

    it('issues no chococard for a chick', function()
        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.CHICK, first_name = 'Test', last_name = 'Bird' })
        player:setGil(1000)

        raisingClient.talk(client)
        raisingClient.finish(client, xi.chocoboRaising.documentChococard)

        player.assert:hasGil(1000)
        player.assert.no:hasItem(xi.item.CHOCOCARD_M)
        player.assert.no:hasItem(xi.item.CHOCOCARD_F)
    end)

    it('names only an unnamed chick', function()
        local jet = 42
        local sky = 53

        local nameOption = 255 + bit.lshift(jet + bit.lshift(sky, 10), 8)

        local function assertName(first, last)
            local info = player:getChocoboRaisingInfo()
            assert(info.first_name == first and info.last_name == last, string.format('Expected %s %s, got %s %s', first, last, info.first_name, info.last_name))
        end

        assert(xi.chocoboNames[jet] == 'Jet' and xi.chocoboNames[sky] == 'Sky', 'Expected the name offsets unchanged')

        raisingClient.talk(client)
        raisingClient.assertZeros(raisingClient.send(client, nameOption), 'Name an egg')
        raisingClient.finish(client, 0)

        assertName('Chocobo', 'Chocobo')

        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.CHICK })

        raisingClient.talk(client)
        raisingClient.send(client, nameOption)
        raisingClient.finish(client, 0)

        assertName('Jet', 'Sky')

        raisingClient.setChocobo(player, { first_name = 'Test', last_name = 'Bird' })

        raisingClient.talk(client)
        raisingClient.assertZeros(raisingClient.send(client, nameOption), 'Rename a named chick')
        raisingClient.finish(client, 0)

        assertName('Test', 'Bird')
    end)
end)

describe('Chocobo raising guards outside the trainer', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.UPPER_JEUNO })
    end)

    it('rides a chocobo registered before riding times for 30 minutes, and clamps registered values', function()
        -- A plain yellow chocobo stores 0, the same as no chocobo, so this one has a trait.
        player:registerChocobo({ color = xi.chocoboRaising.color.YELLOW, largeBeak = true, speed = 0, minutes = 0 })

        assert(assert(xi.chocoboRaising.whistle.ride(player)).seconds == 1800, 'Expected the 30 minute fallback')

        ---@type table
        local outOfRange = { color = 9, speed = 200, minutes = 99 }
        player:registerChocobo(outOfRange)

        local chocobo = assert(player:getFieldChocobo())
        assert(chocobo.color == xi.chocoboRaising.color.GREEN and chocobo.speed == 127 and chocobo.minutes == 63, 'Expected clamped fields')
    end)

    -- A poor day halves a loss toward zero: three points of discernment lost become one.
    it('halves a loss on a poor day without deepening it', function()
        local state =
        {
            strength    = 50,
            endurance   = 50,
            discernment = 50,
            receptivity = 50,
            affection   = 128,
            energy      = 100,
        }

        stub('math.randomInt', helpers.highestRoll)

        xi.chocoboRaising.runCarePlan(state, xi.chocoboRaising.carePlans.TAKING_A_WALK, 30)

        assert(state.discernment == 49, string.format('Expected 49, got %d', state.discernment))
    end)
end)
