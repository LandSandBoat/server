-----------------------------------
-- Harvest Festival party games and shops
-- https://wiki.ffo.jp/html/6082.html
-- https://wikiwiki.jp/ffxi/%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88/%E3%83%8F%E3%83%AD%E3%82%A6%E3%82%A3%E3%83%B32005
-- https://wikiwiki.jp/ffxi/%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88/%E3%83%8F%E3%83%AD%E3%82%A6%E3%82%A3%E3%83%B32006
-----------------------------------
local games = {}

local zoneData =
{
    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        nation           = xi.nation.SANDORIA,
        model            = 1293,
        costumes         = { 'ghost', 'skeleton' },
        pitchfork        = 3,
        pitchforkPlusOne = 2,
        hint             = { 16.005, 2.101, 11.928, 31 },
        decorations      =
        {
            {   23.707,  2.101,  5.888, 241 },
            { -160.309, -2.000, 54.277, 189 },
            {  123.960,  0.000, 74.165,  70 },
        },
    },

    [xi.zone.NORTHERN_SAN_DORIA] =
    {
        nation           = xi.nation.SANDORIA,
        model            = 1293,
        costumes         = { 'hound', 'shadow' },
        pitchfork        = 4,
        pitchforkPlusOne = 2,
        shop             = { -224.000, 8.000, 49.000, 128 },
        decorations      =
        {
            {   72.461, -0.199,  38.364,  15 },
            { -234.197,  7.999,  18.006,  79 },
            {  -54.713, -0.199,  74.543, 216 },
            { -171.675,  0.000, 132.440,  66 },
        },
    },

    [xi.zone.BASTOK_MINES] =
    {
        nation           = xi.nation.BASTOK,
        model            = 1287,
        costumes         = { 'shadow', 'skeleton' },
        pitchfork        = 3,
        pitchforkPlusOne = 2,
        decorations      =
        {
            {   14.604, 0.000, -117.192, 197 },
            { -131.376, 0.000,  -70.763, 191 },
            {  -31.185, 0.000,  -27.635, 248 },
        },
    },

    [xi.zone.BASTOK_MARKETS] =
    {
        nation           = xi.nation.BASTOK,
        model            = 1287,
        costumes         = { 'ghost', 'hound' },
        pitchfork        = 1,
        pitchforkPlusOne = 4,
        hint             = { -273.711, -10.000, -105.820, 66 },
        decorations      =
        {
            { -121.028,  -4.000, -132.367, 81 },
            { -268.711, -10.000, -105.820, 66 },
            { -265.477, -12.021,  -49.714, 11 },
            { -253.768,   0.000,   83.622, 56 },
        },
    },

    [xi.zone.PORT_BASTOK] =
    {
        nation = xi.nation.BASTOK,
        shop   = { 122.139, 8.455, -36.424, 232 },
    },

    [xi.zone.WINDURST_WATERS] =
    {
        nation           = xi.nation.WINDURST,
        model            = 1294,
        costumes         = { 'hound', 'skeleton' },
        pitchfork        = 2,
        pitchforkPlusOne = 4,
        shop             = { -55.500, -3.500, 25.500, 79 },
        decorations      =
        {
            {  -36.290, -4.999,  94.177,  66 },
            { -112.090, -1.999,  40.740, 124 },
            {   10.325, -1.000,  22.868,  89 },
            {  142.420,  0.000, 153.543,   3 },
        },
    },

    [xi.zone.WINDURST_WOODS] =
    {
        nation           = xi.nation.WINDURST,
        model            = 1294,
        costumes         = { 'shadow', 'ghost' },
        pitchfork        = 2,
        pitchforkPlusOne = 3,
        hint             = { -57.2122, 1.8486, -69.2543, 170 },
        decorations      =
        {
            { -49.168,  1.853, -68.900, 208 },
            { -29.401, -2.500,   2.641,  26 },
            {  21.811, -5.249, 130.924,  12 },
        },
    },
}

