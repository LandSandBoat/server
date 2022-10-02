-----------------------------------
-- ID: 5397
-- Item: bottle_of_sprinters_drink
-- Item Effect: Grants Flee for 60s
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
    local effect = xi.effect.FLEE
    local power = 100
    local duration = 60

    xi.item_utils.addItemEffect(target, effect, power, duration)
end

return item_object
