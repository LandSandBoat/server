-----------------------------------------
-- ID: 5348
-- Alzadaal Fireflies
-- Transports the user to Nyzul Isle Staging Point
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------------

function onItemCheck(target)
    if target:getZoneID() == tpz.zone.NYZUL_ISLE then
        return 0
    end
    return 56
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.ALZADAAL, 0, 1)
end
