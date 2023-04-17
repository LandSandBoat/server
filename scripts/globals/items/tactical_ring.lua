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
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.TACTICAL_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.TACTICAL_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.TACTICAL_RING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 120, 0, 0, 0, xi.items.TACTICAL_RING)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGAIN, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGAIN, 20)
end

return itemObject
