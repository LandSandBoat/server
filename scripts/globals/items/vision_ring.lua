-----------------------------------------
-- ID: 15559
-- Item: vision_ring
-- Item Effect: ACC+2 RACC+2
-- Duration: 30 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15559 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 1800, 15559)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ACC, 2)
    target:addMod(tpz.mod.RACC, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ACC, 2)
    target:delMod(tpz.mod.RACC, 2)
end

return item_object
