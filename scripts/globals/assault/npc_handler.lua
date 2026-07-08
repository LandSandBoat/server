-----------------------------------
-- Assault Mission NPC Handler Functions (Rytaal / Mission Givers)
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
xi = xi or {}
xi.assault = xi.assault or {}
-----------------------------------

-----------------------------------
-- Mission Giver Functions
-----------------------------------

xi.assault.onMissionGiverTrigger = function(player, npc, eventOffset, assaultArea)
    local rank             = xi.besieged.getMercenaryRank(player)
    local hasimperialIDtag = player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG) and 1 or 0
    local assaultPoints    = player:getAssaultPoint(assaultArea)
    local active           = xi.extravaganza.campaignActive()
    local cipher           = 0

    if
        active == xi.extravaganza.campaign.SPRING_FALL or
        active == xi.extravaganza.campaign.BOTH
    then
        cipher = 1
    end

    -- If the player is eligible for Assaults, show them the menu. Otherwise, show them the "not eligible" message.
    if rank > 0 then
        player:startEvent(eventOffset, rank, hasimperialIDtag, assaultPoints, player:getCurrentAssault(), cipher)
    else
        player:startEvent(eventOffset + 6)
    end
end

xi.assault.onMissionGiverUpdate = function(player, csid, option, npc, eventOffset, assaultArea)
    local selectiontype = bit.band(option, 0xF)
    local shop          = xi.assault.shops[assaultArea]

    if
        csid == eventOffset and
        selectiontype == 2
    then
        local item   = bit.rshift(option, 14)
        local choice = shop[item]
        if not choice then
            return
        end

        local assaultPoints = player:getAssaultPoint(assaultArea)
        local canEquip      = player:canEquipItem(choice.itemid) and 2 or 0

        player:updateEvent(0, 0, assaultPoints, 0, canEquip)
    end
end

