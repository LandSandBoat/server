-----------------------------------
-- ID: 14864
-- Item: Palmer's Bangles
-- Item Effect: Gilfinder
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.PALMERS_BANGLES then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.PALMERS_BANGLES)
end

itemObject.onEffectGain = function(target)
    target:addMod(xi.mod.GILFINDER, 3)
end

itemObject.onEffectLose = function(target)
    target:delMod(xi.mod.GILFINDER, 3)
end

return itemObject
