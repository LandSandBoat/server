-----------------------------------
-- ID: 4184
-- Kongou Inaho
-- A sparkler-type firework appears in the user's hand
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
