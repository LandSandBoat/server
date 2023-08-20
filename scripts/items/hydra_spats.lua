-----------------------------------
-- ID: 15681
-- Item: hydra_spats
-- Item Effect: Eva +15
-- Duration: 20 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15681 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1200, 15681)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.EVA, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.EVA, 15)
end

return itemObject
