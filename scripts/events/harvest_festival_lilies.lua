-----------------------------------
-- Harvest Festival: Wake of the Lilies
-- https://www.playonline.com/pcd/topics/ff11us/detail/2402/detail.html
-- https://wikiwiki.jp/ffxi/%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88/%E9%97%87%E7%99%BE%E5%90%88%E3%81%AE%E9%AD%94%E5%A5%B3%EF%BC%9C%E8%BF%BD%E6%86%B6%E7%B7%A8%EF%BC%9E
-----------------------------------
local lilies = {}

local costumeModels =
{
    [365] = true,
    [368] = true,
    [564] = true,
    [673] = true,
}

for _, range in ipairs({ { 531, 538 }, { 580, 607 }, { 612, 639 }, { 644, 671 } }) do
    for model = range[1], range[2] do
        costumeModels[model] = true
    end
end

-- Routes, turn speeds, ranges, and timing are estimates.
local routes =
{
    [xi.zone.NORTHERN_SAN_DORIA] =
    {
        {
            {  17.630, -0.200, 38.837 },
            {  29.630, -0.200, 34.004 },
            {  19.963, -0.200, 55.837 },
            {  14.000,  0.000, 40.712 },
            {  21.863, -0.280, 23.237 },
        },
        {
            { -153.637, -0.200, 125.737 },
            { -134.537, -0.200, 129.537 },
            { -151.787, -0.200, 135.587 },
            { -169.637, -0.200, 128.137 },
            { -154.000,  0.000, 122.000 },
            { -152.037, -0.200, 112.462 },
        },
    },
    [xi.zone.BASTOK_MARKETS] =
    {
        {
            { -194.917, -6.633,  -98.932 },
            { -191.667, -6.000,  -95.516 },
            { -196.000, -6.000,  -88.250 },
            { -195.900, -6.880,  -78.949 },
            { -200.000, -6.000,  -92.000 },
            { -216.250, -6.350,  -97.724 },
            { -197.800, -6.600, -114.249 },
        },
        {
            { -257.667, -12.200, -35.516 },
            { -242.083, -12.467, -40.182 },
            { -266.000, -12.200, -29.349 },
            { -274.500, -12.200, -36.516 },
            { -258.500, -12.200, -49.949 },
        },
    },
    [xi.zone.WINDURST_WATERS] =
    {
        {
            { -40.875, -5.200,  91.225 },
            { -27.667, -5.533,  90.767 },
            { -30.000, -5.200,  90.000 },
            { -40.000, -5.200, 103.600 },
            { -55.500, -5.100,  83.725 },
            { -40.500, -4.767,  81.100 },
        },
        {
            { -35.834, -2.600, -101.817 },
            { -29.125, -2.600, -109.775 },
            { -34.000, -2.600, -103.000 },
            { -36.400, -2.800,  -85.200 },
            { -44.625, -2.600, -111.400 },
        },
    },
}

local function clearRequest(player)
    player:setLocalVar('HarvestLiliesTarget', 0)
    player:setLocalVar('HarvestLiliesProgress', 0)
    player:setLocalVar('HarvestLiliesDeadline', 0)
    player:setLocalVar('HarvestLiliesNextMessage', 0)
    player:setLocalVar('HarvestLiliesJoined', 0)
    player:setLocalVar('HarvestLiliesEvent', 0)
end

lilies.onExorcistTrigger = function(player, npc)
    if
        not xi.events.harvestFestival.isEnabled() or
        xi.settings.main.HALLOWEEN_YEAR ~= 2007 or
        player:hasStatusEffect(xi.effect.COSTUME)
    then
        return
    end

    if player:getLocalVar('HarvestLiliesDeadline') <= GetSystemTime() then
        clearRequest(player)
    end

    local eventId = 32728
    local reward = 0
    if player:getLocalVar('HarvestLiliesTarget') ~= 0 then
        if player:getLocalVar('HarvestLiliesProgress') == 10 then
            eventId = 32729
            if
                player:getLocalVar('HarvestLiliesTarget') == zones[player:getZoneID()].npc.HARVEST_LILIES_WITCHES[2] or
                player:hasItem(xi.item.WITCH_HAT)
            then
                reward = 1
            end
        else
            eventId = 32730
        end
    elseif player:getCharVar('[HarvestFestival]LiliesWait') > GetSystemTime() then
        eventId = 32732
    elseif player:getEquipID(xi.slot.HEAD) == xi.item.WITCH_HAT then
        eventId = 32731
    end

    player:setLocalVar('HarvestLiliesEvent', eventId)
    player:startEvent(eventId, 0, reward)
