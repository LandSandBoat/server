-----------------------------------
-- ID: 14679
-- Item: Tactical Ring
-- Item Effect: Regain 20
-- Duration: 2 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.TACTICAL_RING then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 120, 0, 0, 0, xi.items.TACTICAL_RING)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGAIN, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGAIN, 20)
end

return itemObject
