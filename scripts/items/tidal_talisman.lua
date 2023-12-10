-----------------------------------
-- ID: 11290
-- Item: tidal talisman
-----------------------------------
require('scripts/globals/teleports')
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local zoneId = target:getZoneID()
    local destZoneData = xi.teleport.tidalDestinations[zoneId]

    if
        destZoneData and
        target:hasVisitedZone(destZoneData[5])
    then
        return 0
    end

    return 56
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.TIDAL_TALISMAN, 0, 4)
end

return itemObject
