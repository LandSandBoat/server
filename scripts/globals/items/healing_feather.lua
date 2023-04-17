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
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.HEALING_FEATHER) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.HEALING_FEATHER)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.HEALING_FEATHER) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.HEALING_FEATHER)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CURE_POTENCY, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CURE_POTENCY, 15)
end

return itemObject
