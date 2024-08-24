-----------------------------------
-- ID: 5360
-- Muteppo
-- A roman candle-like firework that hurls different colors
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
