-----------------------------------
-- ID: 15861
-- Item: deductive_brocade_obi
-- Item Effect: MND+10
-- Duration: 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15861 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 15861)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MND, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MND, 10)
end

return itemObject
