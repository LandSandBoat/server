-----------------------------------
-- ID: 15838
-- Item: Protect Ring
-- Item Effect: Protect II
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (target:addStatusEffect(tpz.effect.PROTECT, 40, 0, 1800)) then
        target:messageBasic(tpz.msg.basic.GAINS_EFFECT_OF_STATUS, tpz.effect.PROTECT)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
