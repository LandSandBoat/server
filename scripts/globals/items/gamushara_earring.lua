-----------------------------------------
-- ID: 14788
-- Item: Gamushara Earring
-- Item Effect: Attack +22
-- Duration: 3 Minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 14788 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 180, 14788)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.ATT, 22)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.ATT, 22)
end

return item_object
