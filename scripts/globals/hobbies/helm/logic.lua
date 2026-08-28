-----------------------------------
-- Harvesting, Excavation, Logging, Mining
-- https://ffxiclopedia.wikia.com/wiki/Harvesting
-- https://ffxiclopedia.wikia.com/wiki/Excavation
-- https://ffxiclopedia.wikia.com/wiki/Logging
-- https://ffxiclopedia.wikia.com/wiki/Mining
-----------------------------------
require('scripts/globals/hobbies/helm/data')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/roe')
require('scripts/missions/amk/helpers')
require('scripts/missions/wotg/helpers')
-----------------------------------
xi = xi or {}
xi.helm = xi.helm or {}

-----------------------------------
-- colored rocks array
-----------------------------------

local rocks =
{
    [xi.element.FIRE   ] = xi.item.RED_ROCK,
    [xi.element.ICE    ] = xi.item.TRANSLUCENT_ROCK,
    [xi.element.WIND   ] = xi.item.GREEN_ROCK,
    [xi.element.EARTH  ] = xi.item.YELLOW_ROCK,
    [xi.element.THUNDER] = xi.item.PURPLE_ROCK,
    [xi.element.WATER  ] = xi.item.BLUE_ROCK,
    [xi.element.LIGHT  ] = xi.item.WHITE_ROCK,
    [xi.element.DARK   ] = xi.item.BLACK_ROCK,
}

-----------------------------------
-- local functions
-----------------------------------

local breakMods =
{
    [xi.helmType.HARVESTING] = { xi.mod.HARVESTING_RESULT_NQ, xi.mod.HARVESTING_RESULT_HQ },
    [xi.helmType.LOGGING]    = { xi.mod.LOGGING_RESULT_NQ, xi.mod.LOGGING_RESULT_HQ },
    [xi.helmType.MINING]     = { xi.mod.MINING_RESULT_NQ, xi.mod.MINING_RESULT_HQ },
    [xi.helmType.EXCAVATION] = nil,
}

local function getDropWeight(player, zoneId, zoneInfo, drop)
    local itemId = drop[2]
    local weight = drop[1]

    -- Daily caps reduce one item's weight per obtain and reset on zone-in after JST midnight.
    local limit = zoneInfo.dailyCap and zoneInfo.dailyCap[itemId]
    if limit then
        local obtained = player:getCharVar(string.format('[HELM]DailyCap[%u][%u]', zoneId, itemId))
        if obtained >= limit then
            return 0
        end

        weight = math.floor(weight / (obtained + 1))
    end

    -- Depletion reduces every pool member's weight using a shared count that resets on zoning.
    local depletion = zoneInfo.depletion
    if depletion and utils.contains(itemId, depletion.pool) then
        local obtained = player:getCharVar(string.format('[HELM][Depletion][%u]', zoneId))
        if obtained >= depletion.max then
            return 0
        end

        weight = math.floor(weight * (depletion.max - obtained) / depletion.max)
    end

    return weight
end

local function incrementDailyCap(player, zoneId, zoneInfo, itemId)
    local dailyCap = zoneInfo.dailyCap
    local limit    = dailyCap and dailyCap[itemId]
    if not limit then
        return
    end

    local capVar   = string.format('[HELM]DailyCap[%u][%u]', zoneId, itemId)
    local resetVar = string.format('[HELM]DailyCap[%u][ResetTime]', zoneId)
    local obtained = math.min(player:getCharVar(capVar) + 1, limit)

    if player:getCharVar(resetVar) == 0 then
        player:setCharVar(resetVar, JstMidnight())
    end

    player:setCharVar(capVar, obtained)
end

local function incrementDepletion(player, zoneId, zoneInfo, itemId)
    local depletion = zoneInfo.depletion
    if not depletion or not utils.contains(itemId, depletion.pool) then
        return
    end

    local depletionVar = string.format('[HELM][Depletion][%u]', zoneId)
    local obtained     = math.min(player:getCharVar(depletionVar) + 1, depletion.max)

    player:setCharVar(depletionVar, obtained)
end

