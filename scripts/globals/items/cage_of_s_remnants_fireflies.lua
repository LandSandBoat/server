-----------------------------------------
-- ID: 5401
-- S. Rem. Fireflies
-- Transports the user out of Silver Sea Remnants
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------------

function onItemCheck(target)
    if target:getZoneID() == tpz.zone.SILVER_SEA_REMNANTS then
        return 0
    end
    return 56
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.S_REM, 0, 1)
end
