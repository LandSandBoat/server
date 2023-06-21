-----------------------------------
-- ID: 14531
-- Item: bannaret_mail
-- Item Effect: HP +15, Enmity +2
-- Duration: 30 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14531 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 14531)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 15)
    target:addMod(xi.mod.ENMITY, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 15)
    target:delMod(xi.mod.ENMITY, 2)
end

return itemObject
