-------------------------------------------
-- Magian trials
-------------------------------------------
require("scripts/globals/msg")
require("scripts/globals/zone")
require("scripts/globals/magianobjectives")

tpz = tpz or {}
tpz.magian = tpz.magian or {}
tpz.magian.trialCache = tpz.magian.trialCache or {}

-- creates table to track trial and progress per trial slot
local function readTrials(player)
    local activeTrials = tpz.magian.trialCache[player:getID()]
    if activeTrials then
        return activeTrials
    end
    activeTrials = {}
    for i = 1, 10 do
        local trialBits = player:getCharVar("[trial]" .. i)
        local id = bit.rshift(trialBits, 17)
        local pr = bit.band(trialBits, 0x1FFFF)
        activeTrials[i] = { trial = id, progress = pr }
    end
    tpz.magian.trialCache[player:getID()] = activeTrials
    return activeTrials
end

-- packs current trials into params for onTrigger
local function parseParams(player)
    local paramTrials = {}
    for _,v in pairs(readTrials(player)) do
        if v.trial > 0 then table.insert(paramTrials, v.trial) end
    end
    local params = {0,0,0,0,0}
    for i = 1, #paramTrials, 2 do
        params[(i+1)/2] = paramTrials[i] + bit.lshift((paramTrials[i+1] or 0), 16)
    end
    return params, #paramTrials
end

-- trial id and progress
local function getTrial(player, i)
    local activeTrials = readTrials(player)
    local progress = activeTrials[i] and activeTrials[i].progress
    local trial = activeTrials[i] and activeTrials[i].trial
    return trial, progress
end

-- packs trial id and trial progress
local function setTrial(player, slot, trialId, progress)
    local activeTrials = readTrials(player)
    if trialId == activeTrials[slot].trial and progress == activeTrials[slot].progress then
        return
    end
    activeTrials[slot].trial = trialId
    activeTrials[slot].progress = progress or 0
    local trialBits = bit.lshift(trialId,17) + progress
    player:setCharVar("[trial]" .. slot, trialBits)
end

-- finds empty trial slot
local function firstEmptySlot(player)
    for i, v in ipairs(readTrials(player)) do
        if v.trial == 0 then
            return i
        end
    end
end

local function hasTrial(player, number)
    if number == nil then return nil end
    for i, v in ipairs(readTrials(player)) do
        if v.trial == number then
            return i, v
        end
    end
    return false
end

-- increments progress if conditions are met
function tpz.magian.checkMagianTrial(player, conditions)
    local trials = tpz.magian.trials
    for _, slot in pairs( {tpz.slot.MAIN, tpz.slot.SUB, tpz.slot.RANGED} ) do
        local trialOnItem = player:getEquippedItem(slot) and player:getEquippedItem(slot):getTrialNumber()
        local cachePosition, cacheData = hasTrial(player, trialOnItem)
        if trialOnItem and cachePosition then
            if trials[trialOnItem] then
                local increment = trials[trialOnItem]:check(player, conditions)
                if increment > 0 then
                    local trialSQL = GetMagianTrial(trialOnItem)
                    if cacheData.progress < trialSQL.objectiveTotal then
                        local newProgress = math.min(cacheData.progress + increment, trialSQL.objectiveTotal)
                        local remainingObjectives = trialSQL.objectiveTotal - newProgress
                        setTrial(player, cachePosition, trialOnItem, newProgress)
                        if remainingObjectives == 0 then
                            player:messageBasic(tpz.msg.basic.MAGIAN_TRIAL_COMPLETE, trialOnItem) -- trial complete
                        else
                            player:messageBasic(tpz.msg.basic.MAGIAN_TRIAL_COMPLETE - 1, trialOnItem, remainingObjectives) -- trial <trialid>: x objectives remain
                        end
                    elseif cacheData.progress > trialSQL.objectiveTotal then
                        setTrial(player, cachePosition, trialOnItem, trialSQL.objectiveTotal)
                    end
                end
            end
        end
    end
end

