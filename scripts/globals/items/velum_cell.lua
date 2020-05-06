-----------------------------------------
-- Velum Cell
-- ID 5380
-- Removes INT Down effect
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------------

function onItemCheck(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.DEBILITATION, 0x010)
end

function onItemUse(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.DEBILITATION, 0x010, 15)
end
