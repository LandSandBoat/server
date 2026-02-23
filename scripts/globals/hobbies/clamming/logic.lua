-----------------------------------
-- Clamming Logic
-----------------------------------
xi = xi or {}
xi.clamming = xi.clamming or {}
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
local function giveClammedItems(player)
    for itemId, _ in pairs(xi.clamming.itemData) do
        local varName    = xi.clamming.itemData[itemId][2]
        local itemAmount = player:getLocalVar(varName)

        if itemAmount > 0 then
            if player:addItem(itemId, itemAmount) then
                player:messageSpecial(ID.text.YOU_OBTAIN, itemId, itemAmount)
                player:setLocalVar(varName, 0)
            else
                player:messageSpecial(ID.text.WHOA_HOLD_ON_NOW)
                player:setLocalVar('[Clam]OweItems', 1)
                break
            end
        end
    end
end

local function emptyBucket(player)
    for itemId, _ in pairs(xi.clamming.itemData) do
        local varName = xi.clamming.itemData[itemId][2]
        player:setLocalVar(varName, 0)
    end
end

local function resetVariables(player)
    -- Reset regular variables.
    player:setCharVar('[Clam]KitBroken', 0)
    player:setCharVar('[Clam]KitSize', 0)
    player:setCharVar('[Clam]KitWeight', 0)
    player:setLocalVar('[Clam]Delay', 0)
    player:setLocalVar('[Clam]OweItems', 0)

    -- Reset item variables.
    for itemId, _ in pairs(xi.clamming.itemData) do
        player:setLocalVar(xi.clamming.itemData[itemId][2], 0)
    end
end

-----------------------------------
-- Clamming Point public functions.
-----------------------------------
xi.clamming.nodeOnTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.CLAMMING_KIT) then
        player:messageSpecial(ID.text.AREA_IS_LITTERED)
        return
    end

    if GetSystemTime() < player:getLocalVar('[Clam]Delay') then
        player:messageSpecial(ID.text.IT_LOOKS_LIKE_SOMEONE)
        return
    end

    player:startEvent(xi.clamming.npcEvent[npc:getName()], 0, 0, 0, 0, 0, 0, 0, 0)
end

xi.clamming.nodeOnEventUpdate = function(player, csid, option, npc)
    -- Early return: Incorrect event ID.
    if csid ~= xi.clamming.npcEvent[npc:getName()] then
        return
    end

    -- Early return: No Clamming Kit.
    if not player:hasKeyItem(xi.ki.CLAMMING_KIT) then
        return
    end

    -- Early return: Clamming Kit is broken.
    if player:getCharVar('[Clam]KitBroken') > 0 then
        player:messageSpecial(ID.text.YOU_CANNOT_COLLECT)
        player:updateEvent(player:getCharVar('[Clam]KitWeight'), player:getCharVar('[Clam]KitSize'), 0)
        return
    end

    -- Check "Incidents"
    local kitSize        = player:getCharVar('[Clam]KitSize')
    local kitWeight      = player:getCharVar('[Clam]KitWeight')
    local incidentChance = player:getMod(xi.mod.CLAMMING_REDUCED_INCIDENTS) > 0 and 5 or 10
    if
        kitSize == 200 and
        math.random(1, 100) <= incidentChance
    then
        -- SE seems to add 10000 to the previous weight if Alraune had stolen your stuff.
        -- A weight higher than your capacity prevents the CS performing the clamming animation.
        player:setCharVar('[Clam]KitBroken', 1)
        player:setCharVar('[Clam]KitWeight', kitWeight + 10000)
        emptyBucket(player)
        player:messageSpecial(ID.text.SOMETHING_JUMPS_INTO)
        player:updateEvent(kitWeight, kitSize, 1)
        return
    end

    -- Fetch loot list and select rate column.
    local lootList   = xi.clamming.lootTable[npc:getName()]
    local rateColumn = player:getMod(xi.mod.CLAMMING_IMPROVED_RESULTS) > 0 and 1 or 0

    -- Calculate total loot rate.
    local rateSum    = 0
    for i = 1, #lootList do
        rateSum = rateSum + lootList[i][2 + rateColumn]
    end

    -- Roll based on rate sum and decide clammed item.
    local itemId     = 0
    local randomRoll = math.random(1, rateSum)
    for i = 1, #lootList do
        if lootList[i][2 + rateColumn] <= randomRoll then
            itemId = lootList[i][1]
            break
        end
    end

    -- Fetch clammed item data.
    local itemWeight = xi.clamming.itemData[itemId][1]
    local varName    = xi.clamming.itemData[itemId][2]

    -- Check weight limit.
    if kitWeight + itemWeight > kitSize then
        player:setCharVar('[Clam]KitBroken', 1)
        player:messageSpecial(ID.text.THE_WEIGHT_IS_TOO_MUCH, itemId)
        emptyBucket(player)

    -- Add item to bucket.
    else
        player:setLocalVar(varName, player:getLocalVar(varName) + 1)
        player:messageSpecial(ID.text.YOU_FIND_ITEM, itemId)
    end

    -- Update delay and weight, no matter the result.
    player:setCharVar('[Clam]KitWeight', kitWeight + itemWeight)
    player:setLocalVar('[Clam]Delay', GetSystemTime() + 10)
