-----------------------------------
-- Item: Death Chakram
-- Item Effect: +5% MP
-- Duration 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.DEATH_CHAKRAM then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.DEATH_CHAKRAM)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPP, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPP, 5)
end

return itemObject
