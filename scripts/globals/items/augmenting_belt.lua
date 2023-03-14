-----------------------------------
-- ID: 15889
-- Item: augmenting_belt
-- Item Effect: HPHEAL +2
-- Duration: 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if
        effect ~= nil and
        effect:getItemSourceID() == xi.items.AUGMENTING_BELT
    then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.AUGMENTING_BELT)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPHEAL, 2)
end

return itemObject
