-----------------------------------
-- ID: 18402
-- Item: mana_wand
-- Item Effect: MPHEAL +2
-- Duration: 30 minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.MANA_WAND) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.MANA_WAND)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.MANA_WAND) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.MANA_WAND)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 2)
end

return itemObject
