-----------------------------------------
-- ID: 5398
-- Z. Rem. Fireflies
-- Transports the user out of Zhayolm Remnants
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getZoneID() == tpz.zone.ZHAYOLM_REMNANTS then
        return 0
    end
    return 56
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.Z_REM, 0, 1)
end

return item_object
