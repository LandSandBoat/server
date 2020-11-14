-----------------------------------------
-- ID: 18612
-- Ram Staff
-- Enchantment: "Retrace" (Southern San d'Oria[S])
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/teleports")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.SOUTHERN_SAN_DORIA_S, 0, 4)
end
