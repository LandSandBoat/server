-----------------------------------
-- ID: 14516
-- Item: hydra_harness
-- Item Effect: Attack +25, Ranged Attack +25
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.HYDRA_HARNESS then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.HYDRA_HARNESS)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ATT, 25)
    target:addMod(xi.mod.RATT, 25)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATT, 25)
    target:delMod(xi.mod.RATT, 25)
end

return itemObject
