-----------------------------------
-- ID: 15269
-- Item: eldritch_horn_hairpin
-- Item Effect: INT+3 MND+3
-- Duration: 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.ELDRITCH_HORN_HAIRPIN) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.ELDRITCH_HORN_HAIRPIN)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.ELDRITCH_HORN_HAIRPIN) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.ELDRITCH_HORN_HAIRPIN)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.MND, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.MND, 3)
end

return itemObject
