-----------------------------------
-- ID: 18216
-- Item: twicer
-- Item Effect: DOUBLE_ATTACK 100%
-- Duration: 30 seconds
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

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 30, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DOUBLE_ATTACK, 100)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DOUBLE_ATTACK, 100)
end

return itemObject
