-----------------------------------
-- Feretory rules, read from data/monstrosity.yaml through the entity bindings.
-----------------------------------
local ffi     = require('ffi')
local helpers = require('scripts.tests.systems.monstrosity.helpers')

-- 0x102 for Monstrosity: flags at 0x0A, species at 0x0C, instinct slots from 0x10.
local extendedJobSize = 164

describe('Monstrosity starting state', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.WEST_RONFAURE)
    end)

    it('starts with Rabbit, Mandragora and Lizard at level 1', function()
        local data = player:getMonstrosityData()

        for _, family in ipairs({ xi.monstrositySpecies.RABBIT, xi.monstrositySpecies.MANDRAGORA, xi.monstrositySpecies.LIZARD }) do
            assert(data.levels[family] == 1, string.format('family %d is level %s', family, tostring(data.levels[family])))
        end

        assert(data.levels[xi.monstrositySpecies.BEE] == 0, 'Bee should start locked')
    end)

    -- Retail reports MON as both jobs at the species level, and describes each in 0x044.
    it('reports MON as both main and sub job', function()
        player:gotoZone(xi.zone.WEST_RONFAURE)
        player.packets:clear()
        helpers.sendGameOk(player)

        local subFlags = {}
        local status   = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x061 then
                status = pkt
            elseif pkt.type == 0x044 and pkt.data[0x04] == xi.job.MON then
                subFlags[pkt.data[0x05]] = true
            end
        end

        assert(status, 'no CLISTATUS was sent')
        assert(status.data[0x0E] == xi.job.MON, string.format('sub job is %d', status.data[0x0E]))
        assert(status.data[0x0F] == status.data[0x0D], 'sub job level should match main')
        assert(subFlags[0] and subFlags[1], 'expected a main and a sub job 0x044')
    end)

    -- Retail lists only Trusts, spell ids 896 and up, while in Monstrosity.
    it('lists no spells but Trusts', function()
        player.packets:clear()
        player:addSpell(xi.magic.spell.CURE)

        local found = false
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x0AA then
                found = true
                for idx = 0x04, 0x04 + 896 / 8 - 1 do
                    assert(pkt.data[idx] == 0, string.format('spell bits set at byte %d', idx))
                end
            end
        end

        assert(found, 'no spell list was sent')
    end)

    -- Retail sends the species and levels after the client reports the zone loaded.
    -- Anything sent before that can be dropped, and the client then lists no moves.
    it('sends Monstrosity data once the client has loaded the zone', function()
        player.packets:clear()
        helpers.sendGameOk(player)

        local species  = nil
        local hasParty = false
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x063 and pkt.data[0x04] == 3 then
                species = pkt.data[0x08] + pkt.data[0x09] * 256
            elseif pkt.type == 0x0DF then
                hasParty = true
            end
        end

        assert(species == xi.monstrositySpecies.RABBIT, string.format('species after GAMEOK was %s', tostring(species)))

        assert(hasParty, 'the species change set was not sent after GAMEOK')

        -- Retail size fields.
        local sizes = { [3] = 216, [4] = 176 }
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x063 and sizes[pkt.data[0x04]] then
                local size = pkt.data[0x06] + pkt.data[0x07] * 256
                assert(size == sizes[pkt.data[0x04]], string.format('0x063 type %d size field is %d', pkt.data[0x04], size))
            end
        end
    end)

    it('starts owning the five race instincts and nothing else', function()
        local data = player:getMonstrosityData()

        assert(data.instincts[20] == 0x1F, string.format('instinct byte 20 is 0x%02X', data.instincts[20]))
        assert(data.instincts[21] == 0, string.format('instinct byte 21 is 0x%02X', data.instincts[21]))
    end)
end)

