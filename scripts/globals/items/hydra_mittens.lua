-----------------------------------
-- ID: 14925
-- Item: hydra_mittens
-- Item Effect: ACC +15 RACC +15
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.HYDRA_MITTENS) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.HYDRA_MITTENS)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.HYDRA_MITTENS) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.HYDRA_MITTENS)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 15)
    target:addMod(xi.mod.RACC, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 15)
    target:delMod(xi.mod.RACC, 15)
end

return itemObject
