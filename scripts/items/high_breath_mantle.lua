-----------------------------------
-- ID: 15487
-- Item: High Breath Mantle
-- Item Effect: HP+38 / Enmity+5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, user, item, param)
    local effect = target:getItemEnchantmentEffect(item:getID())
    if effect then
        effect:delStatusEffect()
    end

    return 0
end

itemObject.onItemUse = function(target, user, item)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 38)
    target:addMod(xi.mod.ENMITY, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 38)
    target:delMod(xi.mod.ENMITY, 5)
end

return itemObject
