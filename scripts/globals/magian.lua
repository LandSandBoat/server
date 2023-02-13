-----------------------------------
-- Magian Trial Global
-----------------------------------
require('scripts/globals/common')
require('scripts/globals/items')
require('scripts/globals/magian_data')
require('scripts/globals/status')
-----------------------------------
xi = xi or {}
xi.magian = xi.magian or {}
xi.magian.playerCache = xi.magian.playerCache or {}

local magianMoogleInfo =
{
    ['Magian_Moogle_Blue']   = {   nil, 10141, 10142, 10143, 10144, 10148, xi.itemType.ARMOR  },
    ['Magian_Moogle_Orange'] = { 10121, 10122, 10123, 10124, 10125, 10129, xi.itemType.WEAPON },
}

-- Returns a table of data containing the player's currently active trials, and caches this data
-- keyed by player ID into xi.magian.playerCache
local function getPlayerTrialData(player)
    local playerId     = player:getID()
    local activeTrials = xi.magian.playerCache[playerId]

    if activeTrials then
        return activeTrials
    end

    activeTrials = {}

    for trialSlot = 1, 10 do
        local trialData      = player:getCharVar("[trial]" .. trialSlot)
        local trialId        = bit.rshift(trialData, 16)
        local trialProgress  = bit.band(trialData, 0xFFFF)
        local objectiveTotal = xi.magian.trials[trialId].numRequired or 0

        activeTrials[trialSlot] = { trialId = trialId, progress = trialProgress, objectiveTotal = objectiveTotal }
    end

    xi.magian.playerCache[playerId] = activeTrials

    return activeTrials
end

-- Returns a packed table of active trials, two per index, along with total count of active trials.  Active trials
-- are determined by a non-zero value for trialId in the cached data.
local function packActiveTrials(player)
    local activeTrials = {}

    for _, trialSlot in pairs(getPlayerTrialData(player)) do
        if trialSlot.trialId > 0 then
            table.insert(activeTrials, trialSlot.trialId)
        end
    end

    local packedData = { 0, 0, 0, 0, 0 }

    for paramIndex = 1, #activeTrials, 2 do
        packedData[(paramIndex + 1) / 2] = activeTrials[paramIndex] + bit.lshift((activeTrials[paramIndex + 1] or 0), 16)
    end

    return packedData, #activeTrials
end

-- Returns a packed 5 bit value and 11 bit identifier of a single augment.  Expected input is a table in the format
-- of { augmentId, augmentValue }
local function packAugment(augmentTable)
    return bit.lshift(augmentTable[2], 11) + augmentTable[1]
end

-- Returns a table containing two packed 32bit parameters corresponding to { Augment1+Augment2, Augment3+Augment4 }
local function packAugmentParameters(augmentTable)
    local packedAugments = { 0, 0 }

    for augIndex, augData in pairs(augmentTable) do
        local packedIndex = math.ceil(augIndex / 2)
        local shiftAmount = augIndex % 2 == 1 and 16 or 0

        packedAugments[packedIndex] = bit.lshift(packAugment(augData), shiftAmount)
    end

    return packedAugments
end

xi.magian.magianOnTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MAGIAN_TRIALS ~= 1 then
        return
    end

    local moogleData = magianMoogleInfo[npc:getName()]

    if
        moogleData[1] and
        player:getMainLvl() < 75
    then
        player:startEvent(moogleData[1])
    elseif not player:hasKeyItem(xi.ki.MAGIAN_TRIAL_LOG) then
        player:startEvent(moogleData[2])
    else
        local packedData, numActiveTrials = packActiveTrials(player)

        player:startEvent(moogleData[3], packedData[1], packedData[2], packedData[3], packedData[4], packedData[5], 0, 0, numActiveTrials)
    end
end
