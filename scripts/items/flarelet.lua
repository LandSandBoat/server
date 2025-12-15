-----------------------------------
-- ID: 6457
-- Item: Flarelet
-- A sparkler firework that shoots a purple stream of sparks into the air.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