local function hasCampPenalty(player, npc, helmType)
    local positionIndex = npc:getLocalVar('[HELM]PositionIndex')
    if positionIndex == 0 then
        return false
    end

    local penaltyVar   = string.format('[HELM][%u]Penalty', helmType)
    local penaltyValue = player:getCharVar(penaltyVar)
    if penaltyValue == 0 then
        return false
    end

    if penaltyValue == positionIndex then
        return true
    end

    -- Reaching a different HELM position clears the previous camp penalty.
    player:setCharVar(penaltyVar, 0)
    return false
end

---@param player CBaseEntity
---@param npc CBaseEntity
---@param info table
---@param helmType xi.helmType
---@return boolean
local function doesToolBreak(player, npc, info, helmType)
    local roll        = math.randomFloat(0, 100)
    local mods        = breakMods[helmType]
    local breakChance = info.zone[player:getZoneID()].breakRate

    -- Camp penalties and gear reductions are independent multipliers.
    if hasCampPenalty(player, npc, helmType) then
        breakChance = breakChance * info.campMultiplier
    end

    if mods and mods[1] and mods[2] then
        local nqMultiplier = 0.893 ^ math.max(player:getMod(mods[1]), 0)
        local hqMultiplier = 0.843 ^ math.max(player:getMod(mods[2]), 0)

        breakChance = breakChance * nqMultiplier * hqMultiplier
    end

    if roll < breakChance then
        player:tradeComplete()
        return true
    end

    return false
end

local function pickItem(player, info)
    local zoneId   = player:getZoneID()
    local zoneInfo = info.zone[zoneId]
    local minLevel = zoneInfo.minLevel or 0

    -- some zones award nothing below a level requirement, the tool still breaks
    if player:getMainLvl() < minLevel then
        return 0
    end

    -- found nothing
    if math.randomFloat(0, 100) >= zoneInfo.obtainRate then
        return 0
    end

    -- possible drops
    local drops   = zoneInfo.drops
    local weights = {}

    -- sum weights
    local sum = 0
    for i = 1, #drops do
        weights[i] = getDropWeight(player, zoneId, zoneInfo, drops[i])
        sum = sum + weights[i]
    end

    -- pick weighted result
    local item = 0
    local pick = math.randomInt(1, sum)
    sum = 0

    for i = 1, #drops do
        sum = sum + weights[i]
        if sum >= pick then
            item = drops[i][2]
            break
        end
    end

    -- if we picked a colored rock, change it to the day's element
    if item == xi.item.RED_ROCK then
        item = rocks[VanadielDayElement()]
    end

    return item
end

local function movePoint(player, npc, zoneId, info, helmType)
    if player then
        local positionIndex = npc:getLocalVar('[HELM]PositionIndex')
        if positionIndex > 0 then
            player:setCharVar(string.format('[HELM][%u]Penalty', helmType), positionIndex)
        end
    end

    local points        = info.zone[zoneId].points
    local positionIndex = math.randomInt(1, #points)
    local point         = points[positionIndex]

    npc:hideNPC(120)
    npc:queue(3000, function(entity)
        entity:setPos(point[1], point[2], point[3], 0)
        entity:setLocalVar('[HELM]PositionIndex', positionIndex)
    end)
end

-----------------------------------
-- public functions
-----------------------------------

xi.helm.initZone = function(zone, helmType)
    local zoneId = zone:getID()
    local info   = xi.helm.dataTable[helmType]
    local npcs   = zones[zoneId].npc[info.id]

    for _, npcId in ipairs(npcs) do
        local npc = GetNPCByID(npcId)
        if npc then
            npc:setStatus(xi.status.NORMAL)
            movePoint(nil, npc, zoneId, info, helmType)
        end
    end
end

xi.helm.onZoneIn = function(player)
    local zoneId    = player:getZoneID()
    local capPrefix = string.format('[HELM]DailyCap[%u]', zoneId)
    local resetTime = player:getCharVar(capPrefix .. '[ResetTime]')
    if resetTime == 0 or GetSystemTime() < resetTime then
        return
    end

    -- The new daily pool is applied on zone-in, not while the player remains in the zone.
    player:clearVarsWithPrefix(capPrefix)
end

xi.helm.onZoneOut = function(player)
    if player:getStatus() == xi.status.SHUTDOWN then
        return
    end

    player:clearVarsWithPrefix('[HELM][')
end

xi.helm.result = function(player, helmType, broke, itemID)
    local zoneId = player:getZoneID()

    -- Quest: Vanishing Act
    if
        helmType == xi.helmType.HARVESTING and
        player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.VANISHING_ACT) == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.RAINBOW_BERRY) and
        broke ~= 1 and
        zoneId == xi.zone.WAJAOM_WOODLANDS
    then
        npcUtil.giveKeyItem(player, xi.ki.RAINBOW_BERRY)
    end

    -- AMK mission 4 (index 3)
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.helmTrade(player, helmType, broke)
    end

    -- Item results
    if itemID > 0 then
        -- Egg-Hunt Extravaganza Event
        if xi.events and xi.events.eggHunt then
            xi.events.eggHunt.helmResult(player)
        end

        -- Records of Eminence
        player:triggerRoeEvent(xi.roeTrigger.HELM_SUCCESS, { ['skillType'] = helmType })
    end
