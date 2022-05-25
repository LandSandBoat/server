-----------------------------------
-- ID: 4237
-- Item: Perpetual Hourglass
-- Use: Creates a replica of the Perpetual Hourglass
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/dynamis")
-----------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    local targetZone = target:getZoneID()
    local zoneID = xi.dynamis.dynaInfoEra[targetZone].dynaZone
    local zoneOriginalRegistrant = GetServerVariable(string.format("[DYNA]OriginalRegistrant_%s", zoneID))
    if not target:isPC() then -- If not a player then don't replicate (Will big break things).
        return
    end
    if zoneOriginalRegistrant == 0 then -- Can't replicate after a new dyna is made in the zone.
        target:messageBasic(xi.msg.basic.ITEM_UNABLE_TO_USE)
        return
    end
    if target:getZone():getType() == xi.zoneType.DYNAMIS then -- Can't replicate in Dynamis
        target:messageBasic(xi.msg.basic.ITEM_UNABLE_TO_USE)
        return
    end
end

item_object.onItemUse = function(target, item)
    local targetZone = target:getZoneID()
    local zoneID = xi.dynamis.dynaInfoEra[targetZone].dynaZone
    local zoneToken = GetServerVariable(string.format("[DYNA]Token_%s", zoneID))
    local zoneOriginalRegistrant = GetServerVariable(string.format("[DYNA]OriginalRegistrant_%s", zoneID))

    target:duplicateHourglass(zoneID, zoneToken, zoneOriginalRegistrant) -- Duplicate the glass.
end

return item_object