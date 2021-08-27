-----------------------------------
-- ID: 15170
-- Item: Stoneskin Torque
-- Item Effect: Stoneskin
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if target:addStatusEffect(xi.effect.STONESKIN, 104, 0, 300, 0, 0, 4) then
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.STONESKIN)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
