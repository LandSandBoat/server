-----------------------------------------
-- ID: 18067
-- Equip: Keen Zaghnal
--  Enchantment: Accuracy +3
-- Enchantment will wear off if weapon is unequipped.
--  Effect lasts for 30 minutes
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    if (target:getEquipID(tpz.slot.MAIN) ~= 18067) then
        target:delStatusEffect(tpz.effect.ACCURACY_BOOST, 18067)
    end
    return 0
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.ACCURACY_BOOST, 0, 0, 1800, 18067)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.ACC, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.ACC, 3)
end
