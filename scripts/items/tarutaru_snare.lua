-----------------------------------
-- ID: 5329
-- Item: Tarutaru snare
-- Used in Pirates Chart quest
-- When used on one of the quest nms, lowers its damage for 60 seconds
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.piratesChart.onItemCheck(target, item, param, caster)
end

itemObject.onItemUse = function(target)
    target:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 1)
    target:setLocalVar('snareTimeLimit', GetSystemTime() + 60)
end

return itemObject