describe('Monstrosity Feretory exits', function()
    ---@type CClientEntityPair
    local player

    local function settle()
        for _ = 1, 8 do
            xi.test.world:skipTime(1)
        end
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.FERETORY })
    end)

    -- The quest sends a player in on their normal job, and the zone changes it to MON.
    it('builds the Monipulator when a player walks in on another job', function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player:changeJob(xi.job.WAR)
        player:setLevel(75)
        player:gotoZone(xi.zone.FERETORY)

        assert(player:getMainJob() == xi.job.MON, string.format('main job is %d', player:getMainJob()))
        assert(player:getSubJob() == xi.job.MON, string.format('sub job is %d', player:getSubJob()))
        assert(player:getMainLvl() < 75, string.format('kept the WAR level %d', player:getMainLvl()))
        assert(player:getEcosystem() ~= xi.ecosystem.HUMANOID, 'kept the Humanoid ecosystem')
    end)

    it('drops the species ecosystem on leaving MON', function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player:changeJob(xi.job.MON)
        player:changeJob(xi.job.WAR)

        assert(player:getEcosystem() == xi.ecosystem.HUMANOID, 'a WAR kept the species ecosystem')
    end)

    it('refuses a passage to a zone the player has not visited', function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.FERETORY)

        xi.monstrosity.odysseanPassageOnEventFinish(player, 5, 1 + bit.lshift(xi.zone.WEST_SARUTABARUTA, 4))
        settle()

        assert(player:getZoneID() == xi.zone.FERETORY, 'travelled to an unvisited zone')
    end)

    it('refuses a passage to a town', function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player:gotoZone(xi.zone.SOUTHERN_SAN_DORIA)
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.FERETORY)

        xi.monstrosity.odysseanPassageOnEventFinish(player, 5, 1 + bit.lshift(xi.zone.SOUTHERN_SAN_DORIA, 4))
        settle()

        assert(player:getZoneID() == xi.zone.FERETORY, 'travelled to a town')
    end)

    -- A zone script moves an arrival at (0, 0, 0) to its default entry point.
    it('sends a visited zone with no listed exits to its default entry point', function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player:gotoZone(xi.zone.WEST_RONFAURE)
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.FERETORY)

        xi.monstrosity.odysseanPassageOnEventFinish(player, 5, 1 + bit.lshift(xi.zone.WEST_RONFAURE, 4))
        settle()

        assert(player:getZoneID() == xi.zone.WEST_RONFAURE, string.format('arrived in zone %d', player:getZoneID()))
        assert(player:getXPos() ~= 0 or player:getZPos() ~= 0, 'left at the zone origin')
    end)

    it('strips every effect but Medicated on entering', function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player:gotoZone(xi.zone.WEST_RONFAURE)
        player:addStatusEffect(xi.effect.PROTECT, { power = 20, duration = 1800, origin = player })
        player:addStatusEffect(xi.effect.MEDICINE, { power = 1, duration = 3600, origin = player })
        player:gotoZone(xi.zone.FERETORY)

        assert(not player:hasStatusEffect(xi.effect.PROTECT), 'Protect survived entering the Feretory')
        player.assert:hasEffect(xi.effect.MEDICINE)
    end)

    it('lists every exit position for a zone', function()
        local exits = player:getMonstrosityExits(xi.zone.EAST_RONFAURE)

        assert(#exits == 4, string.format('East Ronfaure has %d exits', #exits))
        assert(exits[1][1] == 120 and exits[1][3] == -530 and exits[1][4] == 192, 'first exit is wrong')
        assert(#player:getMonstrosityExits(xi.zone.LA_THEINE_PLATEAU) == 0, 'La Theine Plateau has no exits')
        assert(#player:getMonstrosityExits(xi.zone.BHAFLAU_THICKETS) == 2, 'Bhaflau Thickets should have two exits')
    end)
end)

-- Teyrnon's event reports a purchase as optionType 1, the page plus one in bits 8-11 and
-- the slot from bit 16.
describe('Monstrosity Teyrnon shop', function()
    ---@type CClientEntityPair
    local player

    local function buy(page, slot)
        xi.monstrosity.teyrnonOnEventFinish(player, 7, 1 + bit.lshift(page + 1, 8) + bit.lshift(slot, 16))
    end

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.FERETORY)
    end)

    -- A fresh Monipulator on retail was offered Cockatrice and Bat on the Birds page, and Crab and Pugil on the Aquans page.
    it('lists the pages a fresh Monipulator can buy from', function()
        player.entities:gotoAndTrigger('Teyrnon')
        player.packets:clear()
        player.events:update(7, bit.lshift(6, 16))
        player.events:update(7, bit.lshift(5, 16))

        local replies = helpers.updateReplies(player)
        assert(replies[1] == 5 and replies[2] == 17, string.format('page masks were %s and %s', tostring(replies[1]), tostring(replies[2])))
    end)

    it('sells a family for its infamy', function()
        player:addCurrency('infamy', 3000)
        -- Sheep
        buy(0, 1)

        assert(xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.SHEEP), 'Sheep should be unlocked')
        assert(player:getCurrency('infamy') == 0, string.format('%d infamy left', player:getCurrency('infamy')))
    end)

    it('sells a variant for its infamy', function()
        xi.monstrosity.setSpeciesLevel(player, xi.monstrositySpecies.WIVRE, 60)
        player:addCurrency('infamy', 7500)
        -- Unusual Wivre
        buy(3, 0)

        assert(xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.UNUSUAL_WIVRE), 'Unusual Wivre should be unlocked')
    end)

    it('sells the Treant Sapling family', function()
        player:addCurrency('infamy', 3000)
        buy(1, 1)

        assert(xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.TREANT_SAPLING), 'Treant Sapling should be unlocked')
    end)

    it('refuses a purchase whose level requirements are not met', function()
        player:addCurrency('infamy', 7500)
        -- Unusual Wivre needs Wivre 60
        buy(3, 0)

        assert(not xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.UNUSUAL_WIVRE), 'Unusual Wivre should stay locked')
        assert(player:getCurrency('infamy') == 7500, 'infamy should be untouched')
    end)

    it('refuses a purchase the player cannot afford', function()
        player:addCurrency('infamy', 2999)
        buy(0, 1)

        assert(not xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.SHEEP), 'Sheep should stay locked')
        assert(player:getCurrency('infamy') == 2999, 'infamy should be untouched')
    end)

    it('ignores a slot that does not exist', function()
        player:addCurrency('infamy', 50000)
        buy(0, 31)
        buy(9, 0)

        assert(player:getCurrency('infamy') == 50000, 'infamy should be untouched')
    end)

    -- An instinct purchase is optionType 2, the instinct from bit 8 and a check value of 119 from bit 16.
    local function buyInstinct(instinct, checkValue)
        xi.monstrosity.teyrnonOnEventFinish(player, 7, 2 + bit.lshift(instinct, 8) + bit.lshift(checkValue, 16))
    end

    local function ownsInstinct(instinct)
        local byte = player:getMonstrosityData().instincts[20 + math.floor(instinct / 8)] or 0
        return bit.band(byte, bit.lshift(1, instinct % 8)) ~= 0
    end

    it('sells a race instinct for its infamy', function()
        player:addCurrency('infamy', 500)
        buyInstinct(xi.monstrosityInstinct.HUME_II, 119)

        assert(ownsInstinct(xi.monstrosityInstinct.HUME_II), 'Hume II should be owned')
        assert(player:getCurrency('infamy') == 0, string.format('%d infamy left', player:getCurrency('infamy')))
    end)

    -- A buff is optionType 3 with the effect from bit 8. Costs are fixed in the client event.
    local buffs =
    {
        { name = 'Dedication 1', option = 0, effect = xi.effect.DEDICATION, cost = 3000, minutes = 60 },
        { name = 'Dedication 2', option = 1, effect = xi.effect.DEDICATION, cost =  400, minutes = 60 },
        { name = 'Regen',        option = 2, effect = xi.effect.REGEN,      cost =   10, minutes = 60 },
        { name = 'Refresh',      option = 3, effect = xi.effect.REFRESH,    cost =   10, minutes = 60 },
        { name = 'Protect',      option = 4, effect = xi.effect.PROTECT,    cost =  100, minutes = 30 },
        { name = 'Shell',        option = 5, effect = xi.effect.SHELL,      cost =  100, minutes = 30 },
        { name = 'Haste',        option = 6, effect = xi.effect.HASTE,      cost =  100, minutes = 30 },
    }

    for _, buff in ipairs(buffs) do
        it(string.format('casts %s for %d infamy and %d minutes', buff.name, buff.cost, buff.minutes), function()
            player:addCurrency('infamy', 5000)
            xi.monstrosity.teyrnonOnEventFinish(player, 7, 3 + bit.lshift(buff.option, 8))

            player.assert:hasEffect(buff.effect)
            assert(player:getCurrency('infamy') == 5000 - buff.cost, string.format('%d infamy left', player:getCurrency('infamy')))

            local duration = player:getStatusEffect(buff.effect):getDuration()
            assert(duration == buff.minutes * 60 * 1000, string.format('%s lasts %d ms', buff.name, duration))
        end)
    end

    it('casts no buff the player cannot afford', function()
        player:addCurrency('infamy', 99)
        xi.monstrosity.teyrnonOnEventFinish(player, 7, 3 + bit.lshift(6, 8))

        assert(not player:hasStatusEffect(xi.effect.HASTE), 'Haste was cast for 99 infamy')
        assert(player:getCurrency('infamy') == 99, 'infamy should be untouched')
    end)

    it('casts nothing for an unknown buff', function()
        player:addCurrency('infamy', 1000)
        xi.monstrosity.teyrnonOnEventFinish(player, 7, 3 + bit.lshift(7, 8))

        assert(player:getCurrency('infamy') == 1000, 'infamy should be untouched')
    end)

    -- Protect and Shell take the spell tier for the Monipulator's level.
    local tierChecks =
    {
        { option = 4, effect = xi.effect.PROTECT, level = 26, power = 20   },
        { option = 4, effect = xi.effect.PROTECT, level = 27, power = 50   },
        { option = 4, effect = xi.effect.PROTECT, level = 99, power = 220  },
        { option = 5, effect = xi.effect.SHELL,   level = 36, power = 1055 },
        { option = 5, effect = xi.effect.SHELL,   level = 37, power = 1641 },
        { option = 5, effect = xi.effect.SHELL,   level = 99, power = 2930 },
    }

    for _, check in ipairs(tierChecks) do
        local name = check.effect == xi.effect.PROTECT and 'Protect' or 'Shell'
        it(string.format('casts %s power %d at level %d', name, check.power, check.level), function()
            helpers.becomeSpecies(player, xi.monstrositySpecies.RABBIT, xi.monstrositySpecies.RABBIT, check.level)
            player:addCurrency('infamy', 100)
            xi.monstrosity.teyrnonOnEventFinish(player, 7, 3 + bit.lshift(check.option, 8))

            local power = player:getStatusEffect(check.effect):getPower()
            assert(power == check.power, string.format('power is %d', power))
        end)
    end

    it('refuses an instinct purchase with the wrong check value', function()
        player:addCurrency('infamy', 500)
        buyInstinct(xi.monstrosityInstinct.HUME_II, 118)

        assert(not ownsInstinct(xi.monstrosityInstinct.HUME_II), 'Hume II should stay locked')
        assert(player:getCurrency('infamy') == 500, 'infamy should be untouched')
    end)
