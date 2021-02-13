-----------------------------------
-- ID: 5438
-- Item: Bottle of Strange Juice
-- Item Effect: Restores 200 MP over 300 seconds.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(tpz.effect.REFRESH)) then
        target:addStatusEffect(tpz.effect.REFRESH, 2, 3, 300)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
