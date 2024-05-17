-----------------------------------
-- ID: 14680
-- Item: Pacifist Ring
-- Item Effect: Enmity -12
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
    target:delMod(xi.mod.ENMITY, 12)
end

itemObject.onEffectLose = function(target, effect)
    target:addMod(xi.mod.ENMITY, 12)
end

return itemObject
