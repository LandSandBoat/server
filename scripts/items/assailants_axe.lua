-----------------------------------
-- ID: 18488
-- Item: assailants_axe
-- Item Effect: Acc +3
-- Duration: 30 Minutes
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

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 3)
end

return itemObject
