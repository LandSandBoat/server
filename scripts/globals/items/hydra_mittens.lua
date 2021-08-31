-----------------------------------
-- ID: 14925
-- Item: hydra_mittens
-- Item Effect: ACC +15 RACC +15
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14925 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 14925)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 15)
    target:addMod(xi.mod.RACC, 15)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 15)
    target:delMod(xi.mod.RACC, 15)
end

return item_object
