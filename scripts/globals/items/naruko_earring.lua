-----------------------------------
-- ID: 14789
-- Item: Naruko Earring
-- Item Effect: Enmity +10
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14789 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 180, 14789)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ENMITY, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ENMITY, 10)
end

return item_object
