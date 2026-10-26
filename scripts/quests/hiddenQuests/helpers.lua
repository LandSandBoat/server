-----------------------------------
-- Helpers for Furniture Quests
-----------------------------------
-- Furniture rewards are tracked as a single bit per furniture item
-- in one shared charVar, instead of a permanent var per quest.
-----------------------------------
xi = xi or {}
xi.furnitureQuest = xi.furnitureQuest or {}

local obtainedVar = '[Furniture]Obtained'

-----------------------------------
-- Furniture item -> bit in '[Furniture]Obtained'
-- Valid bits are 0-30. charVars are signed 32-bit (see: sql/char_vars.sql), bit 31 is the sign bit.
-- Update the obtainedBit table when adding a new furnitureQuest
-----------------------------------
local obtainedBit =
{
    [xi.item.ARMOIRE] = 0,
}

local function getObtainedBit(quest)
    local bitPos = obtainedBit[quest.furniture]
    if bitPos == nil then
        error(string.format('[furnitureQuest] No bit assigned for %s', quest.name))
    end

    return bitPos
end

---@nodiscard
xi.furnitureQuest.hasObtained = function(player, quest)
    return utils.mask.getBit(player:getCharVar(obtainedVar), getObtainedBit(quest))
end

xi.furnitureQuest.setObtained = function(player, quest)
    local updated = utils.mask.setBit(player:getCharVar(obtainedVar), getObtainedBit(quest), true)
    player:setCharVar(obtainedVar, updated)
end
