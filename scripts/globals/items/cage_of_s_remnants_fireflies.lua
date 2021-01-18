-----------------------------------
-- ID: 5401
-- S. Rem. Fireflies
-- Transports the user out of Silver Sea Remnants
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getZoneID() == tpz.zone.SILVER_SEA_REMNANTS then
        return 0
    end
    return 56
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.S_REM, 0, 1)
end

return item_object