end

lilies.onExorcistEventFinish = function(player, csid, option, npc)
    if
        not xi.events.harvestFestival.isEnabled() or
        xi.settings.main.HALLOWEEN_YEAR ~= 2007 or
        csid ~= player:getLocalVar('HarvestLiliesEvent')
    then
        return
    end

    player:setLocalVar('HarvestLiliesEvent', 0)
    local ID = zones[player:getZoneID()]
    if (csid == 32728 or csid == 32731) and option == 1 then
        if player:getCharVar('[HarvestFestival]LiliesWait') > GetSystemTime() then
            return
        end

        clearRequest(player)
        local target = ID.npc.HARVEST_LILIES_WITCHES[1]
        if csid == 32731 then
            target = ID.npc.HARVEST_LILIES_WITCHES[2]
        end

        player:setLocalVar('HarvestLiliesTarget', target)
        player:setLocalVar('HarvestLiliesDeadline', getVanaMidnight())
    elseif csid == 32730 and option == 1 then
        clearRequest(player)
    elseif csid == 32729 then
        if
            player:getLocalVar('HarvestLiliesDeadline') <= GetSystemTime() or
            player:getLocalVar('HarvestLiliesProgress') ~= 10
        then
            clearRequest(player)
            return
        end

        local reward = xi.item.PAPILLION
        local quantity = math.max(10, 12 - player:getCharVar('[HarvestFestival]LiliesRepeats'))
        if
            player:getLocalVar('HarvestLiliesTarget') == ID.npc.HARVEST_LILIES_WITCHES[1] and
            not player:hasItem(xi.item.WITCH_HAT)
        then
            reward = xi.item.WITCH_HAT
            quantity = 1
        elseif
            player:getLocalVar('HarvestLiliesTarget') == ID.npc.HARVEST_LILIES_WITCHES[2] and
            not player:hasItem(xi.item.COVEN_HAT)
        then
            reward = xi.item.COVEN_HAT
            quantity = 1
        end

        if not npcUtil.giveItem(player, { { reward, quantity } }) then
            return
        end

        if reward == xi.item.PAPILLION then
            player:setCharVar('[HarvestFestival]LiliesRepeats', math.min(2, player:getCharVar('[HarvestFestival]LiliesRepeats') + 1))
        end

        local midnight = getVanaMidnight()
        player:setCharVar('[HarvestFestival]LiliesWait', midnight, midnight)
        clearRequest(player)
    end
end

