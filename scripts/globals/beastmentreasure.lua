------------------------------------
-- Beastmen Treasure side quests
-- https://ffxiclopedia.fandom.com/wiki/Beastmen_Treasure
------------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/quests')
require('scripts/globals/status')
require('scripts/globals/zone')
------------------------------------
tpz = tpz or {}
tpz.beastmentreasure = tpz.beastmentreasure or {}

local zoneData = {
    [tpz.zone.YUHTUNGA_JUNGLE] =
    {
        statusvar = 'BMT_Lowlands_Status',
        dsvar = 'BMT_Lowlands_Digsite',
        mapid = tpz.ki.MAP_OF_THE_ELSHIMO_REGIONS,
        day = tpz.day.WINDSDAY,
        fetchitems =
        {
            1480, -- Mermaid Head
            1481, -- Mermaid Body
            1482, -- Mermaid Hands
            1483  -- Mermaid Tail
        },
        loot =
        {
            unique = {[14626] = 5}, -- Mermaid's Ring
            racial = {[887] = 3}    -- Coral Fragment
        }
    },
    [tpz.zone.YHOATOR_JUNGLE] =
    {
        statusvar = 'BMT_Uplands_Status',
        dsvar = 'BMT_Uplands_Digsite',
        mapid = tpz.ki.MAP_OF_THE_ELSHIMO_REGIONS,
        day = tpz.day.LIGHTNINGDAY,
        fetchitems =
        {
            1484, -- Rancor Mantle
            1485, -- Rancor Globe
            1486, -- Rancor Tank
            1487  -- Rancor Handle
        },
        loot =
        {
            unique = {[13400] = 5}, -- Bitter Earring
            racial = {[4158] = 3}   -- Venom Potion
        }
    },
    [tpz.zone.WESTERN_ALTEPA_DESERT] =
    {
        statusvar = 'BMT_Kuzotz_Status',
        dsvar = 'BMT_Kuzotz_Digsite',
        mapid = tpz.ki.MAP_OF_THE_KUZOTZ_REGION,
        day = tpz.day.EARTHSDAY,
        fetchitems =
        {
            1476, -- Xhifhut Strings
            1477, -- Xhifhut Body
            1478, -- Xhifhut Bow
            1479  -- Xhifhut Head
        },
        loot =
        {
            unique = {[13655] = 5}, -- Sand Mantle
            racial = {[645] = 3}    -- Darksteel Ore
        }
    }
}

local sharedLoot = {
    -- All items are assigned a "weight" here
    rocksgems =
    {
        [769] = 1, -- Red rock
        [770] = 1, -- Blue rock
        [771] = 1, -- Yellow rock
        [772] = 1, -- Green rock
        [773] = 1, -- Translucent rock
        [774] = 1, -- Purple rock
        [775] = 1, -- Black rock
        [776] = 1, -- White rock
        -- Tier 1 gems
        [795] = 2, -- Lapis Lazuli (blue)
        [796] = 2, -- Light Opal   (white)
        [799] = 2, -- Onyx         (black)
        [800] = 2, -- Amethyst     (purple)
        [806] = 2, -- Tourmaline   (green)
        [807] = 2, -- Sardonyx     (red)
        [809] = 2, -- Clear Topaz  (translucent)
        [814] = 2, -- Amber        (yellow)
    },
    seeds =
    {
        [572] = 1, -- Herb seeds
        [573] = 1, -- Vegetable seeds
        [574] = 1, -- Fruit seeds
        [575] = 1, -- Grain seeds
    },
    coins =
    {
        [748] = 1, -- Gold beastcoin
        [749] = 1, -- Mythril beastcoin
        [750] = 1, -- Silver beastcoin
    },
    seals =
    {
        [1126] = 2 -- Beastmen's Seal
    }
}

local function convertToWeighted(loot)
    -- Takes a loot table formatted like the members of `sharedloot` and returns a weighted version that can be indexed
    local weightedLoot = {}

    for item, weight in pairs(loot) do
        for i = 1, weight do
            table.insert(weightedLoot, item)
        end
    end

    return weightedLoot
end

local function addLoot(t1, t2)
    -- Used for non-destructively combining a table containing a single weighted item (`t2`)
    -- and an existing loot table containing one or more weighted items (`t1`).
    newTable = {}
    newItem = table.maxn(t2)

    -- Copy the contents of the first table so that we don't modify the global version
    for item, weight in pairs(t1) do
        newTable[item] = weight
    end
    -- Add in our new item
    newTable[newItem] = t2[newItem]

    return newTable
end

