-----------------------------------
-- ID: 14679
-- Item: Tactical Ring
-- Item Effect: Regain 20
-- Duration: 2 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14679 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 120, 14679)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGAIN, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGAIN, 20)
end

return itemObject
