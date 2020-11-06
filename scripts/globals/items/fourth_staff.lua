-----------------------------------------
-- ID: 18613
-- Fourth Staff
-- Enchantment: "Retrace" (Bastok Markets[S])
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/teleports")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.BASTOK_MARKETS_S, 0, 4)
end