local costumeFamilies =
{
    [365] = 'hound',
    [368] = 'ghost',
    [531] = 'shadow',
    [532] = 'shadow',
    [533] = 'shadow',
    [534] = 'shadow',
    [535] = 'shadow',
    [536] = 'shadow',
    [537] = 'shadow',
    [538] = 'shadow',
    [564] = 'skeleton',
    [673] = 'goblin',
}

local lanterns =
{
    [xi.nation.SANDORIA] = xi.item.PUMPKIN_LANTERN,
    [xi.nation.BASTOK]   = xi.item.BOMB_LANTERN,
    [xi.nation.WINDURST] = xi.item.MANDRAGORA_LANTERN,
}

local entities = {}

games.initializeZone = function(zone)
    local data = zoneData[zone:getID()]
    if not data or not data.decorations then
        return
    end

    -- The five-yalm radius is an estimate.
    local position = data.decorations[data.pitchfork]
    zone:registerSphericalTriggerArea(100, position[1], position[2], position[3], 5)

    position = data.decorations[data.pitchforkPlusOne]
    zone:registerSphericalTriggerArea(101, position[1], position[2], position[3], 5)
end

games.onTriggerAreaEnter = function(player, triggerArea)
    local zoneId        = player:getZoneID()
    local data          = zoneData[zoneId]
    local triggerAreaId = triggerArea:getTriggerAreaID()
    if
        not data or
        not data.decorations or
        (triggerAreaId ~= 100 and triggerAreaId ~= 101) or
        not xi.events.harvestFestival.isEnabled() or
        player:getPartySize() ~= 2
    then
        return
    end

    local party = player:getParty()
    if #party ~= 2 then
        return
    end

    local position = data.decorations[data.pitchfork]
    local costumes = data.costumes
    local reward   = xi.item.PITCHFORK
    if triggerAreaId == 101 then
        position = data.decorations[data.pitchforkPlusOne]
        costumes = { 'goblin', 'goblin' }
        reward   = xi.item.PITCHFORK_P1
    end

    for _, member in ipairs(party) do
        if
            member:getZoneID() ~= zoneId or
            member:checkDistance(position[1], position[2], position[3]) > 5
        then
            return
        end
    end

    local firstCostume  = party[1]:getStatusEffect(xi.effect.COSTUME)
    local secondCostume = party[2]:getStatusEffect(xi.effect.COSTUME)
    if not firstCostume or not secondCostume then
        return
    end

    local firstFamily  = costumeFamilies[firstCostume:getPower()]
    local secondFamily = costumeFamilies[secondCostume:getPower()]
    if
        not (firstFamily == costumes[1] and secondFamily == costumes[2]) and
        not (firstFamily == costumes[2] and secondFamily == costumes[1])
    then
        return
    end

    for _, member in ipairs(party) do
        ---@type integer?
        local memberReward = reward
        if member:hasItem(reward) then
            memberReward = reward == xi.item.PITCHFORK_P1 and xi.item.JACK_O_LANTERN or nil
        end

        -- Both members can enter during the same tick.
        if
            memberReward and
            member:getLocalVar('[HarvestFestival]PairRewardArea') ~= triggerAreaId and
            npcUtil.giveItem(member, memberReward)
        then
            member:setLocalVar('[HarvestFestival]PairRewardArea', triggerAreaId)
            if memberReward == xi.item.PITCHFORK then
                member:setCharVar('[HarvestFestival]PitchforkNation', data.nation + 1)
            end
        end
    end
end

games.onTriggerAreaLeave = function(player, triggerArea)
    if player:getLocalVar('[HarvestFestival]PairRewardArea') == triggerArea:getTriggerAreaID() then
        player:setLocalVar('[HarvestFestival]PairRewardArea', 0)
    end
end

games.getGoblinCostume = function(player, goblinNation)
    local data = zoneData[player:getZoneID()]
    if
        not data or
        not xi.events.harvestFestival.isEnabled() or
        goblinNation ~= player:getNation() or
        player:getEquipID(xi.slot.MAIN) ~= xi.item.PITCHFORK or
        player:getCharVar('[HarvestFestival]PitchforkNation') == data.nation + 1
    then
        return nil
    end

    return 673