-- builds augment params for required items
local function reqAugmentParams(t)
    local leftAug1 = bit.lshift(t.reqItemAugValue1, 11) + t.reqItemAug1
    local rightAug1 = bit.lshift(t.reqItemAugValue2, 11) + t.reqItemAug2
    local augBits1 = bit.lshift(leftAug1, 16) + rightAug1
    local leftAug2 = bit.lshift(t.reqItemAugValue3, 11) + t.reqItemAug3
    local rightAug2 = bit.lshift(t.reqItemAugValue4, 11) + t.reqItemAug4
    local augBits2 = bit.lshift(leftAug2, 16) + rightAug2
    return augBits1, augBits2
end

-- builds augment params for reward items
local function rewardAugmentParams(t)
    local leftAug1 = bit.lshift(t.rewardItemAugValue1, 11) + t.rewardItemAug1
    local rightAug1 = bit.lshift(t.rewardItemAugValue2, 11) + t.rewardItemAug2
    local augBits1 = bit.lshift(leftAug1, 16) + rightAug1
    local leftAug2 = bit.lshift(t.rewardItemAugValue3, 11) + t.rewardItemAug3
    local rightAug2 = bit.lshift(t.rewardItemAugValue4, 11) + t.rewardItemAug4
    local augBits2 = bit.lshift(leftAug2, 16) + rightAug2
    return augBits1, augBits2
end

-------------------
-- Magian Orange --
-------------------

function tpz.magian.magianOrangeOnTrigger(player, npc)
    local activeTrials = readTrials(player)
    local p, t = parseParams(player)

    if player:getMainLvl() < 75 then
        player:startEvent(10121) -- can't take a trial before lvl 75

    elseif player:hasKeyItem(tpz.ki.MAGIAN_TRIAL_LOG) == false then
        player:startEvent(10122) -- player can start magian for the first time

    else
        player:startEvent(10123,p[1],p[2],p[3],p[4],p[5],0,0,t) -- standard dialogue
    end
end

function tpz.magian.magianOrangeOnTrade(player,npc,trade)
    local itemId = trade:getItemId()
    local item = trade:getItem()
    local matchId = item:getMatchingTrials()
    local trialId = item:getTrialNumber()
    local t = GetMagianTrial(trialId)
    local zoneid = player:getZoneID()
    local msg = zones[zoneid].text
    local _, pt = parseParams(player)

    player:setLocalVar("storeItemId", itemId)

    if player:hasKeyItem(tpz.ki.MAGIAN_TRIAL_LOG) == true then
        if not next(matchId) and item:isType(tpz.itemType.WEAPON) then
            player:setLocalVar("invalidItem", 1)
            player:startEvent(10124,0,0,0,0,0,0,0,-1) -- invalid weapon
            return

        -- player can only keep 10 trials at once
        elseif pt >= 10 and trialId == 0 then
            player:startEvent(10124,0,0,0,0,0,0,0,-255)
            return

        elseif trialId ~= 0 then
            for i, v in pairs(readTrials(player)) do
                if v.trial == trialId then
                    player:setLocalVar("storeTrialId", trialId)
                    player:tradeComplete()
                    if v.progress >= t.objectiveTotal then
                        player:startEvent(10129,0,0,0,t.rewardItem,0,0,0,itemId) -- completes trial
                    else
                        player:startEvent(10125,trialId,itemId,0,0,v,0,0,-2) -- checks status of trial
                    end
                    return
                end
            end
                -- item has trial, player does not
                player:setLocalVar("storeTrialId", trialId)
                player:startEvent(10125,trialId,t.reqItem,0,0,0,0,0,-3)
                player:tradeComplete()
                return

        elseif next(matchId) then
            player:setLocalVar("storeTrialId", matchId[1])
            player:tradeComplete()
            player:startEvent(10124,matchId[1],matchId[2],matchId[3],matchId[4],0,itemId) -- starts trial
            return
        else
            player:messageSpecial(msg.ITEM_NOT_WEAPON_MAGIAN) -- item traded isn't a weapon
        end
    end
end

--[[
     - 00000 - 00000000000 - 00000 - 00000000000 -
       aug1     aug1 id      aug2     aug2 id
      value                 value
                                                  ]]--

