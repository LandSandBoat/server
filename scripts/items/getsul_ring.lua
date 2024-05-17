-----------------------------------
-- ID: 14681
-- Item: Getsul Ring
-- Item Effect: +20% HP
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
    target:addMod(xi.mod.HPP, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPP, 20)
end

return itemObject
