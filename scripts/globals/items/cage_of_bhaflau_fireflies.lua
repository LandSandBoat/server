-----------------------------------------
-- ID: 5344
-- Bhaflau Fireflies
-- Transports the user to Mamool Ja Staging Point
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getZoneID() == tpz.zone.MAMOOL_JA_TRAINING_GROUNDS then
        return 0
    end
    return 56
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.BHAFLAU, 0, 1)
end

return item_object
