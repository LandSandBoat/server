-----------------------------------
-- ID: 18945
-- Item: Jet Sickle
-- Item Effect: TP +100
-- Duration: Instant
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addTP(100)
end

return itemObject
