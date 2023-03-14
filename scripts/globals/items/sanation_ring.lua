-----------------------------------
-- ID: 14677
-- Item: Sanation Ring
-- Item Effect: MP recovered while healing +3
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.SANATION_RING then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.SANATION_RING)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 3)
end

return itemObject
