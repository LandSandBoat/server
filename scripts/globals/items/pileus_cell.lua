-----------------------------------------
-- Pileus Cell
-- ID 5381
-- Removes MND Down effect
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------------

function onItemCheck(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.DEBILITATION, 0x020)
end

function onItemUse(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.DEBILITATION, 0x020, 16)
end
