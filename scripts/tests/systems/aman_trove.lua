-----------------------------------
-- A.M.A.N. Trove
-----------------------------------
local ffi = require('ffi')
-----------------------------------

local exploringTheTrove = 1447
local mimicModel        = 258
local goldModel         = 969
local rainbowModel      = 2426

local function getChests(battlefield, name)
    local chests = {}
    for _, mob in ipairs(battlefield:getMobs(true, true)) do
        if mob:getName() == name then
            table.insert(chests, mob)
        end
    end

    return chests
end

-- The Terminal Coffer of the player's arena, found by position so a wrong id lookup can't pass.
local function getArenaCoffer(battlefield, chest, zoneId)
    for _, cofferId in ipairs(zones[zoneId].npc.TERMINAL_COFFERS) do
        local coffer = GetNPCByID(cofferId)
        if
            coffer and
            coffer:checkDistance(chest) < 15 and
            coffer:getStatus() == xi.status.NORMAL
        then
            return coffer
        end
    end

    return nil
end

-- Takes a Records of Eminence objective the way the client does.
local function takeRecord(player, recordId)
    local packet = ffi.new('uint8_t[8]')
    packet[4] = bit.band(recordId, 0xFF)
    packet[5] = bit.rshift(recordId, 8)
    player.packets:send(0x10C, packet, ffi.sizeof(packet))
end

