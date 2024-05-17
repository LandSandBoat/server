-----------------------------------
-- ID: 14516
-- Item: hydra_harness
-- Item Effect: Attack +25, Ranged Attack +25
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
    target:addMod(xi.mod.ATT, 25)
    target:addMod(xi.mod.RATT, 25)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATT, 25)
    target:delMod(xi.mod.RATT, 25)
end

return itemObject
