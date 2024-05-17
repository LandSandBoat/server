-----------------------------------
-- ID: 15486
-- Item: Breath Mantle
-- Item Effect: HP+18 / Enmity+3
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
    target:addMod(xi.mod.HP, 18)
    target:addMod(xi.mod.ENMITY, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 18)
    target:delMod(xi.mod.ENMITY, 3)
end

return itemObject
