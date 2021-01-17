-----------------------------------------
-- ID: 14786
-- Item: Counter Earring
-- Item Effect: Counter 5%
-- Duration: 3 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14786 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 180, 14786)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.COUNTER, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.COUNTER, 5)
end

return item_object
