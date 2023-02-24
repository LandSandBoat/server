-----------------------------------
-- ID: 18239
-- Item: Healing Feather
-- Item Effect: Cure Potency +15%
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.HEALING_FEATHER then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.HEALING_FEATHER)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CURE_POTENCY, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CURE_POTENCY, 15)
end

return itemObject