describe('A.M.A.N. Trove', function()
    local enabled

    setup(function()
        enabled = xi.settings.main.ENABLE_AMAN_TROVE
        xi.settings.main.ENABLE_AMAN_TROVE = 1
    end)

    teardown(function()
        xi.settings.main.ENABLE_AMAN_TROVE = enabled
    end)

    describe('Greyson', function()
        ---@type CClientEntityPair
        local player
        local ageDays

        before_each(function()
            player  = xi.test.world:spawnPlayer({ zone = xi.zone.LOWER_JEUNO, job = xi.job.WAR, level = 99 })
            ageDays = 46

            local created = player:getTimeCreated()
            stub('GetSystemTime', function()
                return created + ageDays * 86400
            end)
        end)

        it('turns away a character below level 99', function()
            takeRecord(player, exploringTheTrove)
            player:setLevel(75)
            player.entities:gotoAndTrigger('Greyson', { eventId = 20082 })
        end)

        it('turns away a character younger than 45 days', function()
            ageDays = 10
            player.entities:gotoAndTrigger('Greyson')
            player.events:expectNotInEvent()
        end)

        it('turns away a character without Exploring the Trove', function()
            player.entities:gotoAndTrigger('Greyson', { eventId = 20082 })
        end)

        it('completes Exploring the Trove after the intro', function()
            takeRecord(player, exploringTheTrove)
            player.entities:gotoAndTrigger('Greyson', { eventId = 20083 })
            assert(player:getEminenceCompleted(exploringTheTrove), 'record was not completed')
        end)

        describe('once the record is complete', function()
            before_each(function()
                player:setEminenceCompleted(exploringTheTrove)
            end)

            it('completes the monthly record and gives a Mars Orb on talking', function()
                takeRecord(player, 3768)
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084 })
                assert(player:getEminenceCompleted(3768), 'monthly record was not completed')
                player.assert:hasItem(xi.item.MARS_ORB)
            end)

            it('stores traded silver vouchers', function()
                player:addItem(xi.item.SILVER_AMAN_VOUCHER, 3)
                player.actions:tradeNpc('Greyson', { { itemId = xi.item.SILVER_AMAN_VOUCHER, quantity = 3 } }, { eventId = 20085 })
                assert(player:getCurrency('silver_aman_voucher') == 3, 'vouchers were not stored')
                player.assert.no:hasItem(xi.item.SILVER_AMAN_VOUCHER)
            end)

            it('exchanges 10 vouchers for a Venus Orb', function()
                player:addCurrency('silver_aman_voucher', 12)
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084, finishOption = 2 })
                player.assert:hasItem(xi.item.VENUS_ORB)
                assert(player:getCurrency('silver_aman_voucher') == 2, 'wrong number of vouchers taken')
            end)

            it('gives no orb when vouchers run short', function()
                player:addCurrency('silver_aman_voucher', 5)
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084, finishOption = 1 })
                player.assert.no:hasItem(xi.item.MARS_ORB)
                assert(player:getCurrency('silver_aman_voucher') == 5, 'vouchers were taken')
            end)

            it('sells at most 5 vouchers a month', function()
                player:addGil(1000000)
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084, finishOption = 3 })
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084, finishOption = 4 })
                player.entities:gotoAndTrigger('Greyson', { eventId = 20084, finishOption = 3 })
                assert(player:getCurrency('silver_aman_voucher') == 5, 'wrong number of vouchers sold')
                player.assert:hasGil(500000)
            end)

            it('swaps a used orb for a reward', function()
                player:addItem(xi.item.MARS_ORB)
                assert(player:incrementItemWear(xi.item.MARS_ORB) == 1, 'the orb did not wear')
                player.actions:tradeNpc('Greyson', { xi.item.MARS_ORB })

                local rewarded = false
                for _, itemId in ipairs({ xi.item.SPECIAL_GOBBIEDIAL_KEY, xi.item.COPPER_AMAN_VOUCHER, xi.item.BOTTLE_OF_ORANGE_JUICE, xi.item.BOTTLE_OF_APPLE_JUICE }) do
                    rewarded = rewarded or player:hasItem(itemId)
                end

                -- A fresh orb is one of the rewards, so a held orb must be unused.
                rewarded = rewarded or (player:hasItem(xi.item.MARS_ORB) and player:getWornUses(xi.item.MARS_ORB) == 0)
                assert(rewarded, 'no reward for the used orb')
            end)

            it('keeps an orb that has not been used', function()
                player:addItem(xi.item.MARS_ORB)
                player.actions:tradeNpc('Greyson', { xi.item.MARS_ORB })
                player.assert:hasItem(xi.item.MARS_ORB)
                assert(player:getWornUses(xi.item.MARS_ORB) == 0, 'the unused orb was worn')
            end)
        end)
    end)

    describe('Monthly records', function()
        local hello = string.char(0xFD, 0x02, 0x02, 0x01, 0x0B, 0xFD)

        ---@type CClientEntityPair
        local player

        before_each(function()
            player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA, job = xi.job.WAR, level = 99 })
            player:setNation(xi.nation.SANDORIA)
        end)

        after_each(function()
            xi.settings.main.ENABLE_AMAN_TROVE = 1
        end)

        it('completes Examine a Home Point in the home nation', function()
            takeRecord(player, 3769)
            player.entities:gotoAndTrigger('HomePoint#1', { eventId = 8700 })

            assert(player:getEminenceCompleted(3769), 'record was not completed')
            player.assert:hasItem(xi.item.SILVER_AMAN_VOUCHER)
        end)

        it('ignores a home point outside the home nation', function()
            player:setNation(xi.nation.BASTOK)
            takeRecord(player, 3769)
            player.entities:gotoAndTrigger('HomePoint#1', { eventId = 8700 })

            assert(not player:getEminenceCompleted(3769), 'record was completed')
        end)

        it('pays nothing while A.M.A.N. Trove is disabled', function()
            xi.settings.main.ENABLE_AMAN_TROVE = 0
            takeRecord(player, 3769)
            player.entities:gotoAndTrigger('HomePoint#1', { eventId = 8700 })

            assert(not player:getEminenceCompleted(3769), 'record was completed')
            player.assert.no:hasItem(xi.item.SILVER_AMAN_VOUCHER)
        end)

        it('completes Auction an Item on a listing', function()
            takeRecord(player, 3770)
            player:triggerRoeEvent(xi.roeTrigger.AUCTION_LISTING, { itemid = xi.item.AMBER_STONE })

            assert(player:getEminenceCompleted(3770), 'record was not completed')
        end)

        it('completes Unity Chat Greetings only for the auto-translated greeting', function()
            takeRecord(player, 3771)
            player:triggerRoeEvent(xi.roeTrigger.UNITY_CHAT, { unityMessage = 'Hello!' })
            assert(not player:getEminenceCompleted(3771), 'plain text completed the record')

            player:triggerRoeEvent(xi.roeTrigger.UNITY_CHAT, { unityMessage = hello })
            assert(player:getEminenceCompleted(3771), 'record was not completed')
        end)

        it('counts Conquest Participation kills only in conquest regions', function()
            takeRecord(player, 3772)

            player:triggerRoeEvent(xi.roeTrigger.DEFEAT_MOB)
            assert(player:getEminenceProgress(3772) == 0, 'a kill outside a conquest region counted')

            player:gotoZone(xi.zone.WEST_RONFAURE)
            for _ = 1, 30 do
                player:triggerRoeEvent(xi.roeTrigger.DEFEAT_MOB)
            end

            assert(player:getEminenceCompleted(3772), 'record was not completed')
        end)

        it('clears on the first of the JST month only', function()
            player:setEminenceCompleted(3768)

            for _ = 1, 32 do
                xi.test.world:tick(xi.tick.JST_DAY)
                if JstDayOfTheMonth() == 1 then
                    break
                end

                assert(player:getEminenceCompleted(3768), 'monthly record cleared before the first of the month')
            end

            assert(not player:getEminenceCompleted(3768), 'monthly record is still complete')
        end)
    end)

    describe('Mars Orb battlefield', function()
        ---@type CClientEntityPair
        local player

        before_each(function()
            player = xi.test.world:spawnPlayer({ zone = xi.zone.BALGAS_DAIS, job = xi.job.WAR, level = 99 })
            player:addItem(xi.item.MARS_ORB)
            player.bcnm:enter('BC_Entrance', xi.battlefield.id.AMAN_TROVE_MARS_BALGAS_DAIS, { xi.item.MARS_ORB })
        end)

        -- The next case reuses the character id, so the arena must be gone before it starts.
        after_each(function()
            local battlefield = assert(player:getBattlefield())
            if battlefield then
                battlefield:cleanup(true)
            end

            xi.test.world:tick()
        end)

        it('spawns ten chests with one mimic among them', function()
            local battlefield = assert(player:getBattlefield())
            local chests      = getChests(battlefield, 'Chest_OPlenty')
            local mimicId     = battlefield:getLocalVar('MimicId')

            assert(#chests == 10, string.format('expected 10 chests, found %d', #chests))

            local found = false
            for _, chest in ipairs(chests) do
                found = found or chest:getID() == mimicId
            end

            assert(found, 'the mimic is not one of the chests')
        end)

        it('pays one item per chest plus one from the Terminal Coffer', function()
            local battlefield = assert(player:getBattlefield())
            local chests      = getChests(battlefield, 'Chest_OPlenty')
            local mimicId     = battlefield:getLocalVar('MimicId')

            local opened = 0
            for _, chest in ipairs(chests) do
                if
                    opened < 2 and
                    chest:getID() ~= mimicId
                then
                    player.entities:gotoAndTrigger(chest)
                    opened = opened + 1
                end
            end

            assert(battlefield:getLocalVar('SpoilsCount') == 2, 'each chest should add one item')

            local cofferId = zones[xi.zone.BALGAS_DAIS].npc.TERMINAL_COFFERS[battlefield:getArea()]
            player.entities:gotoAndTrigger(assert(GetNPCByID(cofferId)))
            assert(battlefield:getLocalVar('SpoilsCount') == 3, 'the coffer should add its own item')

            -- The win waits out a few battlefield ticks.
            for _ = 1, 5 do
                xi.test.world:skipTime(1)
            end

            player.bcnm:expectWin()
        end)

        it('uses up Reraise instead of K.O. with Ka-thwack', function()
            local battlefield = assert(player:getBattlefield())
            local mimic       = assert(GetMobByID(battlefield:getLocalVar('MimicId')))

            -- The captured Ka-thwack damage would kill a naked character outright.
            player:addMod(xi.mod.HP, 10000)
            player:updateHealth()
            player:setHP(player:getMaxHP())
            player:addStatusEffect(xi.effect.RERAISE, { power = 1, duration = 3600, origin = player })
            player.entities:gotoAndTrigger(mimic)

            -- Ka-thwack takes a few seconds to ready and land.
            for _ = 1, 6 do
                xi.test.world:skipTime(1)
            end

            assert(not player:isDead(), 'Ka-thwack ignored Reraise')
            player.assert.no:hasEffect(xi.effect.RERAISE)
        end)

        it('hides the Terminal Coffer when the mimic is revealed', function()
            local battlefield = assert(player:getBattlefield())
            local mimic       = assert(GetMobByID(battlefield:getLocalVar('MimicId')))
            local coffer      = assert(GetNPCByID(zones[xi.zone.BALGAS_DAIS].npc.TERMINAL_COFFERS[battlefield:getArea()]))

            player.entities:gotoAndTrigger(mimic)

            assert(mimic:getModelId() == mimicModel, 'the chest did not turn into a mimic')
            assert(coffer:getStatus() == xi.status.DISAPPEAR, 'the coffer is still there')
        end)

        it('restores every chest for the next run in the same arena', function()
            local battlefield = assert(player:getBattlefield())
            local area        = battlefield:getArea()
            local mimic       = assert(GetMobByID(battlefield:getLocalVar('MimicId')))

            player.entities:gotoAndTrigger(mimic)
            battlefield:cleanup(true)
            xi.test.world:tick()
            player.events:expect({ eventId = 32002 })

            -- An empty battlefield is destroyed after a 10 second grace.
            for _ = 1, 3 do
                xi.test.world:skipTime(11)
                xi.test.world:tick()
            end

            -- The cracked orb is Rare, so it has to go before a fresh one fits.
            player:delItem(xi.item.MARS_ORB, 1)
            player:addItem(xi.item.MARS_ORB)
            player.bcnm:enter('BC_Entrance', xi.battlefield.id.AMAN_TROVE_MARS_BALGAS_DAIS, { xi.item.MARS_ORB })
            battlefield = assert(player:getBattlefield())
            assert(battlefield:getArea() == area, 'the second run used another arena')

            for _, chest in ipairs(getChests(battlefield, 'Chest_OPlenty')) do
                assert(chest:getModelId() ~= mimicModel, string.format('chest %d still looks like the mimic', chest:getID()))
            end
        end)

        it('brings the Terminal Coffer back when the mimic dies', function()
            local battlefield = assert(player:getBattlefield())
            local mimic       = assert(GetMobByID(battlefield:getLocalVar('MimicId')))
            local coffer      = assert(GetNPCByID(zones[xi.zone.BALGAS_DAIS].npc.TERMINAL_COFFERS[battlefield:getArea()]))

            player.entities:gotoAndTrigger(mimic)
            player:claimAndKillMob(mimic)
            assert(coffer:getStatus() == xi.status.NORMAL, 'the coffer did not come back')

            player.entities:gotoAndTrigger(coffer)
            for _ = 1, 5 do
                xi.test.world:skipTime(1)
            end

            player.bcnm:expectWin()
        end)

        it('meets every Ka-thwack again after the mimic disengages', function()
            local battlefield = assert(player:getBattlefield())
            local mimic       = assert(GetMobByID(battlefield:getLocalVar('MimicId')))

            player.entities:gotoAndTrigger(mimic)
            xi.test.world:tick()
            assert(mimic:isEngaged(), 'the mimic never engaged')

            mimic:setLocalVar('KaThwackStage', 2)
            mimic:disengage()
            xi.test.world:tick()

            assert(mimic:getLocalVar('KaThwackStage') == 0, 'the Ka-thwack stages carried over')
        end)

        it('springs the mimic when any chest is engaged without a click', function()
            local battlefield = assert(player:getBattlefield())
            local mimic       = assert(GetMobByID(battlefield:getLocalVar('MimicId')))
            local coffer      = assert(GetNPCByID(zones[xi.zone.BALGAS_DAIS].npc.TERMINAL_COFFERS[battlefield:getArea()]))
            local plain

            for _, chest in ipairs(getChests(battlefield, 'Chest_OPlenty')) do
                if chest:getID() ~= mimic:getID() then
                    plain = chest
                    break
                end
            end

            -- As if a client had found a way round the targeting checks.
            plain:setAllegiance(xi.allegiance.MOB)
            plain:updateEnmity(player)
            xi.test.world:tick()

            assert(mimic:getModelId() == mimicModel, 'the mimic did not spring')
            assert(mimic:isEngaged(), 'the mimic is not fighting')
            assert(plain:getLocalVar('opened') == 1, 'the engaged chest stayed')
            assert(coffer:getStatus() == xi.status.DISAPPEAR, 'the coffer is still there')
        end)

        it('keeps area spells off the chests', function()
            local battlefield = assert(player:getBattlefield())
            local zone        = GetZone(xi.zone.BALGAS_DAIS)
            local chest       = getChests(battlefield, 'Chest_OPlenty')[3]
            local x           = chest:getXPos()
            local y           = chest:getYPos()
            local z           = chest:getZPos()
            assert(zone, 'zone not loaded')

            -- Half a yalm from a chest, so Firaga's area covers it.
            local dummy = zone:insertDynamicEntity({
                objtype              = xi.objType.MOB,
                name                 = 'Trove_Dummy',
                x                    = x,
                y                    = y,
                z                    = z - 0.5,
                rotation             = 0,
                groupId              = 5,
                groupZoneId          = 154,
                minLevel             = 1,
                maxLevel             = 1,
                releaseIdOnDisappear = true,
            })
            assert(dummy, 'failed to insert the dummy')

            dummy:spawn()
            battlefield:insertEntity(dummy:getTargID(), false, true)
            xi.test.world:tick()

            player:changeJob(xi.job.BLM)
            player:setLevel(99)
            player:addSpell(xi.magic.spell.FIRAGA)
            player:setMP(9999)
            player:setPos(x, y, z - 8)
            player.actions:useSpell(dummy, xi.magic.spell.FIRAGA)

            for _ = 1, 8 do
                xi.test.world:skipTime(1)
            end

            assert(dummy:isDead() or dummy:getHP() < dummy:getMaxHP(), 'Firaga never hit the dummy')
            for _, entry in ipairs(getChests(battlefield, 'Chest_OPlenty')) do
                assert(entry:getHP() == entry:getMaxHP(), string.format('Firaga hit chest %d', entry:getID()))
                assert(entry:getModelId() ~= mimicModel, string.format('chest %d turned into the mimic', entry:getID()))
            end
        end)

        it('keeps area heals and buffs off the chests', function()
            local battlefield = assert(player:getBattlefield())
            local chests      = getChests(battlefield, 'Chest_OPlenty')
            local chest       = chests[3]

            -- A heal only shows on a chest that has lost HP and can't regain it by resting.
            for _, entry in ipairs(chests) do
                entry:setMobMod(xi.mobMod.NO_REST, 1)
                entry:setHP(entry:getMaxHP() - 1000)
            end

            player:changeJob(xi.job.WHM)
            player:setLevel(99)
            player:addSpell(xi.magic.spell.CURAGA)
            player:addSpell(xi.magic.spell.PROTECTRA)
            player:setMP(9999)
            player:setPos(chest:getXPos(), chest:getYPos(), chest:getZPos() - 1)

            for _, spellId in ipairs({ xi.magic.spell.CURAGA, xi.magic.spell.PROTECTRA }) do
                player.actions:useSpell(player, spellId)
                for _ = 1, 8 do
                    xi.test.world:skipTime(1)
                end
            end

            player.assert:hasEffect(xi.effect.PROTECT)
            for _, entry in ipairs(chests) do
                assert(entry:getHP() == entry:getMaxHP() - 1000, string.format('Curaga healed chest %d', entry:getID()))
                assert(not entry:hasStatusEffect(xi.effect.PROTECT), string.format('Protectra buffed chest %d', entry:getID()))
                assert(not entry:isEngaged(), string.format('chest %d was engaged', entry:getID()))
                assert(entry:getModelId() ~= mimicModel, string.format('chest %d turned into the mimic', entry:getID()))
            end
        end)

        it('ignores attacks on any chest, the mimic included', function()
            local battlefield = assert(player:getBattlefield())
            local mimic       = assert(GetMobByID(battlefield:getLocalVar('MimicId')))
            local plain

            for _, chest in ipairs(getChests(battlefield, 'Chest_OPlenty')) do
                if chest:getID() ~= mimic:getID() then
                    plain = chest
                    break
                end
            end

            for _, chest in ipairs({ mimic, plain }) do
                player.actions:engage(chest)
                for _ = 1, 5 do
                    xi.test.world:skipTime(1)
                end

                assert(not player:isEngaged(), string.format('the player engaged chest %d', chest:getID()))
                assert(not chest:isEngaged(), string.format('chest %d was engaged', chest:getID()))
                assert(chest:getModelId() ~= mimicModel, string.format('chest %d turned into the mimic', chest:getID()))
            end
        end)
    end)

    describe('Venus Orb battlefield', function()
        ---@type CClientEntityPair
        local player

        before_each(function()
            player = xi.test.world:spawnPlayer({ zone = xi.zone.BALGAS_DAIS, job = xi.job.WAR, level = 99 })
            player:addItem(xi.item.VENUS_ORB)
            player.bcnm:enter('BC_Entrance', xi.battlefield.id.AMAN_TROVE_VENUS_BALGAS_DAIS, { xi.item.VENUS_ORB })
        end)

        after_each(function()
            local battlefield = assert(player:getBattlefield())
            if battlefield then
                battlefield:cleanup(true)
            end

            xi.test.world:tick()
        end)

        it('uses its own coffer, which pays a thud or better', function()
            local battlefield = assert(player:getBattlefield())
            local chests      = getChests(battlefield, 'Coffer_OPlenty')
            local coffer      = getArenaCoffer(battlefield, chests[1], xi.zone.BALGAS_DAIS)

            assert(#chests == 10, string.format('expected 10 chests, found %d', #chests))
            assert(coffer, 'no Terminal Coffer showed in this arena')

            player.entities:gotoAndTrigger(coffer)
            assert(battlefield:getLocalVar('SpoilsTier1') >= 2, 'the Venus coffer paid less than a thud')
        end)

        it('always upgrades the last good chest', function()
            local battlefield = assert(player:getBattlefield())
            local mimicId     = battlefield:getLocalVar('MimicId')
            local chests      = getChests(battlefield, 'Coffer_OPlenty')
            local opened      = 0

            for _, chest in ipairs(chests) do
                if
                    opened < #chests - 2 and
                    chest:getID() ~= mimicId
                then
                    player.entities:gotoAndTrigger(chest)
                    opened = opened + 1
                end
            end

            for _, chest in ipairs(chests) do
                if
                    chest:getLocalVar('opened') == 0 and
                    chest:getID() ~= mimicId
                then
                    local model = chest:getModelId()
                    assert(model == goldModel or model == rainbowModel, string.format('the last good chest kept model %d', model))
                end
            end
        end)
    end)

    describe('Chest rolls', function()
        it('follow the captured tier weights for each orb', function()
            xi.test.world:setSeed(1)

            -- A fixed order, so each orb always draws the same part of the seeded stream.
            for _, name in ipairs({ 'MARS', 'VENUS' }) do
                local orb    = xi.amanTrove.orbs[name]
                local counts = {}
                local total  = 0
                for _, entry in ipairs(orb.tierWeights) do
                    counts[entry.tier] = 0
                    total              = total + entry.weight
                end

                for _ = 1, 10000 do
                    local tier = xi.amanTrove.rollTier(orb, xi.amanTrove.tiers.NOISE)
                    counts[tier] = counts[tier] + 1
                end

                -- Within two percentage points of each weight's share, about 4.5 standard deviations.
                for _, entry in ipairs(orb.tierWeights) do
                    local expected = entry.weight / total * 10000
                    assert(math.abs(counts[entry.tier] - expected) <= 200, string.format('%s tier %d rolled %d times, expected about %d', name, entry.tier, counts[entry.tier], expected))
                end
            end
        end)

        it('never gives the Venus coffer less than a thud', function()
            local orb = xi.amanTrove.orbs.VENUS
            for _ = 1, 1000 do
                assert(xi.amanTrove.rollTier(orb, orb.cofferMinTier) >= xi.amanTrove.tiers.THUD, 'the Venus coffer rolled a noise')
            end
        end)
    end)

    describe('Other arenas', function()
        local arenas =
        {
            { zone = xi.zone.HORLAIS_PEAK,     battlefieldId = xi.battlefield.id.AMAN_TROVE_MARS_HORLAIS_PEAK,      orb = xi.item.MARS_ORB,  chest = 'Chest_OPlenty'  },
            { zone = xi.zone.WAUGHROON_SHRINE, battlefieldId = xi.battlefield.id.AMAN_TROVE_VENUS_WAUGHROON_SHRINE, orb = xi.item.VENUS_ORB, chest = 'Coffer_OPlenty' },
        }

        for _, arena in ipairs(arenas) do
            it(string.format('sets up chests and a coffer in zone %d', arena.zone), function()
                local player = xi.test.world:spawnPlayer({ zone = arena.zone, job = xi.job.WAR, level = 99 })
                player:addItem(arena.orb)
                player.bcnm:enter('BC_Entrance', arena.battlefieldId, { arena.orb })

                local battlefield = assert(player:getBattlefield())
                local chests      = getChests(battlefield, arena.chest)
                assert(#chests == 10, string.format('expected 10 chests, found %d', #chests))
                assert(getArenaCoffer(battlefield, chests[1], arena.zone), 'no Terminal Coffer showed in this arena')

                battlefield:cleanup(true)
                xi.test.world:tick()
            end)
        end
    end)
end)
