-----------------------------------------
-- ID: 5437
-- Item: Flask of Strange Milk
-- Item Effect: Restores 500 HP over 300 seconds.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(tpz.effect.REGEN)) then
        target:addStatusEffect(tpz.effect.REGEN, 5, 3, 300)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
