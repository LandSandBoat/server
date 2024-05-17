-----------------------------------
-- ID: 15870
-- Item: maharajas_belt
-- Item Effect: AGI +10
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

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 10)
end

return itemObject
