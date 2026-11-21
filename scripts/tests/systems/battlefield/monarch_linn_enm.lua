---@diagnostic disable: inject-field
local ffi = require('ffi')

local cases =
{
    { name = 'Fire in the Sky',          id = xi.battlefield.id.FIRE_IN_THE_SKY,          boss = 'Razon',            entrants = 1, exp = 2500 },
    { name = 'Bugard in the Clouds',     id = xi.battlefield.id.BUGARD_IN_THE_CLOUDS,     boss = 'Hotupuku',         entrants = 5, exp = 1500, ore = 2, exclusions = true },
    { name = 'Beloved of the Atlantes',  id = xi.battlefield.id.BELOVED_OF_THE_ATLANTES,  boss = 'Watch_Hippogryph', entrants = 8, exp = 1872, ore = 4 },
    { name = 'Bugard split party',       id = xi.battlefield.id.BUGARD_IN_THE_CLOUDS,     boss = 'Hotupuku',         entrants = 2, exp = 2500, ore = 2, splitOpener = true },
}

local function readExp(player)
    player.packets:clear()
    local request = ffi.new('uint8_t[8]')
    player.packets:send(0x061, request, ffi.sizeof(request) or 0)
    for _, packet in ipairs(player.packets:getIncoming()) do
        if packet.type == 0x061 then
            return packet.data[16] + packet.data[17] * 256
        end
    end

    error('missing EXP status packet')
end

local function readLoot(player)
    local loot = {}
    for _, packet in ipairs(player.packets:getIncoming()) do
        if packet.type == 0x0D2 then
            local itemId = packet.data[16] + packet.data[17] * 256
            if itemId ~= 0 then
                loot[itemId] = (loot[itemId] or 0) + 1
            end
        end
    end

    return loot
end

local function enterAndClear(case, players)
    local zone = case.zone or xi.zone.MONARCH_LINN
    local keyItem = case.keyItem or xi.keyItem.MONARCH_BEARD
    local entrance = case.entrance or 'SD_Entrance'
    local level = case.level or 60

    for i = 1, case.entrants do
        local player = xi.test.world:spawnPlayer({ zone = zone, level = level, job = xi.job.WAR, race = xi.race.HUME_M })
        player:delExp(readExp(player))
        player:addKeyItem(keyItem)
        players[i] = player
    end

    local opener = players[1]
    local firstPartySize = case.entrants > 6 and 4 or case.entrants
    for i = 2, firstPartySize do
        opener.actions:inviteToParty(players[i])
        players[i].actions:acceptPartyInvite()
    end

    if case.entrants > 6 then
        local otherLeader = players[5]
        for i = 6, case.entrants do
            otherLeader.actions:inviteToParty(players[i])
            players[i].actions:acceptPartyInvite()
        end

        opener.actions:formAlliance(otherLeader)
        otherLeader.actions:acceptPartyInvite()
    end

    for _, player in ipairs(players) do
        player.bcnm:enter(entrance, case.id)
    end

    if case.splitOpener then
        opener = players[2]
        opener.actions:leaveParty()
    end

    local battlefield = assert(opener:getBattlefield())
    assert(battlefield:getPlayerCount() == case.entrants, 'wrong ENM participant count')
    local content = xi.battlefield.contents[case.id]
    if case.boss then
        local boss = opener.entities:get(case.boss)
        boss:updateEnmity(opener)
        xi.test.world:tick()
        assert(battlefield:getStatus() == xi.battlefield.status.LOCKED, 'engaging the boss did not lock the fight')
        opener:claimAndKillMob(boss)
    else
        -- Simulate only the all-death condition for the multi-enemy Mine Shaft fights.
        Battlefield.handleAllMonstersDefeated(content, battlefield)
    end

    local crateId = battlefield:getArmouryCrate()
    if crateId == 0 and content.armouryCrates then
        crateId = content.armouryCrates[battlefield:getArea()]
    end

    local crate = assert(GetNPCByID(crateId))
    assert(crate:getStatus() == xi.status.NORMAL, 'armoury crate did not appear')
    assert(battlefield:getStatus() < xi.battlefield.status.WON, 'fight cleared before the crate opened')

    local x = crate:getXPos()
    local y = crate:getYPos()
    local z = crate:getZPos()
    for _, player in ipairs(players) do
        player:setPos(x, y, z)
    end

    if case.exclusions then
        players[3]:die()
        xi.test.world:tickEntity(players[3])
        players[4]:setPos(x + 101, y, z)
        players[5].actions:leaveParty()
        players[5]:leaveBattlefield(xi.battlefield.leaveCode.EXIT)
        assert(players[3]:isDead() and players[4]:checkDistance(crate) > 100)
        assert(not players[5]:getBattlefield() and battlefield:getPlayerCount() == case.entrants - 1)
    end

    return opener, battlefield, crate
