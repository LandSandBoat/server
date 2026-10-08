-- Feretory rules, read from data/monstrosity.yaml through the entity bindings.
local ffi = require('ffi')

pcall(ffi.cdef, [[
    typedef struct {
        uint16_t idSize;
        uint16_t sync;
        uint32_t clientState;
        uint32_t debugClientFlg;
    } MONSTROSITY_TEST_GAMEOK;
]])

-- 0x102 for Monstrosity: flags at 0x0A, species at 0x0C, instinct slots from 0x10.
local extendedJobSize = 164

describe('Monstrosity starting state', function()
    ---@type CClientEntityPair
    local player

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.WEST_RONFAURE)
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
        local gameOk = ffi.new('MONSTROSITY_TEST_GAMEOK')
        player.packets:send(0x00C, gameOk, assert(ffi.sizeof(gameOk)))

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
        local gameOk = ffi.new('MONSTROSITY_TEST_GAMEOK')
        player.packets:send(0x00C, gameOk, assert(ffi.sizeof(gameOk)))

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

    it('caps each Belligerency zone at its level', function()
        assert(xi.monstrosity.belligerencyCaps[xi.zone.BUBURIMU_PENINSULA] == 30, 'Buburimu should cap at 30')
        assert(xi.monstrosity.belligerencyCaps[xi.zone.XARCABARD] == 60, 'Xarcabard should cap at 60')
        assert(xi.monstrosity.belligerencyCaps[xi.zone.ULEGUERAND_RANGE] == 90, 'Uleguerand should cap at 90')
        assert(xi.monstrosity.belligerencyCaps[xi.zone.WEST_RONFAURE] == nil, 'other zones have no cap')
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

    it('lists every exit position for a zone', function()
        local exits = player:getMonstrosityExits(xi.zone.EAST_RONFAURE)

        assert(#exits == 2, string.format('East Ronfaure has %d exits', #exits))
        assert(exits[1][1] == 120 and exits[1][3] == -530 and exits[1][4] == 192, 'first exit is wrong')
        assert(#player:getMonstrosityExits(xi.zone.WEST_RONFAURE) == 0, 'West Ronfaure has no exits')
    end)
end)

-- Teyrnon's event reports a purchase as optionType 1, the page plus one in bits 8-11 and
-- the slot from bit 16.
describe('Monstrosity Teyrnon shop', function()
    ---@type CClientEntityPair
    local player

    local function buy(page, slot)
        xi.monstrosity.teyrnonOnEventFinish(player, 0, 1 + bit.lshift(page + 1, 8) + bit.lshift(slot, 16))
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.FERETORY })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.FERETORY)
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

    -- A benediction is optionType 3 with the effect from bit 8. Costs are fixed in the client event.
    local benedictions =
    {
        { name = 'Dedication 1', option = 0, effect = xi.effect.DEDICATION, cost = 3000 },
        { name = 'Dedication 2', option = 1, effect = xi.effect.DEDICATION, cost =  400 },
        { name = 'Regen',        option = 2, effect = xi.effect.REGEN,      cost =   10 },
        { name = 'Refresh',      option = 3, effect = xi.effect.REFRESH,    cost =   10 },
        { name = 'Protect',      option = 4, effect = xi.effect.PROTECT,    cost =  100 },
        { name = 'Shell',        option = 5, effect = xi.effect.SHELL,      cost =  100 },
        { name = 'Haste',        option = 6, effect = xi.effect.HASTE,      cost =  100 },
    }

    for _, benediction in ipairs(benedictions) do
        it(string.format('casts %s for %d infamy', benediction.name, benediction.cost), function()
            player:addCurrency('infamy', 5000)
            xi.monstrosity.teyrnonOnEventFinish(player, 7, 3 + bit.lshift(benediction.option, 8))

            player.assert:hasEffect(benediction.effect)
            assert(player:getCurrency('infamy') == 5000 - benediction.cost, string.format('%d infamy left', player:getCurrency('infamy')))
        end)
    end

    it('casts no benediction the player cannot afford', function()
        player:addCurrency('infamy', 99)
        xi.monstrosity.teyrnonOnEventFinish(player, 7, 3 + bit.lshift(6, 8))

        assert(not player:hasStatusEffect(xi.effect.HASTE), 'Haste was cast for 99 infamy')
        assert(player:getCurrency('infamy') == 99, 'infamy should be untouched')
    end)

    it('casts nothing for an unknown benediction', function()
        player:addCurrency('infamy', 1000)
        xi.monstrosity.teyrnonOnEventFinish(player, 7, 3 + bit.lshift(7, 8))

        assert(player:getCurrency('infamy') == 1000, 'infamy should be untouched')
    end)

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
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.FERETORY })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.FERETORY)
    end)

    it('toggles Belligerency', function()
        xi.monstrosity.aengusOnEventFinish(player, 13, 1)
        assert(player:getBelligerencyFlag(), 'Belligerency should be on')

        xi.monstrosity.aengusOnEventFinish(player, 13, 1)
        assert(not player:getBelligerencyFlag(), 'Belligerency should be off')
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
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.FERETORY })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.FERETORY)

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
end)