end)

describe('Monstrosity Aengus', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.FERETORY)
    end)

    -- The last 0x036 message Aengus sent.
    local function lastMessage()
        local message = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x036 then
                message = pkt.data[0x0A] + pkt.data[0x0B] * 256
            end
        end

        return message
    end

    it('toggles Belligerency', function()
        local ID = zones[xi.zone.FERETORY]

        player.packets:clear()
        player.entities:gotoAndTrigger('Aengus', { eventId = 13, finishOption = 1 })
        assert(player:getBelligerencyFlag(), 'Belligerency should be on')
        assert(lastMessage() == ID.text.SOUL_PINETH_FOR_MORE, string.format('entering said %s', tostring(lastMessage())))

        player.packets:clear()
        player.entities:gotoAndTrigger('Aengus', { eventId = 13, finishOption = 1 })
        assert(not player:getBelligerencyFlag(), 'Belligerency should be off')
        assert(lastMessage() == ID.text.SAFE_FROM_MONIPULATORS, string.format('withdrawing said %s', tostring(lastMessage())))
    end)
end)

-- Suibhne's quiz. The answer key and the result encoding are read from the client's event 11:
-- success is 1 with each answer packed three bits apiece from bit 16, failure is 2.
describe('Monstrosity Bee quiz', function()
    local aengus  = 1
    local suibhne = 3
    local teyrnon = 4

    ---@type CClientEntityPair
    local player

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.FERETORY)

        -- Pin the first quiz, whose answers are Teyrnon, Aengus, Suibhne.
        player:setCharVar('HQuest[monstrosityBee]Option', 1)
    end)

    it('unlocks bees for the right answers', function()
        local answers = 1 + bit.lshift(teyrnon, 16) + bit.lshift(aengus, 19) + bit.lshift(suibhne, 22)
        player.entities:gotoAndTrigger('Suibhne', { eventId = 11, finishOption = answers })

        assert(xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.BEE), 'Bee should be unlocked')
    end)

    it('keeps bees locked after a wrong answer', function()
        player.entities:gotoAndTrigger('Suibhne', { eventId = 11, finishOption = 2 })

        assert(not xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.BEE), 'Bee should stay locked')
    end)

    -- Retail sends the locked quiz as (0, quiz index) until the next Vana'diel day.
    it('locks the quiz for the day after a wrong answer', function()
        player.entities:gotoAndTrigger('Suibhne', { eventId = 11, finishOption = 2 })

        -- The second quiz, so the index in the locked event can be told from the default 0.
        player:setCharVar('HQuest[monstrosityBee]Option', 2)
        player.packets:clear()

        local answers = 1 + bit.lshift(teyrnon, 16) + bit.lshift(aengus, 19) + bit.lshift(suibhne, 22)
        player.entities:gotoAndTrigger('Suibhne', { eventId = 11, finishOption = answers })

        local params = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x034 then
                params = { pkt.data[0x08], pkt.data[0x0C] }
            end
        end

        assert(params and params[1] == 0 and params[2] == 1, string.format('quiz params were %s, %s', tostring(params and params[1]), tostring(params and params[2])))
        assert(not xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.BEE), 'a locked quiz unlocked bees')
    end)

    it('reopens the quiz the next day', function()
        local answers = 1 + bit.lshift(teyrnon, 16) + bit.lshift(aengus, 19) + bit.lshift(suibhne, 22)
        player.entities:gotoAndTrigger('Suibhne', { eventId = 11, finishOption = 2 })
        xi.test.world:skipToNextVanaDay()
        player.entities:gotoAndTrigger('Suibhne', { eventId = 11, finishOption = answers })

        assert(xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.BEE), 'Bee should be unlocked the next day')
    end)

    it('announces the unlock and stops offering the quiz', function()
        local answers = 1 + bit.lshift(teyrnon, 16) + bit.lshift(aengus, 19) + bit.lshift(suibhne, 22)
        player.packets:clear()
        player.entities:gotoAndTrigger('Suibhne', { eventId = 11, finishOption = answers })
        xi.test.world:skipTime(1)

        local announced = false
        for _, pkt in pairs(player.packets:getIncoming()) do
            -- The top bit of the message number is a flag.
            if
                pkt.type == 0x02A and
                bit.band(pkt.data[0x1A] + pkt.data[0x1B] * 256, 0x7FFF) == zones[xi.zone.FERETORY].text.MAY_POSSESS_BEES
            then
                announced = true
            end
        end

        assert(announced, 'the Bee unlock was not announced')

        -- The quiz event's first param says whether the quiz is open.
        player.packets:clear()
        player.entities:gotoAndTrigger('Suibhne', { eventId = 11 })
        for _, pkt in pairs(player.packets:getIncoming()) do
            assert(pkt.type ~= 0x034 or pkt.data[0x08] == 0, 'Suibhne offered the quiz after bees were unlocked')
        end
    end)
