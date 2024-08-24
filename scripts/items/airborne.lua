-----------------------------------
-- ID: 4186
-- Item: Airborne
-- A goblin with a rainbow colored parasail rides in a downward spiral
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
