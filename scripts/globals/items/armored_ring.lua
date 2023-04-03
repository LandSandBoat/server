-----------------------------------
-- ID: 15783
-- Item: Armored Ring
-- Item Effect: Defence +8
-- Duration 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.ARMORED_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.ARMORED_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.ARMORED_RING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.ARMORED_RING)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEF, 8)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEF, 8)
end

return itemObject