-- Changing family keeps every level but loses the exp in progress. A variant keeps it.
describe('Monstrosity species change', function()
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

    -- exp_now in the CLISTATUS the change sends back.
    local function currentExp()
        local exp = nil
        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x061 then
                exp = pkt.data[0x10] + pkt.data[0x11] * 256
            end
        end

        return exp
    end

    before_each(function()
        xi.test.world:setSetting('main.ENABLE_MONSTROSITY', 1)
        player = xi.test.world:spawnPlayer({ zone = xi.zone.FERETORY })
        player:changeJob(xi.job.MON)
        player:gotoZone(xi.zone.FERETORY)

        -- setLevel leaves the bar one short, so one point rolls to 11 with an empty bar.
        player:setLevel(10)
        player:addExp(1)
        player:addExp(250)
    end)

    it('keeps the level but loses the exp in progress when changing family', function()
        changeSpecies(xi.monstrositySpecies.LIZARD)
        assert(player:getMainLvl() == 1, string.format('Lizard is level %d', player:getMainLvl()))
        assert(currentExp() == 0, string.format('Lizard has %s exp', tostring(currentExp())))

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
        assert(currentExp() == 0, string.format('Rabbit kept %s exp', tostring(currentExp())))
    end)

    it('keeps the exp in progress when changing to a variant of the same family', function()
        xi.monstrosity.unlockVariant(player, xi.monstrosityVariant.ONYX_RABBIT)

        changeSpecies(256 + xi.monstrosityVariant.ONYX_RABBIT)
        assert(player:getMainLvl() == 11, string.format('Onyx Rabbit is level %d', player:getMainLvl()))
        assert(currentExp() == 250, string.format('Onyx Rabbit has %s exp', tostring(currentExp())))
    end)

    -- Retail keeps race instincts equipped through a family change.
    it('keeps equipped instincts the new species can afford', function()
        equipInstincts({ 768, 769 })
        changeSpecies(xi.monstrositySpecies.LIZARD)

        assert(equippedCount() == 2, string.format('%s instincts survived', tostring(equippedCount())))
    end)

    it('drops equipped instincts the new species cannot afford', function()
        equipInstincts({ 768, 769, 770, 771, 772 })
        changeSpecies(xi.monstrositySpecies.LIZARD)

        assert(equippedCount() == 0, string.format('%s instincts survived', tostring(equippedCount())))
    end)

    it('swaps instinct mods when a slot is replaced or resent', function()
        -- Hume I: CHR+2 among others
        equipInstincts({ 768 })
        equipInstincts({ 768 })
        assert(player:getMod(xi.mod.CHR) == 2, string.format('CHR mod is %d after resending', player:getMod(xi.mod.CHR)))

        -- Elvaan I: STR+3 MND+3
        equipInstincts({ 769 })
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
        local gameOk = ffi.new('MONSTROSITY_TEST_GAMEOK')
        player.packets:send(0x00C, gameOk, assert(ffi.sizeof(gameOk)))

        assert(afterChange == stats(), string.format('stats after the change %s, after zoning %s', afterChange, stats()))
    end)
end)
