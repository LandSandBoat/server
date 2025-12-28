-----------------------------------
-- ID: 5330
-- Item: Mithra snare
-- Used in Pirates Chart quest
-- When used on one of the quest nms, prevents its use of 2hr
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.piratesChart.onItemCheck(target, item, param, caster)
end

itemObject.onItemUse = function(target)
    target:setLocalVar('usedTwoHour', 1)
end

return itemObject
