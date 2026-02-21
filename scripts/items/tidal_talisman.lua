-----------------------------------
-- ID: 11290
-- Item: tidal talisman
-----------------------------------
require('scripts/globals/teleports')
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
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

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.TIDAL_TALISMAN, duration = 4, origin = user, icon = 0 })
end

return itemObject