end)

-- Event 15 trades a seasonal item for a family or variant.
describe('Monstrosity Suibhne trades', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.FERETORY)
    end)

    it('unlocks Astoltian Slime for a Slime Fetish', function()
        player:addItem(xi.item.SLIME_FETISH)
        -- Retail echoes the species code in the high word.
        player.actions:tradeNpc('Suibhne', { xi.item.SLIME_FETISH }, { eventId = 15, finishOption = 0xFE0002 })

        assert(xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.ASTOLTIAN_SLIME), 'Astoltian Slime should be unlocked')
        assert(not player:hasItem(xi.item.SLIME_FETISH), 'the Slime Fetish was not taken')
        assert(player:getMonstrosityData().species == xi.monstrositySpecies.RABBIT, 'a new family changed the form')
    end)

    -- Retail switches into a variant as soon as Suibhne unlocks it.
    it('switches to the Metal Slime on unlocking it', function()
        local data = player:getMonstrosityData()
        data.monstrosityId                                = xi.monstrositySpecies.ASTOLTIAN_SLIME
        data.species                                      = 128 + xi.monstrositySpecies.ASTOLTIAN_SLIME
        data.levels[xi.monstrositySpecies.ASTOLTIAN_SLIME] = 1
        player:setMonstrosityData(data)

        player:addItem(xi.item.METAL_SLIME_SPIRIT)
        player.actions:tradeNpc('Suibhne', { xi.item.METAL_SLIME_SPIRIT }, { eventId = 15, finishOption = 0x1FD0002 })

        local species = player:getMonstrosityData().species
        assert(species == 256 + xi.monstrosityVariant.METAL_SLIME, string.format('the form is species %d', species))
    end)

    -- Takes the family's base form without leaving the Feretory.
    local function takeBaseForm(family, level)
        local data = player:getMonstrosityData()
        data.monstrosityId  = family
        data.species        = family
        data.levels[family] = level
        player:setMonstrosityData(data)
    end

    it('unlocks Eorzean Spriggan for a Spriggan Fetish', function()
        player:addItem(xi.item.SPRIGGAN_FETISH)
        player.actions:tradeNpc('Suibhne', { xi.item.SPRIGGAN_FETISH }, { eventId = 15, finishOption = 2 })

        assert(xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.EORZEAN_SPRIGGAN), 'Eorzean Spriggan should be unlocked')
        assert(not player:hasItem(xi.item.SPRIGGAN_FETISH), 'the Spriggan Fetish was not taken')
    end)

    it('unlocks the New Year Mandragora for an Ake-Ome Spirit', function()
        takeBaseForm(xi.monstrositySpecies.MANDRAGORA, 1)
        player:addItem(xi.item.AKE_OME_SPIRIT)
        player.actions:tradeNpc('Suibhne', { xi.item.AKE_OME_SPIRIT }, { eventId = 15, finishOption = 2 })

        assert(xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.NEW_YEAR_MANDRAGORA), 'the New Year Mandragora should be unlocked')
        assert(not player:hasItem(xi.item.AKE_OME_SPIRIT), 'the Ake-Ome Spirit was not taken')
    end)

    it('refuses a variant item outside the base form', function()
        player:addItem(xi.item.AKE_OME_SPIRIT)
        player.actions:tradeNpc('Suibhne', { xi.item.AKE_OME_SPIRIT })

        assert(not xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.NEW_YEAR_MANDRAGORA), 'a Rabbit unlocked the New Year Mandragora')
        assert(player:hasItem(xi.item.AKE_OME_SPIRIT), 'took the Ake-Ome Spirit from a Rabbit')
    end)

    it('unlocks the Onyx Beetle for 25 Beetle Spirits', function()
        takeBaseForm(xi.monstrositySpecies.BEETLE, 1)
        player:addItem(xi.item.BEETLE_SPIRIT, 25)
        player.actions:tradeNpc('Suibhne', { { itemId = xi.item.BEETLE_SPIRIT, quantity = 25 } }, { eventId = 15, finishOption = 2 })

        assert(xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.ONYX_BEETLE), 'the Onyx Beetle should be unlocked')
        assert(not player:hasItem(xi.item.BEETLE_SPIRIT), 'the Beetle Spirits were not taken')
    end)

    it('refuses too few spirits', function()
        takeBaseForm(xi.monstrositySpecies.BEETLE, 1)
        player:addItem(xi.item.BEETLE_SPIRIT, 24)
        player.actions:tradeNpc('Suibhne', { { itemId = xi.item.BEETLE_SPIRIT, quantity = 24 } })

        assert(not xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.ONYX_BEETLE), '24 spirits unlocked the Onyx Beetle')
    end)

    it('refuses the Pachypodium below Mandragora level 60', function()
        takeBaseForm(xi.monstrositySpecies.MANDRAGORA, 59)
        player:addItem(xi.item.PACHYPODIUM_SPIRIT, 25)
        player.actions:tradeNpc('Suibhne', { { itemId = xi.item.PACHYPODIUM_SPIRIT, quantity = 25 } })

        assert(not xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.PACHYPODIUM), 'a level 59 Mandragora unlocked the Pachypodium')
        assert(player:hasItem(xi.item.PACHYPODIUM_SPIRIT), 'took the spirits below level 60')
    end)

    it('unlocks the Legendary Manticore for 20 scraps of one seal', function()
        takeBaseForm(xi.monstrositySpecies.MANTICORE, 50)
        player:addItem(xi.item.SEAL_OF_SEIRYU_SCRAP, 20)
        player.actions:tradeNpc('Suibhne', { { itemId = xi.item.SEAL_OF_SEIRYU_SCRAP, quantity = 20 } }, { eventId = 15, finishOption = 2 })

        assert(xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.LEGENDARY_MANTICORE), 'the Legendary Manticore should be unlocked')
    end)

    it('refuses mixed seal scraps for the Legendary Manticore', function()
        takeBaseForm(xi.monstrositySpecies.MANTICORE, 50)
        player:addItem(xi.item.SEAL_OF_SEIRYU_SCRAP, 10)
        player:addItem(xi.item.SEAL_OF_GENBU_SCRAP, 10)
        player.actions:tradeNpc('Suibhne', { { itemId = xi.item.SEAL_OF_SEIRYU_SCRAP, quantity = 10 }, { itemId = xi.item.SEAL_OF_GENBU_SCRAP, quantity = 10 } })

        assert(not xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.LEGENDARY_MANTICORE), 'mixed scraps unlocked the Legendary Manticore')
    end)

    it('unlocks the She-Slime from the base Astoltian Slime', function()
        local data = player:getMonstrosityData()
        data.monstrosityId = xi.monstrositySpecies.ASTOLTIAN_SLIME
        data.species       = xi.monstrositySpecies.ASTOLTIAN_SLIME + 128
        data.levels[xi.monstrositySpecies.ASTOLTIAN_SLIME] = 1
        player:setMonstrosityData(data)

        player:addItem(xi.item.SHE_SLIME_SPIRIT)
        player.actions:tradeNpc('Suibhne', { xi.item.SHE_SLIME_SPIRIT }, { eventId = 15, finishOption = 2 })

        assert(xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.SHE_SLIME), 'the She-Slime should be unlocked')
    end)

    -- Retail names the item and the count before the quiz.
    it('asks a Crab for a creel of moat carp', function()
        takeBaseForm(xi.monstrositySpecies.CRAB, 1)
        player.packets:clear()
        player.entities:gotoAndTrigger('Suibhne')

        local request = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if
                pkt.type == 0x02A and
                pkt.data[0x1A] + pkt.data[0x1B] * 256 == zones[xi.zone.FERETORY].text.BRING_ME_ITEM
            then
                request = { pkt.data[0x08] + pkt.data[0x09] * 256, pkt.data[0x0C] }
            end
        end

        assert(request, 'Suibhne named no item')
        assert(request[1] == xi.item.CREEL_OF_MOAT_CARP and request[2] == 1, string.format('asked for %d x%d', request[1], request[2]))
    end)

    it('unlocks the Basket-burdened Crab for a creel of moat carp', function()
        takeBaseForm(xi.monstrositySpecies.CRAB, 1)
        player:addItem(xi.item.CREEL_OF_MOAT_CARP)
        player.actions:tradeNpc('Suibhne', { xi.item.CREEL_OF_MOAT_CARP }, { eventId = 15, finishOption = 2 })

        assert(xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.BASKET_BURDENED_CRAB), 'the Basket-burdened Crab should be unlocked')
    end)

    it('takes the forest carp creel only from a level 15 Vermilion Crab', function()
        takeBaseForm(xi.monstrositySpecies.CRAB, 15)
        player:addItem(xi.item.CREEL_OF_FOREST_CARP)
        player.actions:tradeNpc('Suibhne', { xi.item.CREEL_OF_FOREST_CARP })
        assert(player:hasItem(xi.item.CREEL_OF_FOREST_CARP), 'a base Crab traded the forest carp creel')

        local data = player:getMonstrosityData()
        data.species = 256 + xi.monstrosityVariant.VERMILLION_CRAB
        player:setMonstrosityData(data)
        player.actions:tradeNpc('Suibhne', { xi.item.CREEL_OF_FOREST_CARP }, { eventId = 15, finishOption = 2 })

        assert(xi.monstrosity.hasUnlockedVariant(player, xi.monstrosityVariant.VERMILLION_BASKET_BURDENED_CRAB), 'the Vermilion Basket-burdened Crab should be unlocked')
    end)

    it('keeps the item when the player declines', function()
        player:addItem(xi.item.SLIME_FETISH)
        player.actions:tradeNpc('Suibhne', { xi.item.SLIME_FETISH }, { eventId = 15, finishOption = 0 })

        assert(not xi.monstrosity.hasUnlockedSpecies(player, xi.monstrositySpecies.ASTOLTIAN_SLIME), 'declining unlocked Astoltian Slime')
        assert(player:hasItem(xi.item.SLIME_FETISH), 'declining took the Slime Fetish')
    end)

    it('starts no event for a family already unlocked', function()
        xi.monstrosity.unlockSpecies(player, xi.monstrositySpecies.ASTOLTIAN_SLIME)
        player:addItem(xi.item.SLIME_FETISH)
        player.actions:tradeNpc('Suibhne', { xi.item.SLIME_FETISH })

        assert(player:hasItem(xi.item.SLIME_FETISH), 'took a Slime Fetish for a family already unlocked')
    end)
