-----------------------------------
-- ID: 18067
-- Equip: Keen Zaghnal
--  Enchantment: Accuracy +3
-- Enchantment will wear off if weapon is unequipped.
--  Effect lasts for 30 minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if (target:getEquipID(xi.slot.MAIN) ~= 18067) then
        target:delStatusEffect(xi.effect.ACCURACY_BOOST, 18067)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ACCURACY_BOOST, 0, 0, 1800, 18067)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ACC, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ACC, 3)
end

return item_object
