-----------------------------------
-- ID: 4237
-- Item: Perpetual Hourglass
-- Use: Creates a replica of the Perpetual Hourglass
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------

local itemObject = {}

itemObject.onItemCheck = function(target)
    local targetZone = target:getZoneID()
    local zoneID = xi.dynamis.dynaInfoEra[targetZone].dynaZone
    local zoneToken = GetServerVariable(string.format("[DYNA]Token_%s", zoneID))
    local validateresult = target:validateHourglass(zoneToken)
    local result = 0

    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    if target:getZone():getType() == xi.zoneType.DYNAMIS then -- Can't replicate in Dynamis
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if not validateresult then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return result
end

itemObject.onItemUse = function(target)
    local targetZone = target:getZoneID()
    local zoneID = xi.dynamis.dynaInfoEra[targetZone].dynaZone
    local zoneToken = GetServerVariable(string.format("[DYNA]Token_%s", zoneID))
    local zoneOriginalRegistrant = GetServerVariable(string.format("[DYNA]OriginalRegistrant_%s", zoneID))

    target:duplicateHourglass(zoneID, zoneToken, zoneOriginalRegistrant) -- Duplicate the glass.
end

return itemObject
