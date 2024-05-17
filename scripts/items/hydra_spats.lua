-----------------------------------
-- ID: 15681
-- Item: hydra_spats
-- Item Effect: Eva +15
-- Duration: 20 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, user, item, param)
    return 0
end

itemObject.onItemUse = function(target, user, item)
    local effect = target:getItemEnchantmentEffect(item:getID())
    if effect then
        effect:delStatusEffect()
    end

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1200, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.EVA, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.EVA, 15)
end

return itemObject
