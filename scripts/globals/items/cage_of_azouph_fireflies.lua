-----------------------------------------
-- ID: 5343
-- Azouph Fireflies
-- Transports the user to Azouph Isle
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getZoneID() == tpz.zone.LEUJAOAM_SANCTUM then
        return 0
    end
    return 56
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.AZOUPH, 0, 1)
end

return item_object
