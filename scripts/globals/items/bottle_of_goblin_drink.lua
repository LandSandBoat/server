-----------------------------------------
-- ID: 4541
-- Item: Goblin Drink
-- Item Effect: Restores 1 MP while healing / 3 tick 180 mins.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(tpz.effect.FOOD)) then
        target:addStatusEffect(tpz.effect.FOOD, 1, 3, 10800, 4541)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

item_object.onEffectGain = function(target, effect)
end

function onEffectTick(target, effect)
    if (target:hasStatusEffect(tpz.effect.HEALING)) then
        target:addMP(effect:getPower())
    end
end

item_object.onEffectLose = function(target, effect)
end

return item_object
