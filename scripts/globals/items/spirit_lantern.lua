-----------------------------------
-- ID: 18240
-- Item: Spirit Lantern
-- Item Effect: Magic Damage +10%
-- Duration: 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 18240 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 18240)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MAGIC_DAMAGE, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MAGIC_DAMAGE, 10)
end

return itemObject
