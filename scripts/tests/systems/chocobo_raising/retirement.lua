-----------------------------------
-- Retirement rewards, including those held for a full inventory.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

local retireOption = 90208

local walks = xi.chocoboRaising.walks

local function solvedLostChick()
    local chick  = walks.lostChick(0)
    chick.solved = true

    local value = walks.packLostChick(chick)
    assert(value ~= 0, 'Expected a solved chick to be stored')

    return value
end

describe('Chocobo raising retirement', function()
    ---@type CClientEntityPair
    local player
    ---@type RaisingClient
    local client

    local function retireAdult()
        raisingClient.talk(client)
        raisingClient.send(client, retireOption)
        raisingClient.finish(client, 0)
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:setGMLevel(0)
        player:deleteRaisedChocobo()
        player:setCharVar(xi.chocoboRaising.retirement.heldItemsVar, 0)

        client = raisingClient.tradeEgg(player)

        raisingClient.setChocobo(player,
        {
            first_name = 'Test',
            last_name  = 'Bird',
            stage      = xi.chocoboRaising.stage.ADULT_1,
            color      = xi.chocoboRaising.color.BLUE,
        })
    end)

    after_each(function()
        player:deleteRaisedChocobo()
        player:setCharVar(xi.chocoboRaising.retirement.heldItemsVar, 0)
    end)

    it('gives the card and plaque, and clears the stories, a solved lost chick and a returned handkerchief', function()
        player:addKeyItem(xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO)
        player:addKeyItem(xi.keyItem.STORY_OF_A_HAPPY_CHOCOBO)
        player:setCharVar(walks.lostChickVar, solvedLostChick())
        xi.chocoboRaising.setHandkerchiefState(player, xi.chocoboRaising.handkerchief.RETURNED)

        retireAdult()

        player.assert:hasItem(xi.item.VCS_REGISTRATION_CARD)
        player.assert:hasItem(xi.chocoboRaising.plaques[xi.chocoboRaising.color.BLUE])
        assert(not player:getChocoboRaisingInfo(), 'Expected the chocobo gone')
        player.assert.no:hasKI(xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO)
        player.assert.no:hasKI(xi.keyItem.STORY_OF_A_HAPPY_CHOCOBO)
        assert(player:getCharVar(walks.lostChickVar) == 0, 'Expected the lost chick reset')
        assert(xi.chocoboRaising.handkerchiefState(player) == xi.chocoboRaising.handkerchief.DONE, 'Expected the handkerchief done')
    end)

    it('keeps a lost chick result for the trainer\'s closing scene', function()
        local chick    = walks.lostChick(0)
        chick.owner    = 3
        chick.clues    = 2
        chick.location = 1
        chick.result   = walks.lostChickResult.RETURNED
        chick.solved   = true

        -- A pending result makes the trainer play its report instead of the menu.
        player:setCharVar(walks.lostChickVar, walks.packLostChick(chick))
        xi.chocoboRaising.retirement.retire(player, player:getChocoboRaisingInfo(), true)

        local after = walks.lostChick(player:getCharVar(walks.lostChickVar))
        assert(after.result == walks.lostChickResult.RETURNED, 'Expected the result kept')
        assert(after.owner == 0 and after.clues == 0 and after.location == 0 and not after.solved, 'Expected the rest of the lost chick reset')
    end)

    it('does not hold the rewards again when retiring twice', function()
        raisingClient.leaveFreeSlots(player, 1)
        retireAdult()
        assert(player:getCharVar(xi.chocoboRaising.retirement.heldItemsVar) == xi.chocoboRaising.retirement.heldItem.PLAQUE, 'Expected only the plaque held')

        raisingClient.leaveFreeSlots(player, 0)
        xi.chocoboRaising.retirement.retire(player, player:getChocoboRaisingInfo(), true)

        local held = player:getCharVar(xi.chocoboRaising.retirement.heldItemsVar)
        assert(held == xi.chocoboRaising.retirement.heldItem.PLAQUE, string.format('Expected only the plaque still held, got %d', held))
    end)

    it('holds what does not fit and hands it over on later visits', function()
        raisingClient.leaveFreeSlots(player, 1)
        retireAdult()

        player.assert:hasItem(xi.item.VCS_REGISTRATION_CARD)
        player.assert.no:hasItem(xi.chocoboRaising.plaques[xi.chocoboRaising.color.BLUE])
        assert(player:getChocoboRaisingInfo(), 'Expected the chocobo kept until the plaque is given')

        local start = raisingClient.talk(client)
        assert(start.eventId == xi.chocoboRaising.retirement.events[xi.zone.SOUTHERN_SAN_DORIA], 'Expected the hand-over event')
        assert(start.params[0] == xi.chocoboRaising.stage.ADULT_4, 'Expected the retired stage')
        raisingClient.finish(client, 0)

        player.assert.no:hasItem(xi.chocoboRaising.plaques[xi.chocoboRaising.color.BLUE])
        assert(xi.chocoboRaising.retirement.hasHeldItems(player), 'Expected the plaque still held')

        raisingClient.leaveFreeSlots(player, 1)
        raisingClient.talk(client)
        raisingClient.finish(client, 0)

        player.assert:hasItem(xi.chocoboRaising.plaques[xi.chocoboRaising.color.BLUE])
        assert(not player:getChocoboRaisingInfo(), 'Expected the chocobo gone')
        assert(not xi.chocoboRaising.retirement.hasHeldItems(player), 'Expected nothing held')
    end)

    it('holds both with a full inventory and refuses a new egg meanwhile', function()
        raisingClient.leaveFreeSlots(player, 0)
        retireAdult()

        player.assert.no:hasItem(xi.item.VCS_REGISTRATION_CARD)
        player.assert.no:hasItem(xi.chocoboRaising.plaques[xi.chocoboRaising.color.BLUE])
        assert(xi.chocoboRaising.retirement.hasHeldItems(player), 'Expected both held')

        raisingClient.leaveFreeSlots(player, 2)
        player:addItem(xi.item.CHOCOBO_EGG_FAINTLY_WARM)
        local start = raisingClient.trade(client, { xi.item.CHOCOBO_EGG_FAINTLY_WARM })
        assert(start.eventId == xi.chocoboRaising.retirement.events[xi.zone.SOUTHERN_SAN_DORIA], 'Expected the hand-over event first')
        raisingClient.finish(client, 0)

        player.assert:hasItem(xi.item.VCS_REGISTRATION_CARD)
        player.assert:hasItem(xi.item.CHOCOBO_EGG_FAINTLY_WARM)
    end)

    it('gives nothing to a player who gives up', function()
        raisingClient.setChocobo(player, { stage = xi.chocoboRaising.stage.CHICK })
        player:setCharVar(walks.lostChickVar, solvedLostChick())

        raisingClient.talk(client)
        raisingClient.send(client, 240)
        raisingClient.finish(client, 0)

        player.assert.no:hasItem(xi.item.VCS_REGISTRATION_CARD)
        assert(not xi.chocoboRaising.retirement.hasHeldItems(player), 'Expected nothing held')
        assert(not player:getChocoboRaisingInfo(), 'Expected the chocobo gone')
        assert(player:getCharVar(walks.lostChickVar) == 0, 'Expected the lost chick reset')
    end)
end)
