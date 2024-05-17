-----------------------------------
-- ID: 14679
-- Item: Tactical Ring
-- Item Effect: Regain 20
-- Duration: 2 Minutes
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

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 120, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGAIN, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGAIN, 20)
end

return itemObject
