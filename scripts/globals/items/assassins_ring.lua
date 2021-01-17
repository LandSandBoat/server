-----------------------------------------
-- ID: 14678
-- Item: Assassin's Ring
-- Item Effect: Ranged Accuracy 20
-- Duration 3 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14678 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 180, 14678)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.RACC, 20)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.RACC, 20)
end

return item_object
