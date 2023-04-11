-----------------------------------
-- ID: 18488
-- Item: assailants_axe
-- Item Effect: Acc +3
-- Duration: 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.ASSAILANTS_AXE) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.ASSAILANTS_AXE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.ASSAILANTS_AXE) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.ASSAILANTS_AXE)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 3)
end

return itemObject
