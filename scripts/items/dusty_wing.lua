-----------------------------------
-- ID: 5440
-- Dusty Wing
-- Increases TP of the user by 3000
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addTP(3000)
end

return itemObject
