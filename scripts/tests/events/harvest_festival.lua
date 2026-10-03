describe('Harvest Festival: seasonal dates', function()
    local boundaries =
    {
        { 2005, 10, 21,  8, false },
        { 2005, 10, 21,  9, true  },
        { 2007, 10, 18, 16, false },
        { 2007, 10, 18, 17, true  },
        { 2005, 11,  1, 16, true  },
        { 2005, 11,  1, 17, false },
        { 2007, 11,  1, 16, true  },
        { 2007, 11,  1, 17, false },
        { 2007, 11,  2,  0, false },
        { 2007,  9, 30, 23, false },
    }

    for _, boundary in ipairs(boundaries) do
        it(string.format('checks edition %u at %u/%u %u:00 JST', boundary[1], boundary[2], boundary[3], boundary[4]), function()
            xi.test.world:setSetting('main.HALLOWEEN_YEAR', boundary[1])
            xi.test.world:setSetting('main.HALLOWEEN_YEAR_ROUND', 0)
            stub('JstMonth', boundary[2])
            stub('JstDayOfTheMonth', boundary[3])
            stub('JstHour', boundary[4])
            assert(xi.events.harvestFestival.isEnabled() == boundary[5])
        end)
    end

    it('requires a supported edition even when year-round mode is enabled', function()
        xi.test.world:setSetting('main.HALLOWEEN_YEAR_ROUND', 1)
        for _, edition in ipairs({ 0, 2006, 2008 }) do
            xi.test.world:setSetting('main.HALLOWEEN_YEAR', edition)
            assert(not xi.events.harvestFestival.isEnabled())
        end

        stub('JstMonth', 2)
        for _, edition in ipairs({ 2005, 2007 }) do
            xi.test.world:setSetting('main.HALLOWEEN_YEAR', edition)
            assert(xi.events.harvestFestival.isEnabled())
        end
    end)
end)

