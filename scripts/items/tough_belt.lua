-----------------------------------
-- ID: 15864
-- Item: tough_belt
-- Item Effect: VIT +3
-- Duration: 60 seconds
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

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 600, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.VIT, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.VIT, 3)
end

return itemObject
