-----------------------------------------
-- Castellanus Cell
-- ID 5366
-- Unlocks head and neck equipment
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------------

function onItemCheck(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.ENCUMBRANCE_I, 0x0210)
end

function onItemUse(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.ENCUMBRANCE_I, 0x0210, 1)
end
