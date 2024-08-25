-----------------------------------
-- ID: 4251
-- Festive Fan
-- A paper fan appears in the user's left hand
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
