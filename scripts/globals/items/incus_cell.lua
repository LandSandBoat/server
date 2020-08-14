-----------------------------------------
-- Incus Cell
-- ID 5365
-- Unlocks weapons and shields
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------------

function onItemCheck(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.ENCUMBRANCE_I, 0x0003)
end

function onItemUse(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.ENCUMBRANCE_I, 0x0003, 0)
end
