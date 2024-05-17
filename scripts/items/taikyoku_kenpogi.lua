-----------------------------------
-- ID: 14541
-- Item: taikyoku_kenpogi
-- Item Effect: Eva +3
-- Duration: 30 Minutes
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
    target:addMod(xi.mod.EVA, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.EVA, 3)
end

return itemObject