-- Generate weighted loot tables now (on server init) so it doesn't have to be done at runtime
local w_rocksgems   = convertToWeighted(sharedLoot.rocksgems)
local w_seedsracial =
{
    [tpz.zone.YUHTUNGA_JUNGLE] = convertToWeighted(addLoot(sharedLoot.seeds, zoneData[tpz.zone.YUHTUNGA_JUNGLE].loot.racial)),
    [tpz.zone.YHOATOR_JUNGLE] = convertToWeighted(addLoot(sharedLoot.seeds, zoneData[tpz.zone.YHOATOR_JUNGLE].loot.racial)),
    [tpz.zone.WESTERN_ALTEPA_DESERT] = convertToWeighted(addLoot(sharedLoot.seeds, zoneData[tpz.zone.WESTERN_ALTEPA_DESERT].loot.racial))
}
local w_coins       = convertToWeighted(sharedLoot.coins)
local w_sealsunique =
{
    [tpz.zone.YUHTUNGA_JUNGLE] = convertToWeighted(addLoot(sharedLoot.seals, zoneData[tpz.zone.YUHTUNGA_JUNGLE].loot.unique)),
    [tpz.zone.YHOATOR_JUNGLE] = convertToWeighted(addLoot(sharedLoot.seals, zoneData[tpz.zone.YHOATOR_JUNGLE].loot.unique)),
    [tpz.zone.WESTERN_ALTEPA_DESERT] = convertToWeighted(addLoot(sharedLoot.seals, zoneData[tpz.zone.WESTERN_ALTEPA_DESERT].loot.unique)),
}

