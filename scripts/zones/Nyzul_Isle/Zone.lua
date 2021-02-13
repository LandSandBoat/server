-----------------------------------
--
-- Zone: Nyzul_Isle
--
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/missions")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
end

zone_object.onInstanceZoneIn = function(player, instance)
    local cs = -1

    local pos = player:getPos()
    if (pos.x == 0 and pos.y == 0 and pos.z == 0) then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end
    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.PATH_OF_DARKNESS) then
        cs = 51
    end

    player:addTempItem(5348)

    return cs
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)

    if csid == 1 then
        player:setPos(0, 0, 0, 0, 72)
    end
end

zone_object.onInstanceLoadFailed = function()
    return 72
end

return zone_object
