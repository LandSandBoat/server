-----------------------------------------
-- ID: 4527
-- Item: Jug of marys milk
-- Item Effect: This potion induces sleep.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not hasSleepEffects(target)) then
        target:addStatusEffect(tpz.effect.SLEEP_I, 1, 0, 60)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
