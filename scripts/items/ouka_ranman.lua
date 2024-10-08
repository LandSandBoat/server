-----------------------------------
-- ID: 4256
-- Ouka Ranman
-- Surrounds the user (and space in front of them) with falling cherry blossoms
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
