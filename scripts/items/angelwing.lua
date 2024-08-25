-----------------------------------
-- ID: 5441
-- Item: Angelwing
-- Adds angel wings to the user
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
