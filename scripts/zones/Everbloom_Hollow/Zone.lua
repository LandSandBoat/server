-----------------------------------
-- Zone: Everbloom_Hollow
-- !zone 86
-----------------------------------
local ID = require('scripts/zones/Everbloom_Hollow/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    local cs = -1

    if not player:getInstance() then
        player:setPos(-34.2, -16, 58, 32, xi.zone.BATALLIA_DOWNS_S)
    end

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    return cs
end

zoneObject.onRegionEnter = function(player, region)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

zoneObject.onInstanceLoadFailed = function()
    return xi.zone.BATALLIA_DOWNS_S
end

return zoneObject
