-----------------------------------
-- ID: 15866
-- Item: acrobats_belt
-- Item Effect: AGI +3
-- Duration: 60 seconds
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/items")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.ACROBATS_BELT then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, 0, 0, 0, xi.items.ACROBATS_BELT)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 3)
end

return itemObject
