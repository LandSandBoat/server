-----------------------------------
-- ID: 15861
-- Item: deductive_brocade_obi
-- Item Effect: MND+10
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if
        effect ~= nil and
        effect:getItemSourceID() == xi.items.DEDUCTIVE_BROCADE_OBI
    then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, 0, 0, 0, xi.items.DEDUCTIVE_BROCADE_OBI)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MND, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MND, 10)
end

return itemObject
