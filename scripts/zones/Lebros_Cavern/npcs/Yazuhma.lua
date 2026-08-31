-----------------------------------
-- Area: Lebros Cavern
-----------------------------------
local ID = zones[xi.zone.LEBROS_CAVERN]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- Must be kept in sync with the table in Imperial_Stormer.lua
local supplyItems =
{
    { itemId = xi.item.SEAFOOD_STEWPOT,     points = 7, fillsGroup = true },
    { itemId = xi.item.BISON_STEAK,         points = 5 },
    { itemId = xi.item.COEURL_SUB,          points = 4 },
    { itemId = xi.item.BISON_JERKY,         points = 3 },
    { itemId = xi.item.BOWL_OF_PEA_SOUP,    points = 2 },
    { itemId = xi.item.LOAF_OF_WHITE_BREAD, points = 1 },
}

local assignedSupplyVar = 'lebrosAssignedSupply'
local handOutCooldownVar = 'supplyHandOutTime'

local function hasSupply(player)
    for _, supply in ipairs(supplyItems) do
        if player:hasItem(supply.itemId, xi.inv.TEMPITEMS) then
            return true
        end
    end

    return false
end

local function countHungrySoldiers(instance)
    local hungry = 0

    for offset = 0, 11 do
        local soldier = GetNPCByID(ID.npc.IMPERIAL_STORMER + offset, instance)
        if soldier and soldier:getLocalVar('supplyPoints') < 7 then
            hungry = hungry + 1
        end
    end

    return hungry
end

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()

    if not instance then
        return
    end

    if hasSupply(player) then
        local hungry = countHungrySoldiers(instance)

        if hungry >= 7 then
            player:messageSpecial(ID.text.STILL_BRAVE_SOLDIERS_STARVING, 0)
        elseif hungry >= 4 then
            player:messageSpecial(ID.text.ABOUT_HALF_OF_UNIT_RECEIVED, 0)
        elseif hungry >= 2 then
            player:messageSpecial(ID.text.NOT_MANY_HUNGRY_SOLDIERS_LEFT, 0)
        elseif hungry == 1 then
            player:messageSpecial(ID.text.MUST_BE_SOMEBODY_OUT_THERE, 0)
        end

        return
    end

    if GetSystemTime() < npc:getLocalVar(handOutCooldownVar) then
        return
    end

    local assignedSupply = player:getCharVar(assignedSupplyVar)
    if assignedSupply == 0 then
        assignedSupply = math.randomInt(1, #supplyItems)
        player:setVolatileCharVar(assignedSupplyVar, assignedSupply)
    end

    local supply = supplyItems[assignedSupply]
    local itemId = supply.itemId

    if supply.fillsGroup then
        player:messageSpecial(ID.text.KEEP_A_WHOLE_UNIT_FILLED_UP, 0)
    end

    npc:setLocalVar(handOutCooldownVar, GetSystemTime() + 4)
    player:messageSpecial(ID.text.ADVANCE_UNIT_IS_DEPENDING, 0)
    player:timer(3000, function(playerArg)
        if playerArg:addTempItem(itemId, 1) then
            playerArg:messageSpecial(ID.text.TEMP_ITEM, itemId)
        end
    end)
end

entity.onSpawn = function(npc)
    npc:setStatus(xi.status.NORMAL)
end

return entity
