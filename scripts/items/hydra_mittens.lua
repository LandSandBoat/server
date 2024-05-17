-----------------------------------
-- ID: 14925
-- Item: hydra_mittens
-- Item Effect: ACC +15 RACC +15
-- Duration: 3 Minutes
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

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 15)
    target:addMod(xi.mod.RACC, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 15)
    target:delMod(xi.mod.RACC, 15)
end

return itemObject
