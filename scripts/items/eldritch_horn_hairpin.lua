-----------------------------------
-- ID: 15269
-- Item: eldritch_horn_hairpin
-- Item Effect: INT+3 MND+3
-- Duration: 30 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15269 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 15269)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.MND, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.MND, 3)
end

return itemObject
