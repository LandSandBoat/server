-----------------------------------
-- ID: 14678
-- Item: Assassin's Ring
-- Item Effect: Ranged Accuracy 20
-- Duration 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if
        effect ~= nil and
        effect:getItemSourceID() == xi.items.ASSASSINS_RING
    then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.ASSASSINS_RING)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.RACC, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.RACC, 20)
end

return itemObject
