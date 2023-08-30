-----------------------------------
-- ID: 4206
-- Item: bottle_of_catholicon
-- Item Effect: Instantly removes up to 3 negative status effects from target
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effects = xi.itemUtils.removableEffects
    local count = 3

    xi.itemUtils.removeMultipleEffects(target, effects, count)
end

return itemObject
