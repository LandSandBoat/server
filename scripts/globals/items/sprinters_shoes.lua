-----------------------------------
-- ID: 15754
-- Item: Sprinter's Shoes
-- Item Effect: Quickening for 60 minutes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.QUICKENING, 10, 0, 3600)
    target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.QUICKENING)
end

return item_object