end

xi.clamming.nodeOnEventFinish = function(player, csid, option, npc)
end

-----------------------------------
-- Toh Zonikki NPC public functions.
-----------------------------------
xi.clamming.zonikkiOnTrigger = function(player, npc)
    -- Clamming started.
    if player:hasKeyItem(xi.ki.CLAMMING_KIT) then
        -- Bucket is broken.
        if player:getCharVar('[Clam]KitBroken') ~= 0 then
            player:startEvent(30, 0, 0, 0, 0, 0, 0, 0, 0)

        -- Bucket is not broken.
        else
            player:startEvent(29, 0, 0, 0, 0, 0, 0, 0, 0)
        end

    -- Clamming not started.
    else
        -- Previous clamming session interrupted.
        if player:getLocalVar('[Clam]OweItems') ~= 0 then
            player:messageSpecial(ID.text.YOU_GIT_YER_BAG_READY)
            giveClammedItems(player)

        -- Start clamming.
        else
            player:startEvent(28, 500, 0, 0, 0, 0, 0, 0, 0)
        end
    end
end

xi.clamming.zonikkiOnEventUpdate = function(player, csid, option, npc)
    -- Start Clamming.
    if csid == 28 then
        local enoughMoney = player:getGil() >= 500 and 1 or 2
        player:updateEvent(xi.ki.CLAMMING_KIT, enoughMoney, 0, 0, 0, 500, 0, 0)

    -- Give items or upgrade kit.
    elseif csid == 29 then
        local kitWeight = player:getCharVar('[Clam]KitWeight')
        local kitSize   = player:getCharVar('[Clam]KitSize')

        player:updateEvent(kitWeight, kitSize, kitSize, kitSize + 50, 0, 0, 0, 0)
    end
end

xi.clamming.zonikkiOnEventFinish = function(player, csid, option, npc)
    -- Give 50pz clamming kit.
    if csid == 28 and option == 1 then
        if player:getGil() < 500 then
            return
        end

        resetVariables(player) -- Ensure default state.
        player:setCharVar('[Clam]KitSize', 50)
        player:delGil(500)
        npcUtil.giveKeyItem(player, xi.ki.CLAMMING_KIT)

    -- Give player clammed items.
    elseif csid == 29 and option == 2 then
        player:setCharVar('[Clam]KitSize', 0)
        player:setCharVar('[Clam]KitWeight', 0)
        player:delKeyItem(xi.ki.CLAMMING_KIT)
        player:messageSpecial(ID.text.YOU_RETURN_THE, xi.ki.CLAMMING_KIT)
        giveClammedItems(player)

    -- Get bigger kit.
    elseif csid == 29 and option == 3 then
        local kitSize   = player:getCharVar('[Clam]KitSize')
        local kitWeight = player:getCharVar('[Clam]KitWeight')
        if kitSize >= 200 then
            printf('[Clamming] Player %s attempted to increase kit size capacity over the possible limit.', player:getName())
            return
        elseif kitSize == 150 and kitWeight < 145 then
            printf('[Clamming] Player %s attempted to increase kit size capacity without weight requirement.', player:getName())
            return
        elseif kitSize == 100 and kitWeight < 95 then
            printf('[Clamming] Player %s attempted to increase kit size capacity without weight requirement.', player:getName())
            return
        elseif kitSize == 50 and kitWeight < 45 then
            printf('[Clamming] Player %s attempted to increase kit size capacity without weight requirement.', player:getName())
            return
        end

        player:setCharVar('[Clam]KitSize', kitSize + 50)
        player:messageSpecial(ID.text.YOUR_CLAMMING_CAPACITY, 0, 0, kitSize + 50)

    -- Broken bucket.
    elseif csid == 30 then
        resetVariables(player)
        player:delKeyItem(xi.ki.CLAMMING_KIT)
        player:messageSpecial(ID.text.YOU_RETURN_THE, xi.ki.CLAMMING_KIT)
    end
end
