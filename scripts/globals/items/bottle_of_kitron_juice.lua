-----------------------------------------
-- ID: 5932
-- Item: Bottle of Kitron Juice
-- Item Effect: Restores 180 MP over 180 seconds.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(tpz.effect.REFRESH)) then
        target:addStatusEffect(tpz.effect.REFRESH, 3, 3, 180)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
