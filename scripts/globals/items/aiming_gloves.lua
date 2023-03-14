-----------------------------------
-- ID: 14957
-- Item: aiming_gloves
-- Item Effect: Ranged Accuracy +3
-- Duration: 60 seconds (Needs confirmation)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.AIMING_GLOVES then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, 0, 0, 0, xi.items.AIMING_GLOVES)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.RACC, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.RACC, 3)
end

return itemObject
