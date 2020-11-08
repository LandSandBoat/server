-----------------------------------------
-- ID: 18614
-- Cobra Staff
-- Enchantment: "Retrace" (Windurst Waters[S])
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/teleports")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.WINDURST_WATERS_S, 0, 4)
end