rareItems = set{ 16192,18574,19397,19398,19399,19400,19401,19402,19403,19404,19405,19406,19407,19408,19409,19410 }

function tpz.magian.magianOrangeEventUpdate(player,itemId,csid,option)
    local optionMod = bit.band(option, 0xFF)

    -- 10123 = trigger, 10124 = initial trade, 10125 = in-progress trade
    if (csid == 10123 or csid == 10124 or csid == 10125) and optionMod == 1 then
        local trialId = bit.rshift(option, 16)
        local t = GetMagianTrial(trialId)
        local a1, a2 = reqAugmentParams(t)
        player:updateEvent(2,a1,a2,t.reqItem,0,0,t.trialTarget)

    elseif (csid == 10123 or csid == 10124 or csid == 10125) and optionMod == 2 then
        local trialId = bit.rshift(option, 16)
        local t = GetMagianTrial(trialId)
        local _,cacheData = hasTrial(player, trialId)
        local progress = cacheData and cacheData.progress or 0
        player:updateEvent(t.objectiveTotal,0,progress,0,0,t.element)

    elseif (csid == 10123 or csid == 10124 or csid == 10125) and optionMod == 3 then
        local trialId = bit.rshift(option, 16)
        local t = GetMagianTrial(trialId)
        local a1, a2 = rewardAugmentParams(t)
        player:updateEvent(2,a1,a2,t.rewardItem,0,t.objectiveItem)

    elseif (csid == 10123 or csid == 10124 or csid == 10125) and optionMod == 4 then
        local trialId = bit.rshift(option, 16)
        local t = GetMagianTrial(trialId)
        local results = GetMagianTrialsWithParent(trialId)
        player:updateEvent(results[1],results[2],results[3],results[4],t.previousTrial,t.objectiveItem)

    -- lists trials to abandon
    elseif csid == 10123 and optionMod == 5 then
        local params, trialCount = parseParams(player)
        player:updateEvent(params[1],params[2],params[3],params[4],params[5],0,0,trialCount)

    -- abandon trial through menu
    elseif csid == 10123 and optionMod == 6 then
        local trialId = bit.rshift(option, 8)
        local slot = hasTrial(player, trialId)
        if slot then
            player:updateEvent(0,0,0,0,0,slot)
            setTrial(player, slot, 0, 0)
        end

    -- checks if trial is already in progress
    elseif csid == 10124 and optionMod == 7 then
        local trialId = bit.rshift(option, 8)
        local t = GetMagianTrial(trialId)
        local a1, a2 = reqAugmentParams(t)
        local slot = hasTrial(player, trialId)
        if slot then
            player:updateEvent(0,0,0,0,0,0,0,-1)
            return
        end
        player:updateEvent(2,a1,a2,t.reqItem)

    -- checks if item's level will increase
    elseif csid == 10124 and optionMod == 13 then
        local trialId = bit.rshift(option, 8)
        local t = GetMagianTrial(trialId)
        local reqItem = GetItem(t.reqItem)
        local rewardItem = GetItem(t.rewardItem)
        if reqItem:getReqLvl() < rewardItem:getReqLvl() then
            player:updateEvent(1)
        else
            player:updateEvent(0)
        end

    -- checks if player already owns reward item (if it's rare)
    elseif csid == 10124 and optionMod == 14 then
        local trialId = bit.rshift(option, 8)
        local t = GetMagianTrial(trialId)
        if (player:hasItem(t.rewardItem) and rareItems[t.rewardItem] == true) then
            player:updateEvent(1)
        else
            player:updateEvent(0)
        end

    -- abandoning trial through trade
    elseif csid == 10125 and (optionMod == 8 or optionMod == 11) then
        local trialId = bit.rshift(option, 8)
        local t = GetMagianTrial(trialId)
        player:updateEvent(0,0,0,t.reqItem)
    end
end

function tpz.magian.magianOrangeOnEventFinish(player,itemId,csid,option)
    local optionMod = bit.band(option, 0xFF)
    local zoneid = player:getZoneID()
    local msg = zones[zoneid].text
    local ID = require("scripts/zones/RuLude_Gardens/IDs")

    if csid == 10122 and option == 1 then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED,tpz.ki.MAGIAN_TRIAL_LOG)
        player:addKeyItem(tpz.ki.MAGIAN_TRIAL_LOG)

    -- starts a trial
    elseif csid == 10124 and optionMod == 7 then
        local trialId = bit.rshift(option, 8)
        local t = GetMagianTrial(trialId)
        player:addItem(t.reqItem,1,t.reqItemAug1,t.reqItemAugValue1,t.reqItemAug2,t.reqItemAugValue2,t.reqItemAug3,t.reqItemAugValue3,t.reqItemAug4,t.reqItemAugValue4,trialId)
        player:messageSpecial(msg.RETURN_MAGIAN_ITEM, t.reqItem)
        setTrial(player, firstEmptySlot(player), trialId, 0)
        player:setLocalVar("storeTrialId", 0)
        player:setLocalVar("storeItemId", 0)

    -- returns item to player
   elseif csid == 10125 and (optionMod == 0 or optionMod == 4) then
        local trialId = player:getLocalVar("storeTrialId")
        local t = GetMagianTrial(trialId)
        player:addItem(t.reqItem,1,t.reqItemAug1,t.reqItemAugValue1,t.reqItemAug2,t.reqItemAugValue2,t.reqItemAug3,t.reqItemAugValue3,t.reqItemAug4,t.reqItemAugValue4,trialId)
        player:messageSpecial(msg.RETURN_MAGIAN_ITEM, t.reqItem)
        player:setLocalVar("storeTrialId", 0)

    elseif csid == 10124 and (optionMod == 0 or option == -1) then
        local trialId = player:getLocalVar("storeTrialId")
        local itemId = player:getLocalVar("storeItemId")
        local t = GetMagianTrial(trialId)
        if player:getLocalVar("invalidItem") ~= 1 then
            player:addItem(t.reqItem,1,t.reqItemAug1,t.reqItemAugValue1,t.reqItemAug2,t.reqItemAugValue2,t.reqItemAug3,t.reqItemAugValue3,t.reqItemAug4,t.reqItemAugValue4)
        end
        player:messageSpecial(msg.RETURN_MAGIAN_ITEM, itemId)
        player:setLocalVar("invalidItem", 0)
        player:setLocalVar("storeTrialId", 0)
        player:setLocalVar("storeItemId", 0)


    -- gives back item after removing trial id
    elseif csid == 10125 and (optionMod == 8 or optionMod == 11) then
        local trialId = bit.rshift(option, 8)
        local t = GetMagianTrial(trialId)
        for i = 1, 10 do
            local tr, _ = getTrial(player, i)
            if tr == trialId then
                setTrial(player, i, 0, 0)
                break
            end
        end
        player:addItem(t.reqItem,1,t.reqItemAug1,t.reqItemAugValue1,t.reqItemAug2,t.reqItemAugValue2,t.reqItemAug3,t.reqItemAugValue3,t.reqItemAug4,t.reqItemAugValue4)
        player:messageSpecial(msg.RETURN_MAGIAN_ITEM, t.reqItem)

    -- finishes a trial
    elseif csid == 10129 and optionMod == 0 then
        local trialId = player:getLocalVar("storeTrialId")
        local slot = hasTrial(player, trialId)
        if slot then
            setTrial(player, slot, 0, 0)
        end
        local t = GetMagianTrial(trialId)
        player:addItem(t.rewardItem,1,t.rewardItemAug1,t.rewardItemAugValue1,t.rewardItemAug2,t.rewardItemAugValue2,t.rewardItemAug3,t.rewardItemAugValue3,t.rewardItemAug4,t.rewardItemAugValue4)
        player:messageSpecial(msg.ITEM_OBTAINED, t.rewardItem)
        player:setLocalVar("storeTrialId", 0)
    end
end

-------------------
-- Magian Green  --
-------------------

function magianGreenEventUpdate(player, ItemID, csid, option)
end

-------------------
-- Magian Blue   --
-------------------

function magianBlueEventUpdate(player, ItemID, csid, option)
end
