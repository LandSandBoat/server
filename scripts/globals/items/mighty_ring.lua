-----------------------------------------
-- ID: 15558
-- Item: mighty_ring
-- Item Effect: Attack +5, Ranged Attack +5
-- Duration: 30 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15558 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 1800, 15558)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ATT, 5)
    target:addMod(tpz.mod.RATT, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ATT, 5)
    target:delMod(tpz.mod.RATT, 5)
end

return item_object