describe('Harvest Festival: trades and lifecycle', function()
    ---@type CClientEntityPair
    local player
    local zone
    local antonian
    local roamer
    local originalModel
    local originalStatus
    local roll
    local pickLastReward

    before_each(function()
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 0)
        xi.test.world:setSetting('main.HALLOWEEN_YEAR_ROUND', 1)
        xi.events.harvestFestival.update()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.NORTHERN_SAN_DORIA })
        if player:isInEvent() then
            player.events:finish()
        end

        zone = GetZone(xi.zone.NORTHERN_SAN_DORIA)
        assert(zone)
        antonian = zone:queryEntitiesByName('Antonian')[1]
        roamer = zone:queryEntitiesByName('Trick_Ghost')[1]
        originalModel = antonian:getModelId()
        originalStatus = roamer:getStatus()
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2007)
        xi.events.harvestFestival.update()
        roll = 100
        pickLastReward = false
        stub('math.randomInt', function(minimum, maximum)
            if maximum == 100 then
                return roll
            end

            return pickLastReward and maximum or minimum
        end)
    end)

    after_each(function()
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 0)
        xi.events.harvestFestival.update()
    end)

    it('consumes one accepted sweet and refuses extra items, quantities, and non-sweets', function()
        player:addItem(xi.item.GINGER_COOKIE, 4)
        player:addItem(xi.item.FIRE_CRYSTAL)
        player.actions:tradeNpc('Antonian',
            {
                { itemId = xi.item.GINGER_COOKIE, quantity = 2 },
            })
        assert(player:getItemCount(xi.item.GINGER_COOKIE) == 4)
        player.actions:tradeNpc('Antonian', { xi.item.GINGER_COOKIE, xi.item.FIRE_CRYSTAL })
        assert(player:getItemCount(xi.item.GINGER_COOKIE) == 4)
        player.actions:tradeNpc('Antonian', { xi.item.FIRE_CRYSTAL })
        player.assert:hasItem(xi.item.FIRE_CRYSTAL)
        player.actions:tradeNpc('Antonian', { xi.item.GINGER_COOKIE })
        assert(player:getItemCount(xi.item.GINGER_COOKIE) == 3)
        assert(player:getStatusEffect(xi.effect.COSTUME):getPower() == 365)
    end)

    it('does not consume sweets while disabled or accept a later sweet in 2005', function()
        player:addItem(xi.item.GINGER_COOKIE)
        player:addItem(xi.item.ORANGE_KUCHEN)
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 0)
        player.actions:tradeNpc('Antonian', { xi.item.GINGER_COOKIE })
        player.assert:hasItem(xi.item.GINGER_COOKIE)
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2005)
        player.actions:tradeNpc('Antonian', { xi.item.ORANGE_KUCHEN })
        player.assert:hasItem(xi.item.ORANGE_KUCHEN)
        assert(not player:hasStatusEffect(xi.effect.COSTUME))
    end)

    it('accepts every added JP sweet in 2007 and keeps it out of the 2005 selection', function()
        local treats =
        {
            xi.item.WILD_COOKIE,
            xi.item.APPLE_PIE_P1,
            xi.item.MELON_PIE_P1,
            xi.item.PUMPKIN_PIE_P1,
            xi.item.ROLANBERRY_PIE_P1,
            xi.item.HOBGOBLIN_PIE,
            xi.item.KONIGSKUCHEN,
            xi.item.UBERKUCHEN,
            xi.item.GATEAU_AUX_FRAISES,
            xi.item.MIDWINTER_DREAM,
            xi.item.SERVING_OF_BLACK_PUDDING,
            xi.item.SERVING_OF_DUSKY_INDULGENCE,
            xi.item.BOWL_OF_SUTLAC,
            xi.item.BOWL_OF_SUTLAC_P1,
            xi.item.IRMIK_HELVASI,
            xi.item.IRMIK_HELVASI_P1,
            xi.item.OPO_OPO_TART,
            xi.item.ORANGE_KUCHEN_P1,
            xi.item.SERVING_OF_CRIMSON_JELLY,
            xi.item.SERVING_OF_VERMILLION_JELLY,
            xi.item.MARRON_GLACE,
            xi.item.BIJOU_GLACE,
            xi.item.SERVING_OF_SQUIRRELS_DELIGHT,
            xi.item.SERVING_OF_ICECAP_ROLANBERRY,
            xi.item.SERVING_OF_SNOWY_ROLANBERRY,
            xi.item.SERVING_OF_FLURRY_COURANTE,
            xi.item.DRIED_DATE,
            xi.item.DRIED_DATE_P1,
        }

        for _, treatId in ipairs(treats) do
            player:addItem(treatId)
            xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2005)
            player.actions:tradeNpc('Antonian', { treatId })
            player.assert:hasItem(treatId)
            xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2007)
            player.actions:tradeNpc('Antonian', { treatId })
            player.assert.no:hasItem(treatId)
            assert(player:getStatusEffect(xi.effect.COSTUME):getPower() == 365)
            player:delStatusEffect(xi.effect.COSTUME)
        end
    end)

    it('allows a missing NQ reward while an equipped NQ also makes its HQ eligible', function()
        player:addItem(xi.item.PUMPKIN_HEAD)
        player:equipItem(xi.item.PUMPKIN_HEAD, nil, xi.slot.HEAD)
        player:addItem(xi.item.GINGER_COOKIE)
        roll = 1
        pickLastReward = true
        player.actions:tradeNpc('Antonian', { xi.item.GINGER_COOKIE })
        player.assert:hasItem(xi.item.TRICK_STAFF_II)
        player.assert.no:hasItem(xi.item.HORROR_HEAD)
    end)

    it('limits the new Goblin providers to 2007 and the matching citizenship', function()
        local participants =
        {
            { xi.zone.BASTOK_MARKETS, 'Ciqala', xi.nation.BASTOK },
            { xi.zone.BASTOK_MARKETS, 'Trick_Skeleton', xi.nation.WINDURST },
            { xi.zone.NORTHERN_SAN_DORIA, 'Attarena', xi.nation.SANDORIA },
            { xi.zone.NORTHERN_SAN_DORIA, 'Justi', xi.nation.WINDURST },
            { xi.zone.NORTHERN_SAN_DORIA, 'Tavourine', xi.nation.BASTOK },
            { xi.zone.NORTHERN_SAN_DORIA, 'Trick_Ghast', xi.nation.WINDURST },
            { xi.zone.NORTHERN_SAN_DORIA, 'Trick_Shade', xi.nation.WINDURST },
            { xi.zone.WINDURST_WATERS, 'Trick_Ghost', xi.nation.WINDURST },
        }

        for _, entry in ipairs(participants) do
            player:gotoZone(entry[1])
            if player:isInEvent() then
                player.events:finish()
            end

            player:setNation(entry[3])
            if not player:hasItem(xi.item.PITCHFORK) then
                player:addItem(xi.item.PITCHFORK)
            end

            player:equipItem(xi.item.PITCHFORK)
            player:addItem(xi.item.GINGER_COOKIE, 3)
            xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2005)
            player:setCharVar('[HarvestFestival]Sweet_' .. xi.item.GINGER_COOKIE, 0)
            player.actions:tradeNpc(entry[2], { xi.item.GINGER_COOKIE })
            assert(player:getStatusEffect(xi.effect.COSTUME):getPower() ~= 673)
            player:delStatusEffect(xi.effect.COSTUME)
            xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2007)
            player:setCharVar('[HarvestFestival]Sweet_' .. xi.item.GINGER_COOKIE, 0)
            player.actions:tradeNpc(entry[2], { xi.item.GINGER_COOKIE })
            assert(player:getStatusEffect(xi.effect.COSTUME):getPower() == 673)
            player:delStatusEffect(xi.effect.COSTUME)
            player:setNation((entry[3] + 1) % 3)
            player:setCharVar('[HarvestFestival]Sweet_' .. xi.item.GINGER_COOKIE, 0)
            player.actions:tradeNpc(entry[2], { xi.item.GINGER_COOKIE })
            assert(player:getStatusEffect(xi.effect.COSTUME):getPower() ~= 673)
            player:delStatusEffect(xi.effect.COSTUME)
        end
    end)

    it('rolls worn-equipment upgrades before the daily costume restriction', function()
        player:addItem(xi.item.PUMPKIN_HEAD)
        player:equipItem(xi.item.PUMPKIN_HEAD, nil, xi.slot.HEAD)
        player:addItem(xi.item.GINGER_COOKIE)
        player:setCharVar('[HarvestFestival]Sweet_' .. xi.item.GINGER_COOKIE, 1, getVanaMidnight())
        player:addStatusEffect(xi.effect.COSTUME, { power = 673, duration = 3600, origin = player })
        roll = 1
        player.actions:tradeNpc('Antonian', { xi.item.GINGER_COOKIE })
        player.assert:hasItem(xi.item.HORROR_HEAD)
        player.assert.no:hasItem(xi.item.GINGER_COOKIE)
        assert(player:getStatusEffect(xi.effect.COSTUME):getPower() == 673)
    end)

    it('leaves a sweet available when the equipment reward cannot fit', function()
        player:addItem(xi.item.GINGER_COOKIE)
        player:addItem(xi.item.PILE_OF_CHOCOBO_BEDDING, player:getFreeSlotsCount())
        assert(player:getFreeSlotsCount() == 0)
        roll = 1
        player.actions:tradeNpc('Antonian', { xi.item.GINGER_COOKIE })
        player.assert:hasItem(xi.item.GINGER_COOKIE)
        player.assert.no:hasItem(xi.item.PUMPKIN_HEAD)
        assert(player:getCharVar('[HarvestFestival]Sweet_' .. xi.item.GINGER_COOKIE) == 0)
        assert(not player:hasStatusEffect(xi.effect.COSTUME))
        player:delItem(xi.item.PILE_OF_CHOCOBO_BEDDING, 1)
        player.actions:tradeNpc('Antonian', { xi.item.GINGER_COOKIE })
        player.assert:hasItem(xi.item.PUMPKIN_HEAD)
        player.assert.no:hasItem(xi.item.GINGER_COOKIE)
    end)

    it('tracks sweets separately and expires their costume restrictions at Vana midnight', function()
        player:addItem(xi.item.GINGER_COOKIE, 3)
        player:addItem(xi.item.CINNA_COOKIE)
        player.actions:tradeNpc('Antonian', { xi.item.GINGER_COOKIE })
        assert(player:hasStatusEffect(xi.effect.COSTUME))
        player:delStatusEffect(xi.effect.COSTUME)
        player.actions:tradeNpc('Antonian', { xi.item.GINGER_COOKIE })
        assert(not player:hasStatusEffect(xi.effect.COSTUME))
        player.actions:tradeNpc('Antonian', { xi.item.CINNA_COOKIE })
        assert(player:hasStatusEffect(xi.effect.COSTUME))
        assert(player:getCharVar('[HarvestFestival]Sweet_' .. xi.item.GINGER_COOKIE) == 1)
        assert(player:getCharVar('[HarvestFestival]Sweet_' .. xi.item.CINNA_COOKIE) == 1)
        player:delStatusEffect(xi.effect.COSTUME)
        xi.test.world:tick(xi.tick.VANA_DAY)
        assert(player:getCharVar('[HarvestFestival]Sweet_' .. xi.item.GINGER_COOKIE) == 0)
        assert(player:getCharVar('[HarvestFestival]Sweet_' .. xi.item.CINNA_COOKIE) == 0)
        player.actions:tradeNpc('Antonian', { xi.item.GINGER_COOKIE })
        assert(player:hasStatusEffect(xi.effect.COSTUME))
        player.assert.no:hasItem(xi.item.GINGER_COOKIE)
    end)

    it('replaces a costume whose model number is higher than the new disguise', function()
        player:addStatusEffect(xi.effect.COSTUME, { power = 673, duration = 3600, origin = player })
        player:addItem(xi.item.GINGER_COOKIE)
        player.actions:tradeNpc('Antonian', { xi.item.GINGER_COOKIE })
        assert(player:getStatusEffect(xi.effect.COSTUME):getPower() == 365)
        player.assert.no:hasItem(xi.item.GINGER_COOKIE)
    end)

    it('walks both patrol legs and remains stopped after the event is disabled', function()
        local route = require('scripts/events/harvest_festival_data')[xi.zone.NORTHERN_SAN_DORIA].npcs.Trick_Ghost.path
        local reachedSecond = false
        local returned = false
        for _ = 1, 120 do
            xi.test.world:tick()
            local position = roamer:getPos()
            if (position.x - route[2].x) ^ 2 + (position.z - route[2].z) ^ 2 < 1 then
                reachedSecond = true
            end

            if
                reachedSecond and
                (position.x - route[1].x) ^ 2 + (position.z - route[1].z) ^ 2 < 1
            then
                returned = true
                break
            end
        end

        assert(reachedSecond, 'the roamer should reach the second waypoint')
        assert(returned, 'the roamer should continue back toward the first waypoint')
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 0)
        xi.events.harvestFestival.update()
        assert(roamer:getStatus() == originalStatus)
        assert(not roamer:isFollowingPath())
        local stopped = roamer:getPos()
        for _ = 1, 5 do
            xi.test.world:tick()
        end

        local position = roamer:getPos()
        assert(position.x == stopped.x and position.y == stopped.y and position.z == stopped.z)
        assert(not roamer:isFollowingPath())
    end)

    it('restores ordinary NPC looks and hides edition-specific actors on transitions', function()
        local exorcist = GetNPCByID(zones[xi.zone.NORTHERN_SAN_DORIA].npc.HARVEST_LILIES_EXORCIST)
        assert(exorcist)
        assert(antonian:getModelId() == 564)
        assert(roamer:getStatus() == xi.status.NORMAL)
        assert(exorcist:getStatus() == xi.status.NORMAL)
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2005)
        xi.events.harvestFestival.update()
        assert(antonian:getModelId() == 564)
        assert(roamer:getStatus() == xi.status.NORMAL)
        assert(exorcist:getStatus() == xi.status.DISAPPEAR)
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 0)
        xi.events.harvestFestival.update()
        assert(antonian:getModelId() == originalModel)
        assert(roamer:getStatus() == originalStatus)
        assert(not roamer:isFollowingPath())
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2007)
        xi.events.harvestFestival.update()
        assert(antonian:getModelId() == 564)
        assert(roamer:getStatus() == xi.status.NORMAL)
        assert(exorcist:getStatus() == xi.status.NORMAL)
    end)
end)
