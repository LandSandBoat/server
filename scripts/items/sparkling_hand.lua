-----------------------------------
-- ID: 4217
-- Sparkling Hand
-- The user's right hand glows in a white light
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
