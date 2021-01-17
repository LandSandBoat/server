-----------------------------------------
-- ID: 13693
-- Item: Aries Mantle
-- Enchantment: Sleep
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (hasSleepEffects(target)) then
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(tpz.effect.SLEEP_I, 0, 0, 30)
    end
end

return item_object
