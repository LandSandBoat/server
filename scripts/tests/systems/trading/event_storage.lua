describe('Event Storage NPCs', function()
    ---@type CClientEntityPair
    local player

    -- Garridan in Port Jeuno. Every storage NPC runs the same logic behind its own event ids.
    local storeEventId = 307
    local menuEventId  = 308

    -- The Moogle Cap is the thirteenth head slot, so bit 12 and option 44.
    local headVar         = '[eventStorage]head'
    local moogleCapBit    = 4096
    local moogleCapOption = 44

    -- Open the menu, close it, and read the eight parameters it started with.
    local function menuParams()
        player.packets:clear()
        player.entities:gotoAndTrigger('Garridan', { eventId = menuEventId, finishOption = utils.EVENT_CANCELLED_OPTION })

        for _, pkt in pairs(player.packets:getIncoming()) do
            if pkt.type == 0x034 then
                local params = {}
                for i = 0, 7 do
                    local offset = 8 + i * 4
                    params[i] = pkt.data[offset] + pkt.data[offset + 1] * 256 + pkt.data[offset + 2] * 65536 + pkt.data[offset + 3] * 16777216
                end

                return params
            end
        end

        assert(false, 'the storage menu never started')
    end

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.PORT_JEUNO })
        player:setGil(1000)
    end)

    it('takes a listed item when it is traded and records its slot', function()
        player:addItem(xi.item.MOOGLE_CAP)
        player.actions:tradeNpc('Garridan', { xi.item.MOOGLE_CAP }, { eventId = storeEventId })

        player.assert.no:hasItem(xi.item.MOOGLE_CAP)
        assert(player:getCharVar(headVar) == moogleCapBit, 'the head slot was not recorded')
    end)

    it('keeps the item when the cutscene is skipped', function()
        player:addItem(xi.item.MOOGLE_CAP)
        player.actions:tradeNpc('Garridan', { xi.item.MOOGLE_CAP }, { eventId = storeEventId, finishOption = utils.EVENT_CANCELLED_OPTION })

        player.assert.no:hasItem(xi.item.MOOGLE_CAP)
        assert(player:getCharVar(headVar) == moogleCapBit, 'skipping the cutscene lost the item')
    end)

    it('starts the menu with the five masks and the gil', function()
        player:setCharVar('[eventStorage]furnishings1', 1)
        player:setCharVar('[eventStorage]weapons', 2)
        player:setCharVar(headVar, moogleCapBit)
        player:setCharVar('[eventStorage]body', 8)
        player:setCharVar('[eventStorage]furnishings2', 16)

        local params = menuParams()
        assert(params[0] == 1, 'the first furnishings mask was not the first parameter')
        assert(params[1] == 2, 'the weapons mask was not the second parameter')
        assert(params[2] == moogleCapBit, 'the head mask was not the third parameter')
        assert(params[3] == 8, 'the body mask was not the fourth parameter')
        assert(params[4] == 1000, 'the gil was not the fifth parameter')
        assert(params[5] == 16, 'the second furnishings mask was not the sixth parameter')
    end)

    it('does nothing when the menu is escaped', function()
        player:setCharVar(headVar, moogleCapBit)
        player.entities:gotoAndTrigger('Garridan', { eventId = menuEventId, finishOption = utils.EVENT_CANCELLED_OPTION })

        player.assert.no:hasItem(xi.item.MOOGLE_CAP)
        assert(player:getGil() == 1000, 'escaping the menu charged the fee')
        assert(player:getCharVar(headVar) == moogleCapBit, 'escaping the menu cleared the slot')
    end)

    it('ignores an option for an empty slot', function()
        player.entities:gotoAndTrigger('Garridan', { eventId = menuEventId, finishOption = moogleCapOption })

        player.assert.no:hasItem(xi.item.MOOGLE_CAP)
        assert(player:getGil() == 1000, 'an empty slot was sold')
    end)

    it('ignores an item that is not on the list', function()
        player:addItem(xi.item.SCROLL_OF_INSTANT_WARP)
        player.actions:tradeNpc('Garridan', { xi.item.SCROLL_OF_INSTANT_WARP })

        player.events:expectNotInEvent()
        player.assert:hasItem(xi.item.SCROLL_OF_INSTANT_WARP)
    end)

    it('ignores a trade with more than one item', function()
        player:addItem(xi.item.MOOGLE_CAP)
        player:addItem(xi.item.BRONZE_CAP)
        player.actions:tradeNpc('Garridan', { xi.item.MOOGLE_CAP, xi.item.BRONZE_CAP })

        player.events:expectNotInEvent()
        player.assert:hasItem(xi.item.MOOGLE_CAP)
        player.assert:hasItem(xi.item.BRONZE_CAP)
        assert(player:getCharVar(headVar) == 0, 'a two-item trade was accepted')
    end)

    it('ignores a second copy of a stored item', function()
        player:setCharVar(headVar, moogleCapBit)
        player:addItem(xi.item.MOOGLE_CAP)
        player.actions:tradeNpc('Garridan', { xi.item.MOOGLE_CAP })

        player.events:expectNotInEvent()
        player.assert:hasItem(xi.item.MOOGLE_CAP)
    end)

    it('only stores the race variant the player can wear', function()
        -- Test characters are male Humes. The Hume Top is the female piece of the same slot.
        player:addItem(xi.item.HUME_TOP)
        player.actions:tradeNpc('Garridan', { xi.item.HUME_TOP })
        player.events:expectNotInEvent()
        player.assert:hasItem(xi.item.HUME_TOP)

        player:addItem(xi.item.HUME_GILET)
        player.actions:tradeNpc('Garridan', { xi.item.HUME_GILET }, { eventId = storeEventId })
        player.assert.no:hasItem(xi.item.HUME_GILET)
        assert(player:getCharVar('[eventStorage]body') == 4, 'the gilet slot was not recorded')
    end)

    it('hands the item back for the fee with its recast reset', function()
        player:setCharVar(headVar, moogleCapBit)
        player.entities:gotoAndTrigger('Garridan', { eventId = menuEventId, finishOption = moogleCapOption })

        player.assert:hasItem(xi.item.MOOGLE_CAP)
        assert(player:getGil() == 750, 'the fee was not charged')
        assert(player:getCharVar(headVar) == 0, 'the slot was not cleared')

        -- Retail sets the recast to its maximum on withdrawal, so the cap comes back as just used.
        local cap = player:findItem(xi.item.MOOGLE_CAP)
        assert(cap)
        local lastUse = cap:getExData().timeValue1
        assert(lastUse and math.abs(lastUse - VanadielTime()) <= 5, 'the enchantment recast was not reset')
    end)

    it('hands out the variant for the current race', function()
        -- A race change keeps the char var and changes getRace(), so a Mithra holding the same var stands in for one.
        player = xi.test.world:spawnPlayer({ zone = xi.zone.PORT_JEUNO, race = xi.race.MITHRA })
        player:setGil(1000)
        player:setCharVar('[eventStorage]body', 4)
        player.entities:gotoAndTrigger('Garridan', { eventId = menuEventId, finishOption = 50 })

        player.assert:hasItem(xi.item.MITHRA_TOP)
        player.assert.no:hasItem(xi.item.HUME_GILET)
    end)

    it('keeps the item when the player cannot pay', function()
        player:setCharVar(headVar, moogleCapBit)
        player:setGil(0)
        player.entities:gotoAndTrigger('Garridan', { eventId = menuEventId, finishOption = moogleCapOption })

        player.assert.no:hasItem(xi.item.MOOGLE_CAP)
        assert(player:getCharVar(headVar) == moogleCapBit, 'the slot was cleared without payment')
    end)

    it('keeps the item when the inventory is full', function()
        player:setCharVar(headVar, moogleCapBit)
        for _ = 1, player:getFreeSlotsCount() do
            player:addItem(xi.item.BRONZE_CAP)
        end

        assert(player:getFreeSlotsCount() == 0, 'the inventory did not fill up')
        player.entities:gotoAndTrigger('Garridan', { eventId = menuEventId, finishOption = moogleCapOption })

        player.assert.no:hasItem(xi.item.MOOGLE_CAP)
        assert(player:getGil() == 1000, 'the fee was charged for nothing')
        assert(player:getCharVar(headVar) == moogleCapBit, 'the slot was cleared for nothing')
    end)

    it('decodes the option the client returns for every block', function()
        player:setGil(5000)

        -- One item from each option block, including the ones appended above 64.
        local cases =
        {
            { var = '[eventStorage]furnishings1', bit = 0,  option = 0,   item = xi.item.SAN_DORIAN_HOLIDAY_TREE },
            { var = '[eventStorage]furnishings1', bit = 30, option = 78,  item = xi.item.ALDEBARAN_HORN },
            { var = '[eventStorage]weapons',      bit = 0,  option = 16,  item = xi.item.CHOCOBO_WAND },
            { var = '[eventStorage]weapons',      bit = 19, option = 95,  item = xi.item.DREAM_BELL_P1 },
            { var = '[eventStorage]head',         bit = 18, option = 82,  item = xi.item.CHOCOBO_BERET },
            { var = '[eventStorage]body',         bit = 16, option = 84,  item = xi.item.EERIE_CLOAK },
            { var = '[eventStorage]body',         bit = 22, option = 127, item = xi.item.DINNER_HOSE },
            { var = '[eventStorage]furnishings2', bit = 23, option = 119, item = xi.item.MANDRAGORA_PRICKET },
        }

        for _, case in ipairs(cases) do
            player:setCharVar(case.var, bit.lshift(1, case.bit))
            player.entities:gotoAndTrigger('Garridan', { eventId = menuEventId, finishOption = case.option })

            player.assert:hasItem(case.item)
            assert(player:getCharVar(case.var) == 0, 'option ' .. case.option .. ' did not clear its slot')
        end
    end)

    it('stores and returns an item at the other four NPCs', function()
        player:setGil(2000)
        player:addItem(xi.item.MOOGLE_CAP)

        local npcs =
        {
            { zone = xi.zone.AHT_URHGAN_WHITEGATE, name = 'Jarafah',        store = 701, menu = 702 },
            { zone = xi.zone.PORT_BASTOK,          name = 'Gallagher',      store = 348, menu = 349 },
            { zone = xi.zone.SOUTHERN_SAN_DORIA,   name = 'Poudoruchant',   store = 778, menu = 779 },
            { zone = xi.zone.WINDURST_WATERS,      name = 'Olaky-Yayulaky', store = 909, menu = 910 },
        }

        for _, npc in ipairs(npcs) do
            player:gotoZone(npc.zone)
            player.actions:tradeNpc(npc.name, { xi.item.MOOGLE_CAP }, { eventId = npc.store })
            player.assert.no:hasItem(xi.item.MOOGLE_CAP)

            player.entities:gotoAndTrigger(npc.name, { eventId = npc.menu, finishOption = moogleCapOption })
            player.assert:hasItem(xi.item.MOOGLE_CAP)
        end
    end)
end)
