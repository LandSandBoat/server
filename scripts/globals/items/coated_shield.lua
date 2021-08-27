-----------------------------------
-- ID: 15838
-- Item: Coated Shield
-- Item Effect: Shell
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (target:addStatusEffect(xi.effect.SHELL, 9, 0, 1800)) then
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.SHELL)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
