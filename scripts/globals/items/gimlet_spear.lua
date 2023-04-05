-----------------------------------
-- ID: 18117
-- Item: gimlet_spear
-- Item Effect: Attack +3
-- Duration: 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.GIMLET_SPEAR) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.GIMLET_SPEAR)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.GIMLET_SPEAR) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.GIMLET_SPEAR)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ATT, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATT, 3)
end

return itemObject
