-----------------------------------------
-- Virga Cell
-- ID 5372
-- Unlocks earring and ring equipment
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------------

function onItemCheck(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.ENCUMBRANCE_I, 0x7800)
end

function onItemUse(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.ENCUMBRANCE_I, 0x7800, 7)
end
