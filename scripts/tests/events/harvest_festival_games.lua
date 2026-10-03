local games = require('scripts/events/harvest_festival_games')

local pitchforkArea =
{
    getTriggerAreaID = function()
        return 100
    end,
}

local pitchforkPlusOneArea =
{
    getTriggerAreaID = function()
        return 101
    end,
}

local function spawnPair(zoneId, position, costumes)
    local first  = xi.test.world:spawnPlayer({ zone = zoneId })
    local second = xi.test.world:spawnPlayer({ zone = zoneId })
    first:setPos(position[1], position[2], position[3])
    second:setPos(position[1], position[2], position[3])
    for _, member in ipairs({ first, second }) do
        if member:isInEvent() then
            member.events:finish()
        end

        member.events:expectNotInEvent()
    end

    first.actions:inviteToParty(second)
    second.actions:acceptPartyInvite()
    assert(first:getPartySize() == 2, 'Expected a two-person party')
    first:addStatusEffect(xi.effect.COSTUME, { power = costumes[1], duration = 3600, origin = first })
    second:addStatusEffect(xi.effect.COSTUME, { power = costumes[2], duration = 3600, origin = second })
    return first, second
end

describe('Harvest Festival: Pitchfork games', function()
    local enabled

    before_each(function()
        enabled = stub('xi.events.harvestFestival.isEnabled', true)
    end)

    local combinations =
    {
        { xi.zone.SOUTHERN_SAN_DORIA, xi.nation.SANDORIA, { 123.960, 0.000, 74.165 }, { 368, 564 } },
        { xi.zone.NORTHERN_SAN_DORIA, xi.nation.SANDORIA, { -171.675, 0.000, 132.440 }, { 365, 531 } },
        { xi.zone.BASTOK_MINES, xi.nation.BASTOK, { -31.185, 0.000, -27.635 }, { 538, 564 } },
        { xi.zone.BASTOK_MARKETS, xi.nation.BASTOK, { -121.028, -4.000, -132.367 }, { 368, 365 } },
        { xi.zone.WINDURST_WATERS, xi.nation.WINDURST, { -112.090, -1.999, 40.740 }, { 365, 564 } },
        { xi.zone.WINDURST_WOODS, xi.nation.WINDURST, { -29.401, -2.500, 2.641 }, { 534, 368 } },
    }

    for _, entry in ipairs(combinations) do
        it('awards the matching pair in zone ' .. entry[1], function()
            local first, second = spawnPair(entry[1], entry[3], entry[4])
            games.onTriggerAreaEnter(second, pitchforkArea)
            first.assert:hasItem(xi.item.PITCHFORK)
            second.assert:hasItem(xi.item.PITCHFORK)
            assert(first:getCharVar('[HarvestFestival]PitchforkNation') == entry[2] + 1)
            assert(second:getCharVar('[HarvestFestival]PitchforkNation') == entry[2] + 1)
        end)
    end

    it('accepts either costume order and does not reward an NQ helper', function()
        local first, second = spawnPair(xi.zone.SOUTHERN_SAN_DORIA, { 123.960, 0.000, 74.165 }, { 564, 368 })
        first:addItem(xi.item.PITCHFORK)
        first:setCharVar('[HarvestFestival]PitchforkNation', xi.nation.BASTOK + 1)
        games.onTriggerAreaEnter(second, pitchforkArea)
        second.assert:hasItem(xi.item.PITCHFORK)
        first.assert.no:hasItem(xi.item.JACK_O_LANTERN)
        assert(first:getCharVar('[HarvestFestival]PitchforkNation') == xi.nation.BASTOK + 1)
    end)

    it('preserves a full-bag retry after the other member receives NQ', function()
        local first, second = spawnPair(xi.zone.SOUTHERN_SAN_DORIA, { 123.960, 0.000, 74.165 }, { 368, 564 })
        first:addItem(xi.item.PILE_OF_CHOCOBO_BEDDING, first:getFreeSlotsCount())
        first:setCharVar('[HarvestFestival]PitchforkNation', xi.nation.WINDURST + 1)
        games.onTriggerAreaEnter(second, pitchforkArea)
        first.assert.no:hasItem(xi.item.PITCHFORK)
        second.assert:hasItem(xi.item.PITCHFORK)
        assert(first:getCharVar('[HarvestFestival]PitchforkNation') == xi.nation.WINDURST + 1)
        assert(first:getLocalVar('[HarvestFestival]PairRewardArea') == 0)
        first:delItem(xi.item.PILE_OF_CHOCOBO_BEDDING, 1)
        games.onTriggerAreaLeave(first, pitchforkArea)
        games.onTriggerAreaEnter(first, pitchforkArea)
        first.assert:hasItem(xi.item.PITCHFORK)
        assert(first:getCharVar('[HarvestFestival]PitchforkNation') == xi.nation.SANDORIA + 1)
    end)

    it('requires both costumes and both members near the decoration', function()
        local first, second = spawnPair(xi.zone.SOUTHERN_SAN_DORIA, { 123.960, 0.000, 74.165 }, { 368, 365 })
        games.onTriggerAreaEnter(first, pitchforkArea)
        first.assert.no:hasItem(xi.item.PITCHFORK)
        second:delStatusEffect(xi.effect.COSTUME)
        second:addStatusEffect(xi.effect.COSTUME, { power = 564, duration = 3600, origin = second })
        second:setPos(133.960, 0.000, 74.165)
        games.onTriggerAreaEnter(first, pitchforkArea)
        first.assert.no:hasItem(xi.item.PITCHFORK)
        second:setPos(123.960, 0.000, 74.165)
        first:delStatusEffect(xi.effect.COSTUME)
        games.onTriggerAreaEnter(second, pitchforkArea)
        second.assert.no:hasItem(xi.item.PITCHFORK)
    end)

    it('rejects a third party member even after that member leaves the zone', function()
        local first, second = spawnPair(xi.zone.SOUTHERN_SAN_DORIA, { 123.960, 0.000, 74.165 }, { 368, 564 })
        first:delStatusEffect(xi.effect.COSTUME)
        local third = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        third:setPos(123.960, 0.000, 74.165)
        first.actions:inviteToParty(third)
        third.actions:acceptPartyInvite()
        third:gotoZone(xi.zone.NORTHERN_SAN_DORIA)
        if third:isInEvent() then
            third.events:finish()
        end

        first:addStatusEffect(xi.effect.COSTUME, { power = 368, duration = 3600, origin = first })
        assert(first:getPartySize() == 3, 'Expected the remote third member to stay in the party')
        games.onTriggerAreaEnter(second, pitchforkArea)
        first.assert.no:hasItem(xi.item.PITCHFORK)
        second.assert.no:hasItem(xi.item.PITCHFORK)
    end)

    it('awards HQ once per arrival and gives existing HQ owners food on another arrival', function()
        local first, second = spawnPair(xi.zone.SOUTHERN_SAN_DORIA, { -160.309, -2.000, 54.277 }, { 673, 673 })
        games.onTriggerAreaEnter(first, pitchforkPlusOneArea)
        games.onTriggerAreaEnter(second, pitchforkPlusOneArea)
        first.assert:hasItem(xi.item.PITCHFORK_P1)
        second.assert:hasItem(xi.item.PITCHFORK_P1)
        first.assert.no:hasItem(xi.item.JACK_O_LANTERN)
        second.assert.no:hasItem(xi.item.JACK_O_LANTERN)
        games.onTriggerAreaLeave(first, pitchforkPlusOneArea)
        games.onTriggerAreaLeave(second, pitchforkPlusOneArea)
        games.onTriggerAreaEnter(first, pitchforkPlusOneArea)
        games.onTriggerAreaEnter(second, pitchforkPlusOneArea)
        assert(first:getItemCount(xi.item.JACK_O_LANTERN) == 1)
        assert(second:getItemCount(xi.item.JACK_O_LANTERN) == 1)
        assert(first:hasStatusEffect(xi.effect.COSTUME) and second:hasStatusEffect(xi.effect.COSTUME))
    end)

    it('rejects a different Goblin model and blocks disabled games', function()
        local first, second = spawnPair(xi.zone.SOUTHERN_SAN_DORIA, { -160.309, -2.000, 54.277 }, { 673, 674 })
        games.onTriggerAreaEnter(first, pitchforkPlusOneArea)
        first.assert.no:hasItem(xi.item.PITCHFORK_P1)
        second:delStatusEffect(xi.effect.COSTUME)
        second:addStatusEffect(xi.effect.COSTUME, { power = 673, duration = 3600, origin = second })
        enabled:returnValue(false)
        games.onTriggerAreaEnter(second, pitchforkPlusOneArea)
        second.assert.no:hasItem(xi.item.PITCHFORK_P1)
    end)

    it('allows a full-bag HQ helper to retry without duplicating the other reward', function()
        local first, second = spawnPair(xi.zone.SOUTHERN_SAN_DORIA, { -160.309, -2.000, 54.277 }, { 673, 673 })
        first:addItem(xi.item.PITCHFORK_P1)
        first:addItem(xi.item.PILE_OF_CHOCOBO_BEDDING, first:getFreeSlotsCount())
        games.onTriggerAreaEnter(second, pitchforkPlusOneArea)
        first.assert.no:hasItem(xi.item.JACK_O_LANTERN)
        second.assert:hasItem(xi.item.PITCHFORK_P1)
        first:delItem(xi.item.PILE_OF_CHOCOBO_BEDDING, 1)
        games.onTriggerAreaLeave(first, pitchforkPlusOneArea)
        games.onTriggerAreaEnter(first, pitchforkPlusOneArea)
        first.assert:hasItem(xi.item.JACK_O_LANTERN)
        second.assert.no:hasItem(xi.item.JACK_O_LANTERN)
    end)

    it('uses the last NQ acquisition nation for the NPC Goblin route', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.SOUTHERN_SAN_DORIA })
        player:setNation(xi.nation.BASTOK)
        player:addItem(xi.item.PITCHFORK)
        player:equipItem(xi.item.PITCHFORK, nil, xi.slot.MAIN)
        player:setCharVar('[HarvestFestival]PitchforkNation', xi.nation.SANDORIA + 1)
        assert(not games.getGoblinCostume(player, xi.nation.BASTOK))
        player:setCharVar('[HarvestFestival]PitchforkNation', xi.nation.WINDURST + 1)
        assert(games.getGoblinCostume(player, xi.nation.BASTOK) == 673)
        assert(not games.getGoblinCostume(player, xi.nation.SANDORIA))
        player:unequipItem(xi.slot.MAIN)
        assert(not games.getGoblinCostume(player, xi.nation.BASTOK))
    end)
