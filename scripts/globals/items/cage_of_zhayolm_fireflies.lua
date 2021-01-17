-----------------------------------------
-- ID: 5345
-- Item: Zhayolm Fireflies
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/teleports")
require("scripts/globals/zone")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getZoneID() == tpz.zone.LEBROS_CAVERN then
        return 0
    end
    return 56
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.ZHAYOLM, 0, 1)
end

return item_object