local function weightedRandomSelect(w_loot)
    -- Takes a weighted loot table and returns a single random result
    return w_loot[math.random(#w_loot)]
end

local function getAssignedDigSite(player)
    -- Returns the player's assigned digsite for the zone they're currently in
    return player:getCharVar(zoneData[player:getZoneID()].dsvar)
end

local function startMapMarkerEvent(eventid, player, digsiteids)
    --[[ Map marker event notes:
        Event 101 creates the "Treasure" map marker using coordinate args
        Event 103 shows the "Treasure" map marker using coordinate args
        Event 105, played on excavation, deletes the "Treasure" map marker

        Parameters for events 101/103 are as follows:
            1: zone id
            2: unknown, seems static
            3: (x position of qm) * 1000
            4: (z position of qm) * 1000
            5: unknown, dynamic
            6: unknown, dynamic
            7: unknown, seems static
            8: unknown*, seems static (possibly y position of qm + 95)

        Example: `player:startEvent(101, 123, 0, 369795, 201805, 0, 0, 0, 4095)`
            ...plays event 101 in Yuhtunga Jungle (zone 123), which creates a map marker
            corresponding to the QM at position (369.795, 4.0, 201.805)
            Full args from a retail capture for this point were:
                101, 123, 32, 369795, 201805, 425920, 760, 529191, 4095
                103, 123, 32, 369795, 201805, 308060, 1694, 529191, 4095 ]]--
    local pos = GetNPCByID(digsiteids[getAssignedDigSite(player)]):getPos()

    player:startEvent(eventid, player:getZoneID(), 0, pos.x * 1000, pos.z * 1000)
end

tpz.beastmentreasure.handleNpcOnTrigger = function(player, digsiteids)
    local zd = zoneData[player:getZoneID()]
    local status = player:getCharVar(zd.statusvar)

    if not player:hasKeyItem(zd.mapid) then
        player:startEvent(102) -- Peddlestox lectures you for not having a map
    elseif status == QUEST_AVAILABLE then
        player:startEvent(100) -- Peddlestox says go fetch
    elseif status == QUEST_ACCEPTED then
        player:startEvent(104) -- "What do I look like, a charity?"
    elseif status == QUEST_COMPLETED then
        -- Note: Quest will be "completed" after trading the correct items,
        -- but will be set to available again after excavating the reward.
        startMapMarkerEvent(103, player, digsiteids) -- Peddlestox reminds you where your digsite is
    end
end

tpz.beastmentreasure.handleNpcOnTrade = function(player, trade, digsiteids)
    local zd = zoneData[player:getZoneID()]

    if player:getCharVar(zd.statusvar) == QUEST_ACCEPTED and npcUtil.tradeHasExactly(trade, zd.fetchitems) then
        -- Assign a random dig site to the player
        player:setCharVar(zd.dsvar, math.random(1, 8))

        startMapMarkerEvent(101, player, digsiteids) -- Peddlestox shows you where to dig
    end
end

tpz.beastmentreasure.handleNpcOnEventFinish = function(player, csid)
    local zd = zoneData[player:getZoneID()]

    if csid == 100 then
        player:addCharVar(zd.statusvar, QUEST_ACCEPTED)
    elseif csid == 101 then
        player:confirmTrade()
        player:setCharVar(zd.statusvar, QUEST_COMPLETED)
    end
end

tpz.beastmentreasure.updatePeddlestox = function(zone, peddlestox)
    --[[ Allows Peddlestox to appear on the appropriate day and disappear when the day is over.
    This function is called by each of the three zones where Peddlestox can appear: once on init,
    and once at the start of each new game day. Since Peddlestox is disabled in the db by default, we
    only need to enable her on the appropriate day and disable her on the following day. ]]--
    local peddlestox = GetNPCByID(peddlestox)

    if zoneData[zone].day == VanadielDayOfTheWeek() then
        peddlestox:setStatus(tpz.status.NORMAL)
    elseif peddlestox:getStatus() == tpz.status.NORMAL then
        --[[
        TODO: Peddlestox should play a teleport animation and then fade out. On retail this is an 0x03A
            packet with animation id 122. Currently 0x3A is not implemented in Topaz. Retail capture of
            the correct animation packet is as follows:
             |  0  1  2  3   4  5  6  7   8  9  A  B   C  D  E  F    | 0123456789ABCDEF
        -----+----------------------------------------------------  -+------------------
           0 | 3A 0A B5 00  67 B2 07 01  67 B2 07 01  67 02 67 02    | :...g...g...g.g.
          10 | 7A 00 00 BF                                           | z...
            An incomplete but similar 0x38 animation can be achieved with `entityAnimationPacket("shwh")`
        ]]--
        peddlestox:setStatus(tpz.status.DISAPPEAR)
    end
end

tpz.beastmentreasure.handleQmOnTrigger = function(player, npc, buriedtext, nothingtext, digsiteids)
    local digsiteid = digsiteids[getAssignedDigSite(player)]
    local qmid = npc:getID()

    if digsiteid == nil or digsiteid ~= qmid then
        player:messageSpecial(nothingtext)
    elseif digsiteid == qmid then
        -- "It looks like something is buried here. If you had a <pickaxe> you could dig it up."
        player:messageSpecial(buriedtext, 605)
    end
end

tpz.beastmentreasure.handleQmOnTrade = function(player, npc, trade, digsiteids)
    local zoneid = player:getZoneID()
    local digsite = getAssignedDigSite(player)

    if npcUtil.tradeHasExactly(trade, 605)
        and player:getCharVar(zoneData[zoneid].statusvar) == QUEST_COMPLETED
        and npc:getID() == digsiteids[digsite] then
            --[[ Event 105 needs args to spawn and animate a treasure chest
                 Example args from retail capture: 105 123 450762 1745 201805 7 723 490292 4095
                 An arg in the 5th parameter will spawn and animate a chest somewhere in the zone
                    based on some internal list in the game files. For example, an arg of 7, as
                    in the retail capture above, will spawn and animate a chest at Yuhtunga Jungle
                    qm10. Chests will spawn at a static location regardless of whether or not
                    coordinates are passed in, and will always be rotated to face the player.
            ]]--
            player:startEvent(105, zoneid, 0, 0, 0, digsite - 1)
    end
end

tpz.beastmentreasure.handleQmOnEventFinish = function(player, csid)
    local zoneid = player:getZoneID()

    if csid == 105 then
        -- Successfully excavating a dig site rewards 4000 gil plus the following items:
        -- First reward is 1 item from the rocks and gems pool
        local item1 = weightedRandomSelect(w_rocksgems)
        -- Second reward is 1 item from a pool containing seeds and the zone's "racial" junk
        local item2 = weightedRandomSelect(w_seedsracial[zoneid])
        -- Third reward is a silver, gold, or mythril beastcoin
        local item3 = weightedRandomSelect(w_coins)
        -- Final reward is a seal or the region's exclusive item
        local item4 = weightedRandomSelect(w_sealsunique[zoneid])
        -- Distribute rewards
        player:confirmTrade()
        player:addGil(4000)
        player:addTreasure(item1)
        player:addTreasure(item2)
        player:addTreasure(item3)
        player:addTreasure(item4)
        -- Reset player vars
        player:setCharVar(zoneData[zoneid].statusvar, QUEST_AVAILABLE)
        player:setCharVar(zoneData[zoneid].dsvar, 0)
    end
end

tpz.bmt = tpz.beastmentreasure
