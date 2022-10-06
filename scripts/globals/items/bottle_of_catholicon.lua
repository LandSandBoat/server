-----------------------------------
-- ID: 4206
-- Item: bottle_of_catholicon
-- Item Effect: Instantly removes up to 3 negative status effects from target
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/item_utils")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effects = xi.item_utils.removableEffects
    local count = 3

    xi.item_utils.removeMultipleEffects(target, effects, count)
end

return itemObject