end)

describe('Harvest Festival: game actor lifecycle', function()
    after_each(function()
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 0)
        xi.events.harvestFestival.update()
    end)

    it('reuses decorations and moogles through enable, edition changes and disable', function()
        local zoneIds =
        {
            xi.zone.SOUTHERN_SAN_DORIA,
            xi.zone.NORTHERN_SAN_DORIA,
            xi.zone.BASTOK_MINES,
            xi.zone.BASTOK_MARKETS,
            xi.zone.PORT_BASTOK,
            xi.zone.WINDURST_WATERS,
            xi.zone.WINDURST_WOODS,
        }

        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 0)
        xi.test.world:setSetting('main.HALLOWEEN_YEAR_ROUND', 1)
        xi.events.harvestFestival.update()
        for _, zoneId in ipairs(zoneIds) do
            local player = xi.test.world:spawnPlayer({ zone = zoneId })
            if player:isInEvent() then
                player.events:finish()
            end
        end

        local actors = {}
        for stage, edition in ipairs({ 2007, 2005, 0, 2007 }) do
            xi.test.world:setSetting('main.HALLOWEEN_YEAR', edition)
            xi.events.harvestFestival.update()
            local decorations = 0
            local moogles     = 0
            for _, zoneId in ipairs(zoneIds) do
                for _, npc in pairs(GetZone(zoneId):getNPCs()) do
                    local name = npc:getName()
                    if name:find('DE_Harvest_', 1, true) then
                        if stage == 1 then
                            actors[npc:getID()] = name
                        else
                            assert(actors[npc:getID()] == name, 'Expected the existing actor to be reused')
                        end

                        if name:find('DE_Harvest_Decoration_', 1, true) then
                            decorations = decorations + 1
                        else
                            moogles = moogles + 1
                        end

                        if edition == 0 or edition == 2005 and name == 'DE_Harvest_Shop_Moogle' then
                            assert(npc:getStatus() == xi.status.DISAPPEAR)
                        else
                            assert(npc:getStatus() == xi.status.NORMAL)
                        end
                    end
                end
            end

            assert(decorations == 21 and moogles == 6, 'Expected 21 decorations and six moogles')
        end
    end)
