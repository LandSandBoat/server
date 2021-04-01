-----------------------------------
-- ID: 5944
-- Item: Bottle of Frontier Soda
-- Item Effect: Restores 20 TP over 60 seconds.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(xi.effect.REGAIN)) then
        target:addStatusEffect(xi.effect.REGAIN, 1, 3, 60)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