end

games.onHintMoogleTrigger = function(player, npc)
    if not xi.events.harvestFestival.isEnabled() then
        return
    end

    player:showText(npc, zones[player:getZoneID()].text.HARVEST_PITCHFORK_HINT)
end

games.onMoogleTrigger = function(player, npc)
    local zoneId = player:getZoneID()
    local data = zoneData[zoneId]
    if
        not data or
        not data.shop or
        not xi.events.harvestFestival.isEnabled() or
        xi.settings.main.HALLOWEEN_YEAR ~= 2007
    then
        return
    end

    local stock = { { xi.item.JACK_O_LANTERN, 1000 } }
    local head  = player:getEquipID(xi.slot.HEAD)
    if head == xi.item.COVEN_HAT then
        table.insert(stock, { xi.item.PUMPKIN_LANTERN, 10000 })
        table.insert(stock, { xi.item.BOMB_LANTERN, 10000 })
        table.insert(stock, { xi.item.MANDRAGORA_LANTERN, 10000 })
    elseif head == xi.item.WITCH_HAT and player:getNation() == data.nation then
        table.insert(stock, { lanterns[data.nation], 10000 })
    end

    if #stock > 1 then
        player:showText(npc, zones[zoneId].text.HARVEST_SHOP_HAT)
    else
        player:showText(npc, zones[zoneId].text.HARVEST_SHOP)
    end

    xi.shop.general(player, stock)
end

local function insertMoogle(zone, name, position, onTrigger)
    return zone:insertDynamicEntity({
        objtype    = xi.objType.NPC,
        name       = name,
        packetName = 'Moogle',
        look       = 82,
        x          = position[1],
        y          = position[2],
        z          = position[3],
        rotation   = position[4],
        onTrigger  = onTrigger,
    })
end

games.setZoneEnabled = function(zone, enabled)
    local zoneId = zone:getID()
    local data   = zoneData[zoneId]
    if not data or (not enabled and not entities[zoneId]) then
        return
    end

    entities[zoneId] = entities[zoneId] or { decorations = {} }
    local zoneEntities = entities[zoneId]
    local status       = enabled and xi.status.NORMAL or xi.status.DISAPPEAR

    for index, position in ipairs(data.decorations or {}) do
        local npc = zoneEntities.decorations[index] and GetNPCByID(zoneEntities.decorations[index])
        if enabled and not npc then
            npc = zone:insertDynamicEntity({
                objtype     = xi.objType.NPC,
                name        = 'Harvest_Decoration_' .. index,
                look        = data.model,
                x           = position[1],
                y           = position[2],
                z           = position[3],
                rotation    = position[4],
                widescan    = 0,
                entityFlags = 2075,
                namevis     = 104,
            })

            if npc then
                zoneEntities.decorations[index] = npc:getID()
            end
        end

        if npc then
            npc:setStatus(status)
        end
    end

    if data.hint then
        local npc = zoneEntities.hint and GetNPCByID(zoneEntities.hint)
        if enabled and not npc then
            npc = insertMoogle(zone, 'Harvest_Hint_Moogle', data.hint, games.onHintMoogleTrigger)
            if npc then
                zoneEntities.hint = npc:getID()
            end
        end

        if npc then
            npc:setStatus(status)
        end
    end

    if data.shop then
        local shopEnabled = enabled and xi.settings.main.HALLOWEEN_YEAR == 2007
        local npc         = zoneEntities.shop and GetNPCByID(zoneEntities.shop)
        if shopEnabled and not npc then
            npc = insertMoogle(zone, 'Harvest_Shop_Moogle', data.shop, games.onMoogleTrigger)
            if npc then
                zoneEntities.shop = npc:getID()
            end
        end

        if npc then
            npc:setStatus(shopEnabled and xi.status.NORMAL or xi.status.DISAPPEAR)
        end
    end
end

return games