end

local function verifyCrateItemDistribution(case, players, opener, pool, poolMembers, loot)
    local ore           = xi.item.CHUNK_OF_ALUMINUM_ORE
    local oreRecipients = {}
    if case.exclusions then
        players[3]:sendReraise(1)
        players[3].actions:acceptRaise()
        xi.test.world:skipTime(3) -- The death state ends more than two seconds after accepting Raise.
        assert(players[3]:isAlive(), 'the KO player must be raised before lotting')
        oreRecipients = { players[3], players[4] }
    end

    for _, item in ipairs(pool:getItems()) do
        if item.id ~= 0 then
            local vote = ffi.new('uint8_t[8]')
            vote[4] = item.slotId
            local winner = opener
            if item.id == ore and #oreRecipients > 0 then
                winner = table.remove(oreRecipients, 1)
            end

            winner.packets:send(0x041, vote, ffi.sizeof(vote) or 0)
            for _, player in ipairs(players) do
                if player ~= winner and poolMembers[player:getID()] then
                    player.packets:send(0x042, vote, ffi.sizeof(vote) or 0)
                end
            end
        end
    end

    for i, player in ipairs(players) do
        for itemId, count in pairs(loot) do
            local expected = player == opener and count or 0
            if case.exclusions and itemId == ore then
                expected = (i == 3 or i == 4) and 1 or 0
            end

            assert(player:getItemCount(itemId) == expected, 'the crate item did not go to the expected entrant')
        end
    end
end

