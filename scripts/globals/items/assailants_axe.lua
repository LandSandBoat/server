-----------------------------------
-- ID: 18488
-- Item: assailants_axe
-- Item Effect: Acc +3
-- Duration: 30 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 18488 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 18488)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 3)
end

return itemObject