xi.assault.onMissionGiverEventFinish = function(player, csid, option, npc, eventOffset, assaultArea)
    if csid == eventOffset then
        local selectiontype = bit.band(option, 0xF)
        local shop          = xi.assault.shops[assaultArea]

        -- Player selected assault mission
        if
            selectiontype == 1 and
            npcUtil.giveKeyItem(player, xi.assault.areaData[assaultArea].orders)
        then
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(xi.assault.areaData[assaultArea].map)

        -- Player selected to purchase an item
        elseif selectiontype == 2 then
            local item = bit.rshift(option, 14)
            local choice = shop[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delAssaultPoint(assaultArea, choice.price)
            end
        end
    end
end

-----------------------------------
-- Rytaal Functions
-----------------------------------

local function handleAssaultFinish(player, currentAssault)
    -- Assault complete is set to 1 on assault or nyzul win
    if player:getCharVar('AssaultComplete') == 1 then
        player:messageText(player, ID.text.ASSAULT_COMPLETE)
        player:completeAssault(currentAssault)

    elseif currentAssault == xi.assault.mission.NYZUL_ISLE_INVESTIGATION then
        player:messageText(player, ID.text.NYZUL_FAIL)
        player:delAssault(currentAssault)

    else
        player:messageText(player, ID.text.ASSAULT_FAILED)
        player:delAssault(currentAssault)
    end

    for mapId = xi.ki.MAP_OF_LEUJAOAM_SANCTUM, xi.ki.MAP_OF_NYZUL_ISLE do
        if player:hasKeyItem(mapId) then
            player:delKeyItem(mapId)
        end
    end

    player:setCharVar('AssaultComplete', 0)
    player:setCharVar('AssaultFailed', 0)
    player:setCharVar('assaultEntered', 0)
    player:setCharVar('Assault_Armband', 0)

    for _, orders in ipairs(xi.assault.assaultOrders) do
        if player:hasKeyItem(orders) then
            player:delKeyItem(orders)
        end
    end
end

-- Max of 4 assault tags upon completion of all assaults and Second Lieutenant rank
local function getMaxTagStock(player)
    if xi.besieged.getMercenaryRank(player) < xi.assault.mercenaryRank.SECOND_LIEUTENANT then
        return 3
    end

    for missionID = 1, xi.assault.mission.NYZUL_ISLE_INVESTIGATION do
        if not player:hasCompletedAssault(missionID) then
            return 3
        end
    end

    return 4
end

local function initializeTagStock(player, maxTagStock)
    local tagStock    = player:getCurrency('id_tags')
    local tagDrawTime = player:getCharVar('tagDrawTime') -- Time when the player last drew a tag from a full stock; 0 if no timer is running

    if tagStock == 0 and tagDrawTime == 0 and player:getCharVar('tagStockInitialized') == 0 then
        player:setCurrency('id_tags', maxTagStock)
        player:setCharVar('tagStockInitialized', 1)
        return maxTagStock
    end

    return tagStock
end

local function applyMaxStockBonus(player, maxTagStock, tagStock)
    -- Player obtains a one time extra assault tag when first completing all assault missions
    if
        maxTagStock == 4 and
        player:getCharVar('assaultMaxStockGranted') == 0
    then
        tagStock = math.min(maxTagStock, tagStock + 1)
        player:setCurrency('id_tags', tagStock)
        player:setCharVar('assaultMaxStockGranted', 1)
    end

    return tagStock
end

local function replenishFromTimer(player, tagStock, maxTagStock, idTagPeriod)
    local tagDrawTime = player:getCharVar('tagDrawTime')

    -- Award one tag per elapsed restock period since the last full tag draw
    if
        tagDrawTime > 0 and
        tagStock < maxTagStock
    then
        local periodsElapsed = math.floor((GetSystemTime() - tagDrawTime) / idTagPeriod)
        if periodsElapsed > 0 then
            local periodsToApply = math.min(periodsElapsed, maxTagStock - tagStock)
            tagStock             = tagStock + periodsToApply

            -- Stop the timer when stock reaches the cap
            if tagStock >= maxTagStock then
                tagDrawTime = 0
            else
                tagDrawTime = tagDrawTime + periodsToApply * idTagPeriod
            end

            player:setCurrency('id_tags', tagStock)
            player:setCharVar('tagDrawTime', tagDrawTime)
        end
    elseif
        tagDrawTime > 0 and
        tagStock == maxTagStock
    then
        tagDrawTime = 0
        player:setCharVar('tagDrawTime', 0)
    end

    local vanaEpoch     = 1009810800 -- Vanadiel epoch time base for restock timer
    local allTagsTimeCS = tagDrawTime > 0 and (tagDrawTime - vanaEpoch) or 0 -- Timestamp passed to event to display the restock timer

    return tagStock, allTagsTimeCS
end

local function calculateTags(player)
    local idTagPeriod = player:hasKeyItem(xi.ki.RHAPSODY_IN_AZURE) and 600 or 86400 -- Restock is 1 tag per day, or 1 tag per 10 minutes with Rhapsody in Azure equipped
    local maxTagStock = getMaxTagStock(player)
    local tagStock    = initializeTagStock(player, maxTagStock)
    tagStock          = applyMaxStockBonus(player, maxTagStock, tagStock)

    return replenishFromTimer(player, tagStock, maxTagStock, idTagPeriod)
end

xi.assault.onRytaalTrigger = function(player, npc)
    local currentAssault = player:getCurrentAssault()

    -- Player isn't high enough level or hasn't progressed far enough in TOAU to access Assaults
    if
        player:getMainLvl() < 50 or
        player:getCurrentMission(xi.mission.log_id.TOAU) <= xi.mission.id.toau.IMMORTAL_SENTRIES
    then
        player:startEvent(270)

        return
    end

    -- Player has returned from an assault, handle completion
    if
        currentAssault ~= 0 and
        (player:getCharVar('assaultEntered') ~= 0 or
        player:getCharVar('AssaultComplete') == 1 or
        player:getCharVar('AssaultFailed') == 1)
    then
        handleAssaultFinish(player, currentAssault)

        return
    end

    -- Player has not started an assault, give them a tag
    local tagStock, allTagsTimeCS = calculateTags(player)
    local tagsAvail               = tagStock > 0 and 1 or 0
    local haveimperialIDtag       = player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG) and 1 or 0
    player:startEvent(268, 2, tagStock, currentAssault, haveimperialIDtag, allTagsTimeCS, tagsAvail)
end

xi.assault.onRytaalEventFinish = function(player, csid, option, npc)
    -- Early return if not assault tag related event
    if csid ~= 268 then
        return
    end

    -- Player selected to obtain a new tag
    if
        option == 1 and
        not player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
    then
        local tagStock = player:getCurrency('id_tags')
        if tagStock == 0 then
            return
        end

        if player:getCurrentAssault() ~= 0 then
            player:messageSpecial(ID.text.CANNOT_ISSUE_TAG, xi.ki.IMPERIAL_ARMY_ID_TAG)

            return
        end

        npcUtil.giveKeyItem(player, xi.ki.IMPERIAL_ARMY_ID_TAG)
        player:setCharVar('tagStockInitialized', 1)

        -- Start the replenishment timer only when taking from a full stock
        if tagStock == getMaxTagStock(player) then
            player:setCharVar('tagDrawTime', GetSystemTime())
        end

        player:setCurrency('id_tags', tagStock - 1)

    -- Player selected selected to end an assault
    elseif
        option == 2 and
        xi.assault.hasOrders(player) and
        not player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
    then
        local currentAssault = player:getCurrentAssault()
        for _, orders in ipairs(xi.assault.assaultOrders) do
            if player:hasKeyItem(orders) then
                player:delKeyItem(orders)
            end
        end

        npcUtil.giveKeyItem(player, xi.ki.IMPERIAL_ARMY_ID_TAG)
        player:delAssault(currentAssault)
    end
end
