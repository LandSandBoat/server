-----------------------------------
-- ID: 5232
-- Item: Soy Milk
-- Item Effect: Restores 40 HP over 120 seconds
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(xi.effect.REGEN)) then
        target:addStatusEffect(xi.effect.REGEN, 1, 3, 120)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
