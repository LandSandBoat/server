-----------------------------------
-- ID: 4216
-- Item: Briliant Snow
-- Creates a spiral of "snow" effects
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
