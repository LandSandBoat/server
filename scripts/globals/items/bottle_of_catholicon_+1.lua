-----------------------------------
-- ID: 4208
-- Item: bottle_of_catholicon_+1
-- Item Effect: Instantly removes up to 6 negative status effects from target
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
require("scripts/globals/item_utils")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local effects = xi.item_utils.removableEffects
    local count = 6

    xi.item_utils.removeMultipleEffects(target, effects, count)
end

return item_object
