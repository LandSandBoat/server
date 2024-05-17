-----------------------------------
-- ID: 18241
-- Item: Vial of Refresh Musk
-- Item Effect: 60 seconds
-- Duration: 30 Seconds
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

    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.REFRESH, 0, 0, 30, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REFRESH, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REFRESH, 3)
end

return itemObject
