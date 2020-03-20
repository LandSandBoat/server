-----------------------------------------
-- Fractus Cell
-- 5377
-- Removes DEX Down effect
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------------

function onItemCheck(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.DEBILITATION, 0x002)
end

function onItemUse(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.DEBILITATION, 0x002, 12)
end
