-----------------------------------
-- The developer debug menu on the stable's debug chocobo, driven by a GM.
-----------------------------------
local raisingClient = require('scripts.tests.systems.chocobo_raising.client')

-- The command is the low byte and its argument starts at bit 8.
local function debugOption(opCommand, arg)
    return opCommand + bit.lshift(arg, 8)
end

local command =
{
    ABILITIES          = 206,
    LOST_CHICK         = 207,
    INFLICT_NEXT_DAY   = 209,
    COLOR              = 210,
    TEMPERAMENT        = 211,
    WEATHER_PREFERENCE = 212,
    FLAGS              = 213,
    MOVE_TIME_FORWARD  = 226,
    RESET_DEFAULTS     = 227,
    WEATHER_CHECK      = 228,
    STATUS             = 229,
    ALTER_STAT         = 230,
    USER_WORK          = 232,
    CHECK_CONDITION    = 233,
    HEAL_CONDITION     = 234,
    INFLICT_CONDITION  = 235,
    GROWTH_STAGE       = 236,
    DNA                = 237,
    RECEIVE_ITEM       = 238,
}

describe('Chocobo raising debug menu', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_CHOCOBO_RAISING', true)
        xi.test.world:setSeed(1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:deleteRaisedChocobo()
        player:setGMLevel(3)
    end)

    after_each(function()
        player:deleteRaisedChocobo()
    end)

    it('opens for a GM at level 1, not for a player, and names the chocobo or none once it has left', function()
        local debug = raisingClient.newDebug(player)

        player:setGMLevel(0)
        player.entities:gotoAndTrigger(debug.trainer)
        player.events:expectNotInEvent()

        player:setGMLevel(1)
        local opened = raisingClient.talk(debug)
        raisingClient.finish(debug, 0)
        assert(opened.eventId == xi.chocoboRaising.debugCSID(player), string.format('Expected the debug event, got %d', opened.eventId))

        raisingClient.tradeEgg(player)
        raisingClient.setChocobo(player, { first_name = 'Arkie', last_name = 'Rider' })

        local start = raisingClient.talk(debug)
        raisingClient.finish(debug, 0)
        assert(start.strings[0] == 'Arkie' and start.strings[1] == 'Rider', string.format('Expected Arkie and Rider, got "%s" and "%s"', start.strings[0], start.strings[1]))

        player:deleteRaisedChocobo()
        start = raisingClient.talk(debug)
        raisingClient.finish(debug, 0)
        assert(start.strings[0] == '' and start.strings[1] == '', string.format('Expected no name, got "%s" and "%s"', start.strings[0], start.strings[1]))
    end)

    it('moves time forward and leaves the days for the trainer to report', function()
        local trainer = raisingClient.tradeEgg(player)
        local debug   = raisingClient.newDebug(player)

        raisingClient.talk(debug)
        raisingClient.send(debug, debugOption(command.MOVE_TIME_FORWARD, 5))
        raisingClient.finish(debug, 0)

        raisingClient.talk(debug)
        raisingClient.send(debug, command.STATUS)
        raisingClient.finish(debug, 0)

        assert(player:getChocoboRaisingInfo().last_update_age == 1, 'Expected no days applied by the menu')

        local visit = raisingClient.visit(trainer)
        assert(#visit.records > 0 and visit.records[#visit.records].endDay == 5, 'Expected the trainer to report the days up to day 5')
        assert(raisingClient.heard(visit, xi.chocoboRaising.cutscenes.EGG_HATCHING), 'Expected the egg to hatch on day 4')
    end)

    it('alters a stat and reports it raw and as a rank', function()
        local trainer = raisingClient.tradeEgg(player)
        local debug   = raisingClient.newDebug(player)

        -- Strength is stat 0
        raisingClient.talk(debug)
        raisingClient.send(debug, debugOption(command.ALTER_STAT, 200))

        local status = raisingClient.send(debug, command.STATUS)
        assert(bit.band(status[1], 0xFF) == 200, string.format('Expected raw strength 200, got %d', bit.band(status[1], 0xFF)))
        raisingClient.finish(debug, 0)

        raisingClient.talk(trainer)
        raisingClient.send(trainer, 244)
        local condition = raisingClient.send(trainer, 251)
        assert(bit.band(condition[1], 0xFF) == xi.chocoboRaising.statRank.OUTSTANDING, 'Expected strength 200 to read rank S')
        raisingClient.finish(trainer, 0)
    end)

    it('inflicts and heals conditions using the retail bits, now or at the next rollover', function()
        local trainer = raisingClient.tradeEgg(player)
        local debug   = raisingClient.newDebug(player)
        local sick    = xi.chocoboRaising.conditions.SICK

        raisingClient.talk(debug)
        raisingClient.send(debug, debugOption(command.INFLICT_CONDITION, sick))
        assert(raisingClient.send(debug, command.CHECK_CONDITION)[0] == bit.lshift(1, sick), 'Expected minor illness in bit 1')
        raisingClient.finish(debug, 0)

        raisingClient.talk(trainer)
        raisingClient.send(trainer, 244)
        assert(raisingClient.send(trainer, 251)[4] == 2, 'Expected the trainer to report minor illness')
        assert(raisingClient.send(trainer, 46)[0] == 2, 'Expected the mood to follow the condition')
        raisingClient.finish(trainer, 0)

        raisingClient.talk(debug)
        raisingClient.send(debug, debugOption(command.HEAL_CONDITION, sick))
        assert(raisingClient.send(debug, command.CHECK_CONDITION)[0] == 0, 'Expected the condition healed')

        raisingClient.send(debug, debugOption(command.INFLICT_NEXT_DAY, sick))
        assert(raisingClient.send(debug, command.CHECK_CONDITION)[0] == 0, 'Expected nothing held before the rollover')
        raisingClient.send(debug, debugOption(command.MOVE_TIME_FORWARD, 1))
        raisingClient.finish(debug, 0)

        local visit = raisingClient.visit(trainer)
        assert(raisingClient.heard(visit, xi.chocoboRaising.cutscenes.IS_INJURED + sick), 'Expected the minor illness to start')
        assert(player:getCharVar(xi.chocoboRaising.debugOnsetVar) == 0, 'Expected the next-day conditions used up')
    end)

    it('jumps to a growth stage', function()
        local trainer = raisingClient.tradeEgg(player)
        local debug   = raisingClient.newDebug(player)

        -- The client sends no update for it; the option ends the event.
        raisingClient.talk(debug)
        raisingClient.finish(debug, debugOption(command.GROWTH_STAGE, xi.chocoboRaising.stage.ADULT_1))

        assert(player:getChocoboRaisingInfo().stage == xi.chocoboRaising.stage.ADULT_1, 'Expected an adult chocobo')

        -- A GM also sees the debug items in the main menu, so check it as a player.
        raisingClient.setChocobo(player, { first_name = 'G', last_name = 'Fat' })
        player:setGMLevel(0)
        raisingClient.talk(trainer)
        raisingClient.send(trainer, 244)
        raisingClient.send(trainer, 214)
        local mask = raisingClient.send(trainer, 215)[0]

        -- An adult without the whistle shows main menu 0x5FFFFFE8.
        assert(mask == 0x5FFFFFE8, string.format('Expected the retail adult main menu, got 0x%X', mask))
        raisingClient.finish(trainer, 0)
    end)

    it('toggles the flags, and a handkerchief given that way can be handed in at once', function()
        local trainer = raisingClient.tradeEgg(player)
        local debug   = raisingClient.newDebug(player)

        -- Flag 3 is the key item to stop crying, flag 2 the one day flag
        raisingClient.talk(debug)
        raisingClient.send(debug, debugOption(command.FLAGS, 3))
        raisingClient.send(debug, debugOption(command.FLAGS, 2))
        raisingClient.finish(debug, 0)

        player.assert:hasKI(xi.keyItem.WHITE_HANDKERCHIEF)

        local visit = raisingClient.visit(trainer)
        assert(visit.preMenuCutscene == xi.chocoboRaising.cutscenes.THAT_SHOULD_BE_ENOUGH, 'Expected the hand-in')
        player.assert.no:hasKI(xi.keyItem.WHITE_HANDKERCHIEF)

        player:delKeyItem(xi.keyItem.DIRTY_HANDKERCHIEF)
        player:delKeyItem(xi.keyItem.STORY_OF_AN_IMPATIENT_CHOCOBO)

        -- Treasure key item is flag 4, the impatient story flag 5
        raisingClient.talk(debug)
        raisingClient.send(debug, command.FLAGS)
        assert(raisingClient.send(debug, debugOption(command.FLAGS, 4))[4] == 1, 'Expected the treasure key item shown on')
        assert(bit.band(raisingClient.send(debug, debugOption(command.FLAGS, 5))[6], 1) == 1, 'Expected the impatient story shown on')
        raisingClient.finish(debug, 0)
    end)

    it('shows, sets and resets the lost chick', function()
        local walks = xi.chocoboRaising.walks
        local debug = raisingClient.newDebug(player)

        player:setCharVar(walks.lostChickVar, 0)
        raisingClient.talk(debug)

        local shown = raisingClient.send(debug, command.LOST_CHICK)
        assert(shown[0] == 0 and shown[1] == 0, string.format('Expected no owner and active, got %d and %d', shown[0], shown[1]))

        -- Number 5 is index 4 in bits 16-23.
        raisingClient.send(debug, debugOption(command.LOST_CHICK, 1) + bit.lshift(4, 16))
        local chick = walks.lostChick(player:getCharVar(walks.lostChickVar))
        assert(chick.owner == 5 and chick.location == 1 and chick.clues == 0, string.format('Expected owner 5 at stable 1, got owner %d at %d', chick.owner, chick.location))
        assert(raisingClient.send(debug, command.LOST_CHICK)[0] == 5, 'Expected owner 5 shown')

        chick.solved = true
        player:setCharVar(walks.lostChickVar, walks.packLostChick(chick))
        assert(raisingClient.send(debug, command.LOST_CHICK)[1] == 1, 'Expected a solved chick shown as disabled')

        raisingClient.send(debug, debugOption(command.LOST_CHICK, 2))
        assert(player:getCharVar(walks.lostChickVar) == 0, 'Expected the lost chick reset')
        assert(raisingClient.send(debug, command.LOST_CHICK)[0] == 0, 'Expected no owner shown')
        raisingClient.finish(debug, 0)
    end)

    it('gives eggs and matchmaking cards that carry the chosen genes', function()
        local debug = raisingClient.newDebug(player)
        local blue  = xi.chocoboRaising.color.BLUE
        local black = xi.chocoboRaising.color.BLACK

        -- Card M with three blue genes, before any chocobo
        raisingClient.talk(debug)
        raisingClient.send(debug, debugOption(command.RECEIVE_ITEM, 6 + bit.lshift(blue + bit.lshift(blue, 3) + bit.lshift(blue, 6), 8)))
        raisingClient.finish(debug, 0)

        local sire = assert(player:findItem(xi.item.CHOCOCARD_M), 'Expected card M'):getExData()
        assert(sire.gender == xi.chocoboRaising.gender.MALE and sire.color == blue, 'Expected a blue male card')
        assert(sire.dna[1] == blue and sire.dna[2] == blue and sire.dna[3] == blue, 'Expected three blue genes')
        assert(sire.name == 'DebugChocobo', string.format('Expected the debug name, got "%s"', tostring(sire.name)))

        -- Card F from the raised chocobo, with its name and strength
        raisingClient.tradeEgg(player)
        raisingClient.setChocobo(player, { first_name = 'Arkie', last_name = 'Rider', strength = 64 })

        raisingClient.talk(debug)
        raisingClient.send(debug, debugOption(command.RECEIVE_ITEM, 7))
        raisingClient.finish(debug, 0)

        local dam = assert(player:findItem(xi.item.CHOCOCARD_F), 'Expected card F'):getExData()
        assert(dam.gender == xi.chocoboRaising.gender.FEMALE and dam.color == xi.chocoboRaising.color.YELLOW, 'Expected a yellow female card')
        assert(dam.name == 'ArkieRider' and dam.strength.rank == xi.chocoboRaising.statRank.A_BIT_DEFICIENT, 'Expected the name and strength of the chocobo on the card')

        -- Egg 1 with three black genes; no chocobo is needed to receive an item
        player:deleteRaisedChocobo()
        raisingClient.talk(debug)
        raisingClient.send(debug, debugOption(command.RECEIVE_ITEM, 1 + bit.lshift(black + bit.lshift(black, 3) + bit.lshift(black, 6), 8)))
        raisingClient.finish(debug, 0)

        local trainer = raisingClient.new(player)
        raisingClient.trade(trainer, { xi.item.CHOCOBO_EGG_FAINTLY_WARM })
        raisingClient.send(trainer, 252)
        raisingClient.finish(trainer, 252)
        assert(player:getChocoboRaisingInfo().color == black, 'Expected a black chocobo from the chosen genes')
    end)

    it('shows the new abilities, temperament, weather preference and colour after a change', function()
        raisingClient.tradeEgg(player)

        local ability = xi.chocoboRaising.ability
        local debug   = raisingClient.newDebug(player)

        raisingClient.talk(debug)
        raisingClient.send(debug, debugOption(command.ABILITIES, 1))

        -- Gallop first, then Burrow
        local slots = raisingClient.send(debug, debugOption(command.ABILITIES, 2) + bit.lshift(ability.GALLOP, 16) + bit.lshift(ability.BURROW, 24))
        assert(slots[0] == ability.GALLOP and slots[1] == ability.BURROW, string.format('Expected Gallop and Burrow shown, got %d and %d', slots[0], slots[1]))

        local info = player:getChocoboRaisingInfo()
        assert(info.ability1 == ability.GALLOP and info.ability2 == ability.BURROW, 'Expected Gallop and Burrow saved')

        -- None first clears both
        slots = raisingClient.send(debug, debugOption(command.ABILITIES, 2))
        assert(slots[0] == 0 and slots[1] == 0, 'Expected both slots cleared')

        -- Fierce and Cloudy are second choices, Blue the third
        assert(raisingClient.send(debug, debugOption(command.TEMPERAMENT, 2))[0] == xi.chocoboRaising.temperament.ILL_TEMPERED, 'Expected fierce shown')
        assert(raisingClient.send(debug, debugOption(command.WEATHER_PREFERENCE, 2))[0] == xi.chocoboRaising.weather.CLOUDY, 'Expected cloudy shown')
        assert(raisingClient.send(debug, debugOption(command.COLOR, 3))[0] == xi.chocoboRaising.color.BLUE, 'Expected blue shown')
        raisingClient.finish(debug, 0)

        info = player:getChocoboRaisingInfo()
        assert(info.personality == xi.chocoboRaising.temperament.ILL_TEMPERED and info.weather_preference == xi.chocoboRaising.weather.CLOUDY, 'Expected the changes saved')
    end)

    it('changes the genes only once the pick is confirmed, and drops the pick and next-day conditions on a reset', function()
        raisingClient.tradeEgg(player)
        raisingClient.setChocobo(player, { allele1 = 0, allele2 = 0, allele3 = 0, color = xi.chocoboRaising.color.YELLOW })

        local red   = xi.chocoboRaising.color.RED
        local genes = red + bit.lshift(red, 3) + bit.lshift(red, 6)
        local debug = raisingClient.newDebug(player)

        -- Picked and declined
        raisingClient.talk(debug)
        raisingClient.send(debug, debugOption(command.DNA, 1))
        raisingClient.send(debug, command.DNA + bit.lshift(genes, 16))
        assert(raisingClient.send(debug, debugOption(command.DNA, 1))[0] == 0, 'Expected the genes unchanged without the confirmation')

        -- Picked and confirmed
        raisingClient.send(debug, command.DNA + bit.lshift(genes, 16))
        raisingClient.send(debug, debugOption(command.DNA, 2))
        assert(raisingClient.send(debug, debugOption(command.DNA, 1))[0] == genes, 'Expected three red genes')
        raisingClient.finish(debug, 0)

        assert(player:getChocoboRaisingInfo().color == red, 'Expected a red chocobo')

        raisingClient.setChocobo(player, { allele1 = 0, allele2 = 0, allele3 = 0 })
        player:setCharVar(xi.chocoboRaising.debugOnsetVar, bit.lshift(1, xi.chocoboRaising.conditions.SICK))

        raisingClient.talk(debug)
        raisingClient.send(debug, command.DNA + bit.lshift(genes, 16))
        raisingClient.send(debug, command.RESET_DEFAULTS)
        raisingClient.send(debug, debugOption(command.DNA, 2))
        raisingClient.finish(debug, 0)

        assert(player:getCharVar(xi.chocoboRaising.debugOnsetVar) == 0, 'Expected no next-day conditions')
        assert(player:getChocoboRaisingInfo().allele1 == 0, 'Expected the picked genes dropped')
    end)

    it('prints the conditions, the Ronfaure weather and the user work', function()
        raisingClient.tradeEgg(player)

        local debug = raisingClient.newDebug(player)

        raisingClient.talk(debug)
        raisingClient.send(debug, debugOption(command.INFLICT_CONDITION, xi.chocoboRaising.conditions.SICK))

        raisingClient.send(debug, command.CHECK_CONDITION)
        local text = raisingClient.chatText(player)
        assert(string.find(text, 'Conditions: SICK', 1, true), string.format('Expected the conditions printed, got "%s"', text))

        raisingClient.send(debug, command.WEATHER_CHECK)
        text = raisingClient.chatText(player)
        assert(string.find(text, 'West Ronfaure weather', 1, true), string.format('Expected the weather printed, got "%s"', text))

        raisingClient.send(debug, command.USER_WORK)
        text = raisingClient.chatText(player)
        assert(string.find(text, 'Lost chick: owner', 1, true), string.format('Expected the user work printed, got "%s"', text))
        raisingClient.finish(debug, 0)
    end)
end)
