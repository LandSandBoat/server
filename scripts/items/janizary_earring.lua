-----------------------------------
-- ID: 14785
-- Item: Janizary Earring
-- Item Effect: Defence +32
-- Duration 3 Minutes
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
    target:addMod(xi.mod.DEF, 32)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEF, 32)
end

return itemObject