end)

describe('Harvest Festival: lantern shops', function()
    local enabled

    before_each(function()
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2007)
        enabled = stub('xi.events.harvestFestival.isEnabled', true)
    end)

    it('sells a home-nation lantern with Witch Hat and all lanterns with Coven Hat', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.NORTHERN_SAN_DORIA })
        if player:isInEvent() then
            player.events:finish()
        end

        player:setNation(xi.nation.SANDORIA)
        local npc  = GetNPCByID(zones[xi.zone.NORTHERN_SAN_DORIA].npc.EXPLORER_MOOGLE)
        local shop = stub('xi.shop.general', true)
        games.onMoogleTrigger(player, npc)
        assert(#shop.calls[1].args[2] == 1)
        assert(shop.calls[1].args[2][1][1] == xi.item.JACK_O_LANTERN and shop.calls[1].args[2][1][2] == 1000)
        player:addItem(xi.item.WITCH_HAT)
        player:equipItem(xi.item.WITCH_HAT, nil, xi.slot.HEAD)
        games.onMoogleTrigger(player, npc)
        assert(#shop.calls[2].args[2] == 2)
        assert(shop.calls[2].args[2][2][1] == xi.item.PUMPKIN_LANTERN and shop.calls[2].args[2][2][2] == 10000)
        player:setNation(xi.nation.BASTOK)
        games.onMoogleTrigger(player, npc)
        assert(#shop.calls[3].args[2] == 1)
        player:addItem(xi.item.COVEN_HAT)
        player:equipItem(xi.item.COVEN_HAT, nil, xi.slot.HEAD)
        games.onMoogleTrigger(player, npc)
        assert(#shop.calls[4].args[2] == 4)
        for index = 2, 4 do
            assert(shop.calls[4].args[2][index][2] == 10000)
        end
    end)

    it('blocks the shops in the 2005 edition and while disabled', function()
        local player = xi.test.world:spawnPlayer({ zone = xi.zone.NORTHERN_SAN_DORIA })
        if player:isInEvent() then
            player.events:finish()
        end

        local shop   = stub('xi.shop.general', true)
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2005)
        games.onMoogleTrigger(player, nil)
        xi.test.world:setSetting('main.HALLOWEEN_YEAR', 2007)
        enabled:returnValue(false)
        games.onMoogleTrigger(player, nil)
        shop:called(0)
    end)
end)
