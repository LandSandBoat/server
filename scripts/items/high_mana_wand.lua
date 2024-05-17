-----------------------------------
-- ID: 18403
-- Item: high_mana_wand
-- Item Effect: MPHEAL +4
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

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 4)
end

return itemObject