describe('ENM crate rewards', function()
    local players

    before_each(function()
        players = {}
        xi.test.world:setSetting('map.DROP_RATE_MULTIPLIER', 1)
    end)

    after_each(function()
        for _, player in ipairs(players) do
            if player:getBattlefield() then
                player:leaveBattlefield(xi.battlefield.leaveCode.EXIT)
            end
        end

        for _ = 1, 3 do
            xi.test.world:skipTime(11)
            xi.test.world:tick()
        end
    end)

    it('does not deduct EXP on death in Bionic Bug', function()
        xi.test.world:setSetting('map.EXP_RETAIN', 0)
        xi.test.world:setSetting('map.EXP_LOSS_RATE', 1)
        xi.test.world:setSetting('map.EXP_LOSS_LEVEL', 31)

        local player = xi.test.world:spawnPlayer({ zone = xi.zone.MINE_SHAFT_2716, level = 80 })
        players[1] = player
        player:addKeyItem(xi.keyItem.SHAFT_2716_OPERATING_LEVER)
        player.bcnm:enter('_0d0', xi.battlefield.id.BIONIC_BUG)
        player:delExp(readExp(player))
        player:addExp(3000)
        player:setCharVar('expLost', 0)

        local before = readExp(player)
        assert(before > 0, 'the player must have EXP to lose')
        player:die()
        xi.test.world:tickEntity(player)

        assert(player:isDead(), 'the player must be dead')
        assert(player:getCharVar('expLost') == 0 and readExp(player) == before, 'ENM death deducted EXP')
    end)

    for _, case in ipairs(cases) do
        local rewardTest = ' awards EXP and loot on one valid crate open'
        if case.exclusions then
            rewardTest = ' counts the departed entrant for EXP and uses ordinary party loot'
        elseif case.splitOpener then
            rewardTest = ' awards EXP and loot to the opener after a party split'
        end

        it(case.name .. rewardTest, function()
            local opener, battlefield, crate = enterAndClear(case, players)

            local before = {}
            for i, player in ipairs(players) do
                before[i] = readExp(player)
                player.packets:clear()
            end

            xi.test.world:setSeed(144)
            opener.actions:trigger(crate)
            assert(battlefield:getStatus() == xi.battlefield.status.WON, 'opening the crate did not win')
            Battlefield.handleOpenArmouryCrate(xi.battlefield.contents[case.id], opener, crate)

            local loot = readLoot(opener)
            assert(next(loot), 'crate announced no items')
            if case.ore then
                assert(loot[xi.item.CHUNK_OF_ALUMINUM_ORE] == case.ore, 'wrong amount of guaranteed aluminum ore')
            end

            local pool = assert(opener:getTreasurePool())
            local poolMembers = {}
            for _, member in ipairs(pool:getMembers()) do
                poolMembers[member:getID()] = true
            end

            if case.exclusions then
                assert(poolMembers[players[3]:getID()] and poolMembers[players[4]:getID()], 'KO and distant players must share the pool before testing exclusions')
                assert(not poolMembers[players[5]:getID()], 'the player who left the party must use a separate pool')
            elseif case.splitOpener then
                assert(pool:memberCount() == 1 and poolMembers[opener:getID()], 'the opener must have a separate pool from the first entrant')
            end

            for i, player in ipairs(players) do
                local earnsExp  = (not case.exclusions or i <= 2) and (not case.splitOpener or i == 2)
                local announced = readLoot(player)
                if poolMembers[player:getID()] then
                    for itemId, count in pairs(loot) do
                        assert(announced[itemId] == count, 'a treasure pool member missed a loot announcement')
                    end
                else
                    assert(not next(announced), 'a player outside the opener\'s pool saw crate loot')
                end

                local gain = readExp(player) - before[i]
                assert(gain == (earnsExp and case.exp or 0),
                    'wrong crate EXP for entrant ' .. tostring(i) .. ': ' .. tostring(gain))
            end

            verifyCrateItemDistribution(case, players, opener, pool, poolMembers, loot)

            if case.id == xi.battlefield.id.FIRE_IN_THE_SKY then
                local awardedExp = readExp(opener)
                for _ = 1, xi.battlefield.contents[case.id].delayToExit do
                    xi.test.world:skipTime(2)
                end

                opener.bcnm:expectWin({ finishOption = 2 })
                assert(readExp(opener) == awardedExp, 'the victory event awarded EXP a second time')
            end
        end)
    end

    local otherEnms =
    {
        {
            name     = 'Like the Wind',
            id       = xi.battlefield.id.LIKE_THE_WIND,
            zone     = xi.zone.BONEYARD_GULLY,
            entrance = '_081',
            keyItem  = xi.keyItem.MIASMA_FILTER,
            boss     = 'Race_Runner',
            level    = 80,
            entrants = 4,
            exp      = 1500,
            rewards  = { xi.item.SQUARE_OF_KEJUSU_SATIN },
        },
        {
            name     = 'Automaton Assault',
            id       = xi.battlefield.id.AUTOMATON_ASSAULT,
            zone     = xi.zone.MINE_SHAFT_2716,
            entrance = '_0d0',
            keyItem  = xi.keyItem.SHAFT_GATE_OPERATING_DIAL,
            entrants = 4,
            exp      = 1500,
            rewards  = { xi.item.QUANTZS_EARRING },
        },
        {
            name     = 'Pulling the Strings',
            id       = xi.battlefield.id.PULLING_THE_STRINGS,
            zone     = xi.zone.MINE_SHAFT_2716,
            entrance = '_0d0',
            keyItem  = xi.keyItem.SHAFT_GATE_OPERATING_DIAL,
            entrants = 1,
            exp      = 2000,
            rewards  = { xi.item.SACK_OF_LITTLE_WORM_MULCH, xi.item.JANIZARY_EARRING },
        },
    }

    for _, case in ipairs(otherEnms) do
        it(case.name .. ' pays EXP and its regular loot at the crate', function()
            xi.test.world:setSetting('map.BCNM_ENABLE_EXPERIMENTAL', true)
            local opener, battlefield, crate = enterAndClear(case, players)
            for _, player in ipairs(players) do
                assert(readExp(player) == 0, 'EXP was awarded before the crate opened')
            end

            stub('math.randomInt', function(_, maximum)
                return maximum
            end)

            opener.actions:trigger(crate)
            assert(battlefield:getStatus() == xi.battlefield.status.WON)
            local loot = readLoot(opener)
            for _, itemId in ipairs(case.rewards) do
                assert(loot[itemId] == 1, 'the expected crate reward did not drop')
            end

            for _, player in ipairs(players) do
                assert(readExp(player) == case.exp, 'wrong crate EXP')
            end

            for _ = 1, xi.battlefield.contents[case.id].delayToExit do
                xi.test.world:skipTime(2)
            end

            opener.bcnm:expectWin({ finishOption = 2 })
            assert(readExp(opener) == case.exp, 'the victory event awarded EXP a second time')
        end)
    end

    it('refuses a revealed crate after a recorded loss without loot or EXP', function()
        local opener, battlefield, crate = enterAndClear(cases[1], players)
        assert(battlefield:setStatus(xi.battlefield.status.LOST))

        local before = {}
        for i, player in ipairs(players) do
            before[i] = readExp(player)
            player.packets:clear()
        end

        Battlefield.handleOpenArmouryCrate(xi.battlefield.contents[cases[1].id], opener, crate)

        assert(battlefield:getStatus() == xi.battlefield.status.LOST, 'rejected crate changed the battlefield outcome')
        assert(crate:getLocalVar('opened') == 0, 'rejected crate was opened')
        for _, item in ipairs(opener:getTreasurePool():getItems()) do
            assert(item.id == 0, 'rejected crate added loot to the pool')
        end

        for i, player in ipairs(players) do
            assert(not next(readLoot(player)), 'rejected crate announced loot')
            assert(readExp(player) == before[i], 'rejected crate awarded EXP')
        end
    end)
end)
