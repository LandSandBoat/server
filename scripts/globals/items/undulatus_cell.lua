-----------------------------------------
-- Undulatus Cell
-- ID 5371
-- Unlocks ranged and ammo equipment
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------------

function onItemCheck(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.ENCUMBRANCE_I, 0x000C)
end

function onItemUse(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.ENCUMBRANCE_I, 0x000C, 6)
end
