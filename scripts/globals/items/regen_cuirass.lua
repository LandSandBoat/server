-----------------------------------
-- ID: 15170
-- Item: regen cuirass
-- Item Effect: gives regen
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (target:hasStatusEffect(tpz.effect.REGEN)) then
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(tpz.effect.REGEN, 15, 3, 180)
    end
end

return item_object