end

xi.helm.onTrade = function(player, npc, trade, helmType, csid, func)
    local info   = xi.helm.dataTable[helmType]
    local zoneId = player:getZoneID()

    -- HELM should remove invisible
    player:delStatusEffect(xi.effect.INVISIBLE)

    if trade:hasItemQty(info.tool, 1) and trade:getItemCount() == 1 then
        -- Forced wait between gathering attempts
        if xi.settings.main.ENABLE_HELM_WAIT then
            local now = GetSystemTime()

            if now < player:getLocalVar('[HELM]LastAttempt') + 3 then
                return
            end

            player:setLocalVar('[HELM]LastAttempt', now)
        end

        -- start event
        local itemID = pickItem(player, info)
        local broke  = doesToolBreak(player, npc, info, helmType) and 1 or 0
        local full   = (player:getFreeSlotsCount() == 0) and 1 or 0

        -- Cutscene plays the emote in all zones but Adoulin.
        -- Adoulin uses emote packets.
        if csid then
            player:sendEmote(npc, info.animation, xi.emoteMode.MOTION, true) -- true to send emote to other players only
            player:startEvent(csid, itemID, broke, full)
        else
            player:sendEmote(npc, info.animation, xi.emoteMode.MOTION, false) -- False to send emote to everyone
        end

        -- WotG : The Price of Valor; Success does not award an item, but only KI.
        if xi.wotg.helpers.helmTrade(player, helmType, broke) then
            return
        end

        -- no item obtained if inventory is full
        if full == 1 then
            itemID = 0
        end

        -- success! reward item and roll to relocate the point
        if itemID ~= 0 then
            if player:addItem(itemID) then
                incrementDailyCap(player, zoneId, info.zone[zoneId], itemID)
                incrementDepletion(player, zoneId, info.zone[zoneId], itemID)
            end

            if math.randomInt(1, 100) <= info.relocateRate then
                movePoint(player, npc, zoneId, info, helmType)
            end
        end

        xi.helm.result(player, helmType, broke, itemID)

        if type(func) == 'function' then
            func(player)
        end
    else
        player:messageSpecial(zones[zoneId].text[info.message], info.tool)
    end
end

xi.helm.onTrigger = function(player, helmType)
    local zoneId = player:getZoneID()
    local info = xi.helm.dataTable[helmType]
    player:messageSpecial(zones[zoneId].text[info.message], info.tool)
end

xi.helm.weatherChange = function(currentWeather, neededWeather, pointTable)
    local status = xi.status.DISAPPEAR
    if utils.contains(currentWeather, neededWeather) then
        status = xi.status.NORMAL
    end

    for point = 1, #pointTable do
        local npcEntity = GetNPCByID(pointTable[point])
        if npcEntity and npcEntity:getStatus() ~= status then
            npcEntity:setStatus(status)
        end
    end
end