lilies.onWitchTick = function(npc)
    if
        not xi.events.harvestFestival.isEnabled() or
        xi.settings.main.HALLOWEEN_YEAR ~= 2007 or
        npc:getStatus() ~= xi.status.NORMAL
    then
        return
    end

    local now = GetSystemTime()
    if npc:getLocalVar('HarvestLiliesNextTick') > now then
        return
    end

    local zoneId = npc:getZoneID()
    npc:setLocalVar('HarvestLiliesNextTick', now + 1)
    local tier = npc:getLocalVar('HarvestLiliesTier')
    if not npc:isFollowingPath() then
        local turn = npc:getLocalVar('HarvestLiliesTurn')
        if turn < 16 or (tier == 2 and turn < 32) then
            local direction = 16
            if tier == 2 then
                direction = 32
                if turn >= 8 and turn < 16 then
                    direction = -32
                end
            end

            npc:setRotation((npc:getRotPos() + direction) % 256)
            npc:setLocalVar('HarvestLiliesTurn', turn + 1)
        else
            local route = routes[zoneId][tier]
            local point = npc:getLocalVar('HarvestLiliesPoint') % #route + 1
            npc:setLocalVar('HarvestLiliesPoint', point)
            npc:setLocalVar('HarvestLiliesTurn', 0)
            npc:pathTo(route[point][1], route[point][2], route[point][3], xi.pathflag.SCRIPT)
        end
    end

    local ID = zones[zoneId]
    local npcId = npc:getID()
    for _, player in pairs(npc:getZone():getPlayers()) do
        if player:getLocalVar('HarvestLiliesTarget') == npcId then
            local costume = player:getStatusEffect(xi.effect.COSTUME)
            if player:getLocalVar('HarvestLiliesDeadline') <= now then
                clearRequest(player)
            elseif not player:isInEvent() and costume and costumeModels[costume:getPower()] then
                local distance = npc:checkDistance(player)
                if
                    distance <= (tier == 2 and 9 or 6) and
                    npc:isFacing(player, 64) and
                    npc:canSee(player)
                then
                    player:delStatusEffect(xi.effect.COSTUME)
                    player:messageSpecial(ID.text.HARVEST_LILIES_DETECTED)
                    player:setLocalVar('HarvestLiliesJoined', 0)
                    player:setLocalVar('HarvestLiliesNextMessage', 0)
                elseif distance <= 10 and player:getLocalVar('HarvestLiliesProgress') < 10 then
                    if player:getLocalVar('HarvestLiliesJoined') == 0 then
                        player:messageSpecial(ID.text.HARVEST_LILIES_JOINED)
                        player:setLocalVar('HarvestLiliesJoined', 1)
                        player:setLocalVar('HarvestLiliesNextMessage', now + 8)
                    elseif player:getLocalVar('HarvestLiliesNextMessage') <= now then
                        local progress = player:getLocalVar('HarvestLiliesProgress')
                        player:messageSpecial(ID.text.HARVEST_LILIES_PROGRESS + progress)
                        player:setLocalVar('HarvestLiliesProgress', progress + 1)
                        player:setLocalVar('HarvestLiliesNextMessage', now + 8)
                    end
                else
                    player:setLocalVar('HarvestLiliesNextMessage', now + 8)
                end
            else
                player:setLocalVar('HarvestLiliesNextMessage', now + 8)
            end
        end
    end
end

lilies.initializeZone = function(zone)
    local zoneId = zone:getID()
    local ID = zones[zoneId]
    if not ID.npc.HARVEST_LILIES_WITCHES then
        return
    end

    GetNPCByID(ID.npc.HARVEST_LILIES_EXORCIST):setStatus(xi.status.NORMAL)
    for tier, npcId in ipairs(ID.npc.HARVEST_LILIES_WITCHES) do
        local npc = GetNPCByID(npcId)
        if npc then
            npc:initNpcAi()
            npc:setLocalVar('HarvestLiliesNextTick', 0)
            npc:setLocalVar('HarvestLiliesPoint', 1)
            npc:setLocalVar('HarvestLiliesTurn', 0)
            npc:setLocalVar('HarvestLiliesTier', tier)
            npc:setStatus(xi.status.NORMAL)
            npc:addListener('TICK', 'HARVEST_LILIES', lilies.onWitchTick)
            local point = routes[zoneId][tier][1]
            npc:pathTo(point[1], point[2], point[3], xi.pathflag.SCRIPT)
        end
    end
end

lilies.cleanupZone = function(zone)
    local ID = zones[zone:getID()]
    if not ID.npc.HARVEST_LILIES_WITCHES then
        return
    end

    GetNPCByID(ID.npc.HARVEST_LILIES_EXORCIST):setStatus(xi.status.DISAPPEAR)
    for _, npcId in ipairs(ID.npc.HARVEST_LILIES_WITCHES) do
        local npc = GetNPCByID(npcId)
        if npc then
            npc:removeListener('HARVEST_LILIES')
            npc:clearPath()
            npc:setStatus(xi.status.DISAPPEAR)
        end
    end

    for _, player in pairs(zone:getPlayers()) do
        clearRequest(player)
    end
end

return lilies