end)

-- Grumblix tells the Monstrosity story for 100 gil, replaying the Feretory introduction.
describe('Monstrosity Goblin Footprint', function()
    it('replays the introduction for 100 gil', function()
        local player = helpers.spawnMonipulator(xi.zone.FERETORY)
        player:addGil(100)

        player.actions:tradeNpc('Goblin_Footprint', { { itemId = xi.item.GIL, quantity = 100 } }, { eventId = 0, updates = { 1 }, finishOption = 1 })
        player.events:expect({ eventId = 2, updates = { 1 }, finishOption = 1 })
    end)
end)

-- Retail spawns only the first of each pair of Feretory NPCs. The second holds unused events.
describe('Monstrosity Feretory NPCs', function()
    it('leaves the duplicate NPCs hidden', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.FERETORY })
        assert(player:getZoneID() == xi.zone.FERETORY, 'precondition: the Feretory did not load')

        for _, id in ipairs({ 17944592, 17944594, 17944596, 17944598, 17944600 }) do
            assert(GetNPCByID(id):getStatus() == xi.status.DISAPPEAR, string.format('NPC %d is visible', id))
        end
    end)
end)

-- Changing family keeps every level but loses the exp in progress. A variant keeps it.
describe('Monstrosity species change', function()
    local onyxRabbit = 256 + xi.monstrosityVariant.ONYX_RABBIT
    local humeI      = 0x300 + xi.monstrosityInstinct.HUME_I
    local elvaanI    = 0x300 + xi.monstrosityInstinct.ELVAAN_I
    local taruI      = 0x300 + xi.monstrosityInstinct.TARU_I
    local mithraI    = 0x300 + xi.monstrosityInstinct.MITHRA_I
    local galkaI     = 0x300 + xi.monstrosityInstinct.GALKA_I

    ---@type CClientEntityPair
    local player

    -- 0x102 is rate limited, so each change waits its turn.
    local function changeSpecies(speciesIndex)
        xi.test.world:skipTime(1)
        local packet = ffi.new(string.format('uint8_t[%d]', extendedJobSize))
        packet[0x0A] = 0x01
        packet[0x0C] = bit.band(speciesIndex, 0xFF)
        packet[0x0D] = bit.rshift(speciesIndex, 8)
        player.packets:clear()
        player.packets:send(0x102, packet, assert(ffi.sizeof(packet)))
    end

    local function equipInstincts(ids)
        xi.test.world:skipTime(1)
        local packet = ffi.new(string.format('uint8_t[%d]', extendedJobSize))
        packet[0x0A] = 0x04
        for idx, id in ipairs(ids) do
            packet[0x10 + (idx - 1) * 2] = bit.band(id, 0xFF)
            packet[0x11 + (idx - 1) * 2] = bit.rshift(id, 8)
        end

        player.packets:send(0x102, packet, assert(ffi.sizeof(packet)))
    end

    -- Equipped instincts in the main job 0x044 the change sends back.
    local function equippedCount()
        local count = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x044 and pkt.data[0x05] == 0 then
                count = 0
                for slot = 0, 11 do
                    if pkt.data[0x0C + slot * 2] + pkt.data[0x0D + slot * 2] * 256 ~= 0 then
                        count = count + 1
                    end
                end
            end
        end

        return count
    end

    before_each(function()
        player = helpers.spawnMonipulator(xi.zone.FERETORY)

        -- setLevel leaves the bar one short, so one point rolls to 11 with an empty bar.
        player:setLevel(10)
        player:addExp(1)
        player:addExp(250)
    end)

    it('keeps the level but loses the exp in progress when changing family', function()
        changeSpecies(xi.monstrositySpecies.LIZARD)
        assert(player:getMainLvl() == 1, string.format('Lizard is level %d', player:getMainLvl()))
        assert(helpers.currentExp(player) == 0, string.format('Lizard has %s exp', tostring(helpers.currentExp(player))))

        changeSpecies(xi.monstrositySpecies.RABBIT)
        assert(player:getMainLvl() == 11, string.format('Rabbit came back as level %d', player:getMainLvl()))

        -- 0x067 carries the level the status window heads its exp box with.
        local syncLevel = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x067 and pkt.data[0x04] == 0x02 then
                syncLevel = pkt.data[0x25]
            end
        end

        assert(syncLevel == 11, string.format('0x067 level was %s', tostring(syncLevel)))
        assert(player:getSubLvl() == 11, string.format('Rabbit sub job came back as level %d', player:getSubLvl()))
        assert(helpers.currentExp(player) == 0, string.format('Rabbit kept %s exp', tostring(helpers.currentExp(player))))
    end)

    it('keeps the exp in progress when changing to a variant of the same family', function()
        xi.monstrosity.unlockVariant(player, xi.monstrosityVariant.ONYX_RABBIT)

        changeSpecies(onyxRabbit)
        assert(player:getMainLvl() == 11, string.format('Onyx Rabbit is level %d', player:getMainLvl()))
        assert(helpers.currentExp(player) == 250, string.format('Onyx Rabbit has %s exp', tostring(helpers.currentExp(player))))
    end)

    -- Retail keeps race instincts equipped through a family change.
    it('keeps equipped instincts the new species can afford', function()
        equipInstincts({ humeI, elvaanI })
        changeSpecies(xi.monstrositySpecies.LIZARD)

        assert(equippedCount() == 2, string.format('%s instincts survived', tostring(equippedCount())))
    end)

    it('drops equipped instincts the new species cannot afford', function()
        equipInstincts({ humeI, elvaanI, taruI, mithraI, galkaI })
        changeSpecies(xi.monstrositySpecies.LIZARD)

        assert(equippedCount() == 0, string.format('%s instincts survived', tostring(equippedCount())))
    end)

    -- Job instincts cost 15 each. A level 11 Mon can spend 21, an NM under Belligerency 41.
    describe('under rank', function()
        local warInstinct = 0x300 + xi.monstrosityInstinct.WAR
        local mnkInstinct = 0x300 + xi.monstrosityInstinct.MNK

        before_each(function()
            local data = player:getMonstrosityData()
            data.instincts[21] = bit.bor(data.instincts[21], 0x0C) -- WAR and MNK are bits 10 and 11
            player:setMonstrosityData(data)
            player:addCurrency('infamy', 15000)
        end)

        it('refuses instincts over level plus 10 without Belligerency', function()
            player.packets:clear()
            equipInstincts({ warInstinct, mnkInstinct })

            assert(player:getMod(xi.mod.STR) == 0, 'the NM bonus applied without Belligerency')
        end)

        it('allows level plus 30 as an NM under Belligerency', function()
            player:setBelligerencyFlag(true)
            player.packets:clear()
            equipInstincts({ warInstinct, mnkInstinct })

            assert(equippedCount() == 2, string.format('%s instincts equipped', tostring(equippedCount())))
            assert(player:getMod(xi.mod.STR) == 10, string.format('STR mod is %d', player:getMod(xi.mod.STR)))
        end)

        it('unequips the overflow on withdrawing from Belligerency', function()
            player:setBelligerencyFlag(true)
            equipInstincts({ warInstinct, mnkInstinct })
            player.packets:clear()
            player:setBelligerencyFlag(false)

            assert(equippedCount() == 0, string.format('%s instincts survived', tostring(equippedCount())))
            assert(player:getMod(xi.mod.STR) == 0, string.format('STR mod is %d', player:getMod(xi.mod.STR)))
        end)

        it('unequips the overflow on spending infamy below NM', function()
            player:setBelligerencyFlag(true)
            equipInstincts({ warInstinct, mnkInstinct })
            player.packets:clear()
            player:delCurrency('infamy', 5000)

            assert(equippedCount() == 0, string.format('%s instincts survived', tostring(equippedCount())))
            assert(player:getMod(xi.mod.STR) == 0, string.format('STR mod is %d', player:getMod(xi.mod.STR)))
        end)
    end)

    -- JP wiki: Teyrnon's buffs are lost on a species change. Medicated survives.
    it('loses buffs but keeps Medicated on a variant change', function()
        xi.monstrosity.unlockVariant(player, xi.monstrosityVariant.ONYX_RABBIT)
        player:addStatusEffect(xi.effect.REGEN, { power = 1, duration = 3600, origin = player, tick = 3 })
        player:addStatusEffect(xi.effect.MEDICINE, { power = 1, duration = 3600, origin = player })

        changeSpecies(onyxRabbit)

        assert(not player:hasStatusEffect(xi.effect.REGEN), 'Regen survived the species change')
        player.assert:hasEffect(xi.effect.MEDICINE)
    end)

    it('keeps buffs when the current species is picked again', function()
        player:addStatusEffect(xi.effect.REGEN, { power = 1, duration = 3600, origin = player, tick = 3 })

        changeSpecies(xi.monstrositySpecies.RABBIT)

        player.assert:hasEffect(xi.effect.REGEN)
    end)

    -- Level instinct I is the family times 3, owned from level 30.
    it('applies spell interruption down from Coeurl instinct I', function()
        local data = player:getMonstrosityData()
        data.levels[xi.monstrositySpecies.COEURL] = 30
        player:setMonstrosityData(data)
        player:gotoZone(xi.zone.FERETORY)

        equipInstincts({ xi.monstrositySpecies.COEURL * 3 })

        assert(player:getMod(xi.mod.SPELLINTERRUPT) == 15, string.format('SPELLINTERRUPT is %d', player:getMod(xi.mod.SPELLINTERRUPT)))
    end)

    -- Retail scales instinct HP by the species: a level 2 Toad (scale 190) with Crab instinct I (HP+200).
    it('scales instinct HP by the species', function()
        local data = player:getMonstrosityData()
        data.monstrosityId = xi.monstrositySpecies.TOAD
        data.species       = xi.monstrositySpecies.TOAD
        data.levels[xi.monstrositySpecies.TOAD] = 2
        data.levels[xi.monstrositySpecies.CRAB] = 30
        player:setMonstrosityData(data)
        player:gotoZone(xi.zone.FERETORY)
        assert(player:getMaxHP() == 95, string.format('precondition: a level 2 Toad has %d HP', player:getMaxHP()))

        equipInstincts({ xi.monstrositySpecies.CRAB * 3 })

        assert(player:getMaxHP() == 475, string.format('max HP is %d', player:getMaxHP()))
    end)

    it('swaps instinct mods when a slot is replaced or resent', function()
        -- Hume I has CHR+2 among others
        equipInstincts({ humeI })
        equipInstincts({ humeI })
        assert(player:getMod(xi.mod.CHR) == 2, string.format('CHR mod is %d after resending', player:getMod(xi.mod.CHR)))

        -- Elvaan I has STR+3 and MND+3
        equipInstincts({ elvaanI })
        assert(player:getMod(xi.mod.CHR) == 0, string.format('CHR mod is %d after replacing', player:getMod(xi.mod.CHR)))
        assert(player:getMod(xi.mod.STR) == 3, string.format('STR mod is %d after replacing', player:getMod(xi.mod.STR)))
    end)

    it('ignores an extended job packet that changes nothing', function()
        local packet = ffi.new(string.format('uint8_t[%d]', extendedJobSize))
        player.packets:clear()
        player.packets:send(0x102, packet, assert(ffi.sizeof(packet)))

        assert(#player.packets:getIncoming() == 0, string.format('answered with %d packets', #player.packets:getIncoming()))
    end)

    -- Stats come from the species' jobs, so a change has to send what a zone-in would.
    it('recalculates stats on a species change', function()
        local function stats()
            for _, pkt in pairs(player.packets:getIncoming()) do
                if pkt.type == 0x061 then
                    local values = {}
                    for idx = 0x14, 0x21 do
                        table.insert(values, pkt.data[idx])
                    end

                    return table.concat(values, ',')
                end
            end
        end

        changeSpecies(xi.monstrositySpecies.MANDRAGORA)
        local afterChange = stats()

        player:gotoZone(xi.zone.FERETORY)
        player.packets:clear()
        helpers.sendGameOk(player)

        assert(afterChange == stats(), string.format('stats after the change %s, after zoning %s', afterChange, stats()))
    end)
end)
