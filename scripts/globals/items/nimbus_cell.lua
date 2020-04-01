-----------------------------------------
-- Nimbus Cell
-- 5379
-- Removes AGI Down effect
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------------

function onItemCheck(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.DEBILITATION, 0x008)
end

function onItemUse(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.DEBILITATION, 0x008, 14)
end
