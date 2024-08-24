-----------------------------------
-- ID: 4183
-- Konron Hassen
-- A fountain-type firework appears on the ground
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
